# 常见问题

## 一般问题

### 什么是 DSM？

DSM 是一个现代化的文档管理系统，提供了强大的功能和优雅的用户界面。

### DSM 支持哪些平台？

DSM 支持以下平台：

- Linux (Ubuntu, CentOS, Debian)
- macOS
- Windows
- Docker 容器

## 安装问题

### 如何安装 DSM？

请参考[快速开始指南](getting-started.md)中的安装步骤。

### 安装时遇到依赖问题怎么办？

尝试清除缓存并重新安装：

```bash
npm cache clean --force
rm -rf node_modules
npm install
```

## 配置问题

### 如何修改默认端口？

在 `config.yaml` 文件中修改端口配置：

```yaml
server:
  port: 3000  # 修改为你想要的端口
```

### 如何配置数据库连接？

编辑配置文件中的数据库部分：

```yaml
database:
  type: postgresql
  host: your-db-host
  port: 5432
  name: your-db-name
  username: your-username
  password: your-password
```

## 使用问题

### 如何备份数据？

使用内置的备份命令：

```bash
dsm backup --output /path/to/backup
```

### 如何恢复数据？

使用恢复命令：

```bash
dsm restore --input /path/to/backup
```

## 性能问题

### 如何优化性能？

1. 启用缓存
2. 增加工作进程数
3. 使用 CDN 加速静态资源
4. 优化数据库查询

示例配置：

```yaml
performance:
  cache:
    enabled: true
    ttl: 3600
  workers: 4
  compression: true
```

## 故障排除

### 服务无法启动

检查日志文件：

```bash
tail -f logs/dsm.log
```

常见原因：

- 端口被占用
- 配置文件格式错误
- 数据库连接失败

### 如何启用调试模式？

在配置文件中设置：

```yaml
logging:
  level: debug
```

或使用环境变量：

```bash
DEBUG=true npm start
```

## 更多帮助

如果以上内容没有解决你的问题，请：

- 查看[用户指南](user-guide/index.md)
- 访问 [GitHub Issues](https://github.com/yourusername/dsm/issues)
- 加入我们的社区讨论

