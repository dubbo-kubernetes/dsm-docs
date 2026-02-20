#!/bin/bash

# DSM 文档网站启动脚本

echo "🚀 启动 DSM 文档网站..."
echo ""

# 进入项目目录
cd "$(dirname "$0")"

# 检查端口是否被占用
PORT=8080
if lsof -Pi :$PORT -sTCP:LISTEN -t >/dev/null ; then
    echo "⚠️  端口 $PORT 已被占用，尝试使用端口 8081..."
    PORT=8081
fi

# 构建文档
echo "📦 构建文档..."
python3 -m mkdocs build

# 启动服务器
echo "✅ 文档构建完成！"
echo ""
echo "🌐 启动开发服务器..."
echo "📍 访问地址: http://127.0.0.1:$PORT"
echo ""
echo "按 Ctrl+C 停止服务器"
echo ""

cd site && python3 -m http.server $PORT

