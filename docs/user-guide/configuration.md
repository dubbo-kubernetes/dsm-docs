# 配置指南

本指南介绍如何配置 DSM。

## 配置文件

DSM 使用 YAML 格式的配置文件。默认配置文件位于 `config.yaml`。

## 基本配置

```yaml
# 服务器配置
server:
  host: 0.0.0.0
  port: 8080
  ssl:
    enabled: false
    cert: /path/to/cert.pem
    key: /path/to/key.pem

# 数据库配置
database:
  type: postgresql
  host: localhost
  port: 5432
  name: dsm
  username: dsm_user
  password: your_password
  pool:
    min: 2
    max: 10

# 日志配置
logging:
  level: info
  format: json
  output: stdout
```

## 高级配置

### 缓存配置

```yaml
cache:
  enabled: true
  type: redis
  host: localhost
  port: 6379
  ttl: 3600
```

### 认证配置

```yaml
auth:
  jwt:
    secret: your-secret-key
    expiry: 24h
  oauth:
    enabled: true
    providers:
      - name: github
        client_id: your-client-id
        client_secret: your-client-secret
```

## 环境变量

你也可以使用环境变量来覆盖配置：

```bash
export DSM_SERVER_PORT=3000
export DSM_DATABASE_HOST=db.example.com
export DSM_LOG_LEVEL=debug
```

## 验证配置

验证配置文件是否正确：

```bash
dsm config validate
```

