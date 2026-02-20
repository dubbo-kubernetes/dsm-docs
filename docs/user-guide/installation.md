# 安装指南

本指南将帮助你在不同平台上安装 DSM。

## 系统要求

### 最低要求

- CPU: 2 核心
- 内存: 4GB RAM
- 磁盘: 10GB 可用空间
- 操作系统: Linux, macOS, 或 Windows

### 推荐配置

- CPU: 4 核心或更多
- 内存: 8GB RAM 或更多
- 磁盘: 20GB 可用空间（SSD 推荐）

## 使用 npm 安装

```bash
npm install -g dsm-cli
```

验证安装：

```bash
dsm --version
```

## 使用 Docker 安装

拉取 Docker 镜像：

```bash
docker pull dsm/dsm:latest
```

运行容器：

```bash
docker run -d \
  --name dsm \
  -p 8080:8080 \
  -v dsm-data:/data \
  dsm/dsm:latest
```

## 从源码安装

克隆仓库：

```bash
git clone https://github.com/yourusername/dsm.git
cd dsm
```

安装依赖：

```bash
npm install
```

构建项目：

```bash
npm run build
```

启动服务：

```bash
npm start
```

## 下一步

安装完成后，请查看[配置指南](configuration.md)进行系统配置。

