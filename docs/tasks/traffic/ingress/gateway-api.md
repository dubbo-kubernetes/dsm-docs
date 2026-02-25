# Kubernetes Gateway API
本示例演示如何使用 DSM 部署支持的 httpbin 服务，并通过 Gateway API 进行访问。

## 先决条件
默认情况下不会安装 Gateway API。如果 Gateway API CRD 不存在，请安装：
```bash
kubectl get crd gateways.gateway.networking.k8s.io &> /dev/null || \
  { kubectl kustomize "github.com/kubernetes-sigs/gateway-api/config/crd?ref=v1.4.0" | kubectl apply -f -; }
```

## 创建服务
```bash
kubectl create -f https://raw.githubusercontent.com/apache/dubbo-kubernetes/master/samples/httpbin/httpbin.yaml
```

## 创建网关
```yaml
kubectl create namespace dubbo-ingress
kubectl apply -f - <<EOF
apiVersion: gateway.networking.k8s.io/v1
kind: Gateway
metadata:
  name: gateway
  namespace: dubbo-ingress
spec:
  gatewayClassName: dubbo
  listeners:
  - name: default
    hostname: "*.example.com"
    port: 80
    protocol: HTTP
    allowedRoutes:
      namespaces:
        from: All
---
apiVersion: gateway.networking.k8s.io/v1
kind: HTTPRoute
metadata:
  name: http
  namespace: default
spec:
  parentRefs:
  - name: gateway
    namespace: dubbo-ingress
  hostnames: ["httpbin.example.com"]
  rules:
  - matches:
    - path:
        type: PathPrefix
        value: /get
    backendRefs:
    - name: httpbin
      port: 8000
EOF
```

## 测试服务
```bash
NODE_IP=$(kubectl get nodes -o jsonpath='{.items[0].status.addresses[?(@.type=="InternalIP")].address}')
SVC_PORT=$(kubectl get svc gateway-dubbo -n dubbo-ingress -o jsonpath='{.spec.ports[?(@.port==80)].nodePort}')
curl -s -I -HHost:httpbin.example.com "http://$NODE_IP:$SVC_PORT/get"
```

## 清理
```bash
kubectl delete httproute http
kubectl delete gateways.gateway.networking.k8s.io gateway -n dubbo-ingress
kubectl delete ns dubbo-ingress
```