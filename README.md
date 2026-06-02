# DevOps 实战项目

## 项目简介
使用 Docker Compose 编排多容器应用，包含 Nginx + Flask + MySQL + Redis 完整架构。

## 技术栈
- Nginx 1.24 — 反向代理
- Flask — Python Web 应用
- MySQL 5.7 — 数据库，数据卷持久化
- Redis 6.2 — 缓存
- Docker Compose — 容器编排
- Shell — 自动化脚本

## 项目结构
ops-project/
├── docker-compose.yml
├── nginx/
│ └── nginx.conf
├── app/
│ ├── Dockerfile
│ ├── app.py
│ └── requirements.txt
└── 剧本/
├—— start.sh
└── stop.sh

## 快速启动
```bash
bash scripts/start.sh
```

## 访问接口
| 接口 | 说明 |
|------|------|
| http://localhost/ | 首页 |
| http://localhost/db | 测试 MySQL |
| http://localhost/cache | 测试 Redis |

## 停止服务
```bash
bash scripts/stop.sh
```
