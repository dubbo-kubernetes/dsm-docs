# 启动文档服务器

你可以使用以下命令启动文档服务器：

```bash
cd /Users/mfordjody/laboratory/opensource/dsm-docs
python3 -m mkdocs serve
```

如果遇到权限问题，可以尝试使用不同的端口：

```bash
python3 -m mkdocs serve -a 127.0.0.1:8080
```

或者直接使用 Python 的 HTTP 服务器查看构建好的静态网站：

```bash
cd site
python3 -m http.server 8080
```

然后在浏览器中访问 `http://127.0.0.1:8080`

