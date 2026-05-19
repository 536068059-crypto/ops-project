#!/bin/bash
DB_USER="root"
DB_PASS="Aa123456."
BACKUP_DIR="/data/backup/mysql"
DATE=$(date +%Y%m%d_%H%M%S)
KEEP_DAYS=7
mkdir -p $BACKUP_DIR
#备份所有数据库
mysqldump -u$DB_USER -p$DB_PASS --all-databases \
 --single-transaction --quick \
 |gzip >$BACKUP_DIR/all_db_$DATE.sql.gz
#删除超过10天的备份
find $DACKUP_DIR -name "*.sql.gz" -mtime +$KEEP_DAYS -delete
echo "[$DATE]备份完成：$BACKUP_DIR/all_db_$DATE.sql.gz"
