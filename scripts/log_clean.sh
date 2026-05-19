#!/bin/bash
LOG_DIRS=("/var/log/nginx" "/var/log/mysql")
KEEP_DAYS=30
DATE=$(date +%Y%m%d)

for dir in "${LOG_DIRS[@]}"; do
  if [ -d "$dir" ]; then
    # 删除超期日志
    find $dir -name "*.log*" -mtime +$KEEP_DAYS -delete
    # 压缩7天前的日志
    find $dir -name "*.log" -mtime +7 ! -name "*.gz" -exec gzip {} \;
    echo "[$DATE] 已处理目录：$dir"
  fi
done

# 检查磁盘使用率，超过80%发出警告
DISK_USE=$(df / | awk 'NR==2{print $5}' | tr -d '%')
if [ $DISK_USE -gt 80 ]; then
  echo "警告：磁盘使用率 ${DISK_USE}%，请及时处理！"
fi
