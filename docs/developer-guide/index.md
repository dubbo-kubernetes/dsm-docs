# 开发者指南

欢迎来到 DSM 开发者指南。本指南将帮助你了解如何为 DSM 做出贡献。

## 开发环境设置

### 前置要求

- Node.js 16.x 或更高版本
- Git
- 代码编辑器（推荐 VS Code）

### 克隆仓库

```bash
git clone https://github.com/yourusername/dsm.git
cd dsm
```

### 安装依赖

```bash
npm install
```

### 启动开发服务器

```bash
npm run dev
```

## 项目结构

```
dsm/
├── src/
│   ├── api/          # API 路由
│   ├── models/       # 数据模型
│   ├── services/     # 业务逻辑
│   ├── utils/        # 工具函数
│   └── index.js      # 入口文件
├── tests/            # 测试文件
├── docs/             # 文档
└── package.json
```

## 编码规范

我们使用 ESLint 和 Prettier 来保持代码风格一致。

运行 linter：

```bash
npm run lint
```

自动修复：

```bash
npm run lint:fix
```

## 测试

运行所有测试：

```bash
npm test
```

运行特定测试：

```bash
npm test -- --grep "test name"
```

查看测试覆盖率：

```bash
npm run test:coverage
```

## 提交代码

我们使用 Conventional Commits 规范：

```bash
git commit -m "feat: add new feature"
git commit -m "fix: resolve bug"
git commit -m "docs: update documentation"
```

## 下一步

- 查看 [API 参考](api.md)了解详细的 API 文档
- 阅读贡献指南了解如何提交 PR

