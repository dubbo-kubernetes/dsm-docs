# 快速开始

本指南将帮助你快速开始使用 DSM。

## 安装

### 前置要求

在开始之前，请确保你的系统满足以下要求：

- Node.js 16.x 或更高版本
- npm 或 yarn 包管理器
- Git

### 安装步骤

1. 克隆仓库：

```bash
git clone https://github.com/yourusername/dsm.git
cd dsm
```

2. 安装依赖：

```bash
npm install
```

3. 启动开发服务器：

```bash
npm run dev
```

## 基本配置

创建配置文件 `config.yaml`：

```yaml
# DSM Configuration
server:
  host: localhost
  port: 8080
  
database:
  type: postgresql
  host: localhost
  port: 5432
  name: dsm_db
  
logging:
  level: info
  format: json
```

## 第一个示例

这是一个简单的使用示例：

```python
from dsm import Client

# 创建客户端实例
client = Client(
    host='localhost',
    port=8080,
    api_key='your-api-key'
)

# 连接到服务器
client.connect()

# 执行操作
result = client.execute('hello')
print(result)

# 关闭连接
client.disconnect()
```

## 下一步

- 查看[用户指南](user-guide/index.md)了解更多功能
- 阅读[开发者指南](developer-guide/index.md)学习如何扩展 DSM
- 浏览[API 参考](developer-guide/api.md)了解详细的 API 文档

!!! tip "提示"
    建议先阅读用户指南中的核心概念部分，这将帮助你更好地理解 DSM 的工作原理。

!!! warning "注意"
    在生产环境中使用前，请确保正确配置安全设置。

