#!/bin/bash
SERVICES=("nginx" "mysqld" "redis")
DATE=$(date '+%Y-%m-%d %H:%M:%S')

for svc in "${SERVICES[@]}"; do
  if ! systemctl is-active --quiet $svc; then
    echo "[$DATE] 警告：$svc 已停止，正在重启..."
    systemctl restart $svc
    sleep 3
    if systemctl is-active --quiet $svc; then
      echo "[$DATE] $svc 重启成功"
    else
      echo "[$DATE] 错误：$svc 重启失败，请手动处理！"
    fi
  fi
done
