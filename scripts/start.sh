  #!/bin/bash
  set -euo pipefail

  echo "==============="
  echo "启动 DevOps 项目"
  echo "==============="

  # 检查依赖
  command -v docker &> /dev/null || { echo "错误：Docker 未安装"; exit 1; }
  docker compose version &> /dev/null || { echo "错误：docker compose 插件未安装"; exit 1; }
  [ -f docker-compose.yml ] || [ -f docker-compose.yaml ] || { echo "错误：未找到 compose 文件"; exit 1; }

  echo "✓ 环境检查通过"

  # 构建并启动
  echo "正在构建并启动所有服务..."
  docker compose up -d --build || { echo "错误：启动失败"; exit 1; }

  # 等待服务就绪
  echo "等待服务就绪..."
  for i in $(seq 1 30); do
    if curl -sf http://localhost:5000/ > /dev/null 2>&1; then
      echo "✓ 服务已就绪"
      break
    fi
    [ "$i" -eq 30 ] && { echo "错误：服务启动超时"; docker compose ps; exit 1; }
    sleep 2
  done

  # 服务状态
  echo ""
  echo "容器状态："
  docker compose ps

  # 接口测试
  echo ""
  echo "接口测试："
  for path in "/" "/db" "/cache"; do
    if curl -sf "http://localhost:5000${path}" > /dev/null; then
      echo "  ✓ ${path}"
    else
      echo "  ✗ ${path} 异常"
    fi
  done

  echo ""
  echo "==============="
  echo " 启动完成！访问 http://localhost"
  echo "==============="
