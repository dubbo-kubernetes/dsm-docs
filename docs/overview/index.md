> 目前服务网格处于初步实验阶段。后续标准功能将逐步完善和支持。

Dubbo Service Mesh（DSM）是通过 xDS 协议实现的控制平面网格模型，该模型没有额外代理转发开销。

- 每个已部署的应用程序都会注入 Dubbo-Agent 提供 XDS 和 SDS 服务。
- 所有注入的代理均使用 Kubernetes Gateway API 实现服务与外部系统之间的通信。

转到 Dubbo 发布页面，自动下载适用于您操作系统的安装文件并获取最新版本（Linux 或 macOS）：
```bash
curl -L https://dubbo.apache.org/downloadDubbo | sh -
```

转到 Dubbo 包目录
```bash
cd dubbo-0.3.5
```

使用 default 配置文件安装 Dubbo
```bash
dubboctl install --set profile=default
```

