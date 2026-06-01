from flask import Flask
import pymysql
import redis
import os

app = Flask(__name__)

# 连接 Redis
r = redis.Redis(host='redis', port=6379)

# 连接 MySQL
def get_db():
    return pymysql.connect(
        host='mysql',
        user='myuser',
        password='mypass',
        database='mydb'
    )

# 接口1：首页
@app.route('/')
def index():
    return 'Hello! 项目运行正常'

# 接口2：测试 MySQL
@app.route('/db')
def db_test():
    conn = get_db()
    cursor = conn.cursor()
    cursor.execute('SELECT VERSION()')
    result = cursor.fetchone()
    conn.close()
    return f'MySQL 版本：{result[0]}'

# 接口3：测试 Redis
@app.route('/cache')
def cache_test():
    r.set('key', 'Redis连接成功')
    value = r.get('key').decode('utf-8')
    return f'Redis 返回：{value}'

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
