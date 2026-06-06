# ♻️ 废品记账 - 父母专用

一个给父母用的废品记账 PWA，手机打开就能用。

## 部署步骤

### 1. 创建 Supabase 项目
1. 打开 [supabase.com](https://supabase.com)，注册/登录
2. 点击 "New Project"，填名字如 `waste-book`，选免费数据库
3. 记下：**Project URL** 和 **anon public key**

### 2. 建表 & 创建存储
1. 进入 Supabase Dashboard → SQL Editor
2. 复制 `SETUP.sql` 全部内容，粘贴运行
3. 进入 Storage → New Bucket，名称填 `waste-photos`，勾选"公开"
4. 在 `waste-photos` 的 Policies 中，添加两条：
   - INSERT: 允许 `anon`
   - SELECT: 允许 `anon`

### 3. 配置并部署
```bash
# 替换为你的 Supabase 信息
SUPABASE_URL="https://xxxxx.supabase.co"
SUPABASE_KEY="eyJhbGciOi..."

# 写入配置
sed -i '' "s|__SUPABASE_URL__|$SUPABASE_URL|g" index.html
sed -i '' "s|__SUPABASE_ANON_KEY__|$SUPABASE_KEY|g" index.html

# 部署到 Vercel
vercel --prod
```

### 4. 父母使用
1. 把 Vercel 生成的链接发给父母
2. 用手机打开链接
3. Safari/Chrome 中点「添加到主屏幕」
4. 桌面上出现 ♻️ 废品记账 图标，点开就能用！
