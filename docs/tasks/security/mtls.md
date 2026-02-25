# 双向 TLS
本示例演示如何使用 DSM 部署支持的 gRPC 应用程序进行双向 TLS。

## 概述

- **提供者**：一个 gRPC 服务器，接收请求（端口 17070），并部署了多个版本（v1/v2），以展示灰色发布场景。
- **消费者**：一个 gRPC 客户端，向提供者服务发送请求，并暴露一个测试服务器（端口 17171），用于通过 grpcurl 管理流量。

这两个服务都使用原生 gRPC xDS 客户端通过 dubbo-proxy 连接到 Dubbo 控制平面，从而实现服务发现、负载均衡和流量管理。

## 前提条件

1. 已安装 Dubbo 控制平面的 Kubernetes 集群
2. 已配置 kubectl 以访问集群
3. grpcurl（可选，用于测试）

## 部署

### 1. 创建命名空间

```bash
kubectl create ns grpc-app
kubectl label namespace grpc-app dubbo-injection=enabled
```

### 2. 部署服务

```bash
kubectl apply -f grpc-app.yaml
```

### 3. 测试服务

```bash
kubectl port-forward -n grpc-app $(kubectl get pod -l app=consumer -n grpc-app -o jsonpath='{.items[0].metadata.name}') 17171:17171
```

```bash
grpcurl -plaintext -d '{"url": "xds:///provider.grpc-app.svc.cluster.local:7070","count": 5}' localhost:17171 echo.EchoTestService/ForwardEcho
```

```json
{
  "output": [
    "[0 body] Hostname=provider-v2-594b6977c8-5gw2z ServiceVersion=v2 Namespace=grpc-app IP=192.168.219.88 ServicePort=17070",
    "[1 body] Hostname=provider-v1-fbb7b9bd9-l8frj ServiceVersion=v1 Namespace=grpc-app IP=192.168.219.119 ServicePort=17070",
    "[2 body] Hostname=provider-v2-594b6977c8-5gw2z ServiceVersion=v2 Namespace=grpc-app IP=192.168.219.88 ServicePort=17070",
    "[3 body] Hostname=provider-v1-fbb7b9bd9-l8frj ServiceVersion=v1 Namespace=grpc-app IP=192.168.219.119 ServicePort=17070",
    "[4 body] Hostname=provider-v2-594b6977c8-5gw2z ServiceVersion=v2 Namespace=grpc-app IP=192.168.219.88 ServicePort=17070"
  ]
}
```

## 启用 mTLS

由于在 gRPC 中启用安全功能需要对应用程序本身进行更改，Dubbo Kubernetes 传统的自动检测 mTLS 支持的方法不再可靠。因此，初始版本要求在客户端和服务器端显式启用 mTLS。

### 启用客户端 mTLS

要启用客户端 mTLS，请应用带有 `tls` 设置的 `DestinationRule`：

```bash
cat <<EOF | kubectl apply -f -
apiVersion: networking.dubbo.apache.org/v1alpha3
kind: DestinationRule
metadata:
  name: provider-mtls
  namespace: grpc-app
spec:
  host: provider.grpc-app.svc.cluster.local
  trafficPolicy:
    tls:
      mode: DUBBO_MUTUAL
EOF
```

现在，尝试调用尚未配置 mTLS 的服务器将会失败：

```bash
grpcurl -plaintext -d '{"url": "xds:///provider.grpc-app.svc.cluster.local:7070","count": 5}' localhost:17171 echo.EchoTestService/ForwardEcho
```

预期错误输出：
```json
{
   "output": [
      "ERROR:\nCode: Unknown\nMessage: 5/5 requests had errors; first error: rpc error: code = Unavailable desc = connection error: desc = \"transport: authentication handshake failed: tls: first record does not look like a TLS handshake\"",
      "[0] Error: rpc error: code = Unavailable desc = connection error: desc = \"transport: authentication handshake failed: tls: first record does not look like a TLS handshake\"",
      "[1] Error: rpc error: code = Unavailable desc = connection error: desc = \"transport: authentication handshake failed: tls: first record does not look like a TLS handshake\"",
      "[2] Error: rpc error: code = Unavailable desc = connection error: desc = \"transport: authentication handshake failed: tls: first record does not look like a TLS handshake\"",
      "[3] Error: rpc error: code = Unavailable desc = connection error: desc = \"transport: authentication handshake failed: tls: first record does not look like a TLS handshake\"",
      "[4] Error: rpc error: code = Unavailable desc = connection error: desc = \"transport: authentication handshake failed: tls: first record does not look like a TLS handshake\""
   ]
}
```

### 启用服务器端 mTLS

要启用服务器端 mTLS，请应用 `PeerAuthentication` 策略。以下策略将强制整个命名空间使用严格的 mTLS：

```bash
cat <<EOF | kubectl apply -f -
apiVersion: security.dubbo.apache.org/v1alpha3
kind: PeerAuthentication
metadata:
  name: provider-mtls
  namespace: grpc-app
spec:
  mtls:
    mode: STRICT
EOF
```

应用该策略后，请求将开始成功：

```bash
grpcurl -plaintext -d '{"url": "xds:///provider.grpc-app.svc.cluster.local:7070","count": 5}' localhost:17171 echo.EchoTestService/ForwardEcho
```

预期成功输出：
```json
{
   "output": [
      "[0 body] Hostname=provider-v2-594b6977c8-5gw2z ServiceVersion=v2 Namespace=grpc-app IP=192.168.219.88 ServicePort=17070",
      "[1 body] Hostname=provider-v2-594b6977c8-5gw2z ServiceVersion=v2 Namespace=grpc-app IP=192.168.219.88 ServicePort=17070",
      "[2 body] Hostname=provider-v2-594b6977c8-5gw2z ServiceVersion=v2 Namespace=grpc-app IP=192.168.219.88 ServicePort=17070",
      "[3 body] Hostname=provider-v2-594b6977c8-5gw2z ServiceVersion=v2 Namespace=grpc-app IP=192.168.219.88 ServicePort=17070",
      "[4 body] Hostname=provider-v1-fbb7b9bd9-l8frj ServiceVersion=v1 Namespace=grpc-app IP=192.168.219.119 ServicePort=17070"
   ]
}
```

