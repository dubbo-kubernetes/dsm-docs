# 用户指南

欢迎来到 DSM 用户指南。本指南将帮助你了解和使用 DSM 的各项功能。

## 概述

DSM 提供了一套完整的文档管理解决方案，包括：

- 📝 文档创建和编辑
- 🔍 全文搜索
- 👥 协作功能
- 🔐 权限管理
- 📊 数据分析

## 核心概念

### 项目

项目是 DSM 中的顶层组织单位。每个项目可以包含多个文档和资源。

```python
# 创建新项目
project = dsm.create_project(
    name="My Project",
    description="Project description"
)
```

### 文档

文档是 DSM 中的基本内容单位。支持多种格式：

- Markdown
- HTML
- Plain Text
- Rich Text

### 权限

DSM 提供细粒度的权限控制：

| 权限 | 说明 |
|------|------|
| Read | 读取权限 |
| Write | 写入权限 |
| Admin | 管理员权限 |
| Owner | 所有者权限 |

## 基本操作

### 创建文档

```javascript
const doc = await dsm.createDocument({
  title: 'My Document',
  content: 'Document content here',
  tags: ['tutorial', 'guide']
});
```

### 搜索文档

```python
# 全文搜索
results = dsm.search(
    query="keyword",
    filters={
        "tags": ["tutorial"],
        "created_after": "2024-01-01"
    }
)
```

### 分享文档

```bash
# 生成分享链接
dsm share --doc-id 12345 --expires 7d
```

## 高级功能

### 版本控制

DSM 自动跟踪文档的所有变更：

```python
# 查看文档历史
history = doc.get_history()

# 恢复到特定版本
doc.restore_version(version_id=5)
```

### 协作编辑

多人可以同时编辑同一文档：

```javascript
// 加入协作会话
const session = await doc.joinCollaboration();

// 监听其他用户的更改
session.on('change', (change) => {
  console.log('Document updated by:', change.user);
});
```

### 自动化工作流

使用 Webhooks 实现自动化：

```yaml
webhooks:
  - name: notify-on-update
    event: document.updated
    url: https://your-server.com/webhook
    headers:
      Authorization: Bearer your-token
```

## 最佳实践

!!! tip "组织结构"
    建议使用清晰的项目和文档层次结构，便于管理和查找。

!!! warning "权限管理"
    定期审查和更新权限设置，确保数据安全。

!!! info "备份策略"
    建立定期备份机制，防止数据丢失。

## 下一步

- [安装指南](installation.md)
- [配置说明](configuration.md)
- [API 参考](../developer-guide/api.md)

