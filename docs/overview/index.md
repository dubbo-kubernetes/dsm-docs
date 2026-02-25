# 概述

Dubbo Service Mesh（DSM）是通过 xDS 协议实现的 Dubbo 服务网格模型。该模型不需要代理，控制平面可以直接通过 xDS 向 gRPC 服务下发策略，实现与 gRPC 服务的直接通信。

虽然不使用 proxy 进行数据平面通信，但仍然需要一个 agent 负责初始化，并与控制平面进行通信。

## 架构概览

<p align="center">
  <img src="../static/architecture.svg" width="550">
</p>

> 目前处于初步设计实验阶段。后续标准功能会逐步完善和支持。
