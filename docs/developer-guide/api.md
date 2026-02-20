# API 参考

DSM 提供了完整的 RESTful API。

## 认证

所有 API 请求都需要认证。在请求头中包含你的 API 密钥：

```bash
curl -H "Authorization: Bearer YOUR_API_KEY" \
  https://api.dsm.example.com/v1/documents
```

## 端点

### 文档

#### 获取所有文档

```http
GET /api/v1/documents
```

响应示例：

```json
{
  "data": [
    {
      "id": "123",
      "title": "Document Title",
      "content": "Document content...",
      "created_at": "2024-01-01T00:00:00Z"
    }
  ],
  "total": 1
}
```

#### 创建文档

```http
POST /api/v1/documents
```

请求体：

```json
{
  "title": "New Document",
  "content": "Document content",
  "tags": ["tag1", "tag2"]
}
```

#### 更新文档

```http
PUT /api/v1/documents/:id
```

#### 删除文档

```http
DELETE /api/v1/documents/:id
```

### 搜索

#### 搜索文档

```http
GET /api/v1/search?q=keyword
```

查询参数：

- `q`: 搜索关键词
- `limit`: 结果数量限制（默认 10）
- `offset`: 偏移量（默认 0）

## SDK

### JavaScript/TypeScript

```javascript
import { DSMClient } from 'dsm-sdk';

const client = new DSMClient({
  apiKey: 'YOUR_API_KEY',
  baseURL: 'https://api.dsm.example.com'
});

// 获取文档
const docs = await client.documents.list();

// 创建文档
const doc = await client.documents.create({
  title: 'New Document',
  content: 'Content here'
});
```

### Python

```python
from dsm import Client

client = Client(api_key='YOUR_API_KEY')

# 获取文档
docs = client.documents.list()

# 创建文档
doc = client.documents.create(
    title='New Document',
    content='Content here'
)
```

## 错误处理

API 使用标准 HTTP 状态码：

- `200`: 成功
- `400`: 请求错误
- `401`: 未授权
- `404`: 未找到
- `500`: 服务器错误

错误响应格式：

```json
{
  "error": {
    "code": "INVALID_REQUEST",
    "message": "Error description"
  }
}
```

## 速率限制

API 请求受到速率限制：

- 每分钟 60 次请求
- 每小时 1000 次请求

超出限制时返回 `429 Too Many Requests`。

