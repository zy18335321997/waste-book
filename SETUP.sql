-- ============================================
-- 废品记账系统 - Supabase 数据库初始化
-- 在 Supabase SQL Editor 中执行此文件
-- ============================================

-- 1. 废品捡拾记录
CREATE TABLE waste_records (
  id BIGSERIAL PRIMARY KEY,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  waste_type TEXT NOT NULL,
  quantity NUMERIC NOT NULL,
  unit TEXT NOT NULL DEFAULT '斤',
  photo_url TEXT DEFAULT '',
  sold BOOLEAN DEFAULT FALSE,
  sale_id BIGINT DEFAULT NULL,
  notes TEXT DEFAULT ''
);

-- 2. 废品卖出记录
CREATE TABLE waste_sales (
  id BIGSERIAL PRIMARY KEY,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  total_amount NUMERIC NOT NULL,
  notes TEXT DEFAULT ''
);

-- 3. 日常支出
CREATE TABLE expenses (
  id BIGSERIAL PRIMARY KEY,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  category TEXT NOT NULL,
  amount NUMERIC NOT NULL,
  notes TEXT DEFAULT ''
);

-- 4. 工资收入
CREATE TABLE salary_records (
  id BIGSERIAL PRIMARY KEY,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  amount NUMERIC NOT NULL,
  month TEXT NOT NULL,
  notes TEXT DEFAULT ''
);

-- ========== RLS 策略（匿名访问，只需要能读写） ==========

ALTER TABLE waste_records ENABLE ROW LEVEL SECURITY;
ALTER TABLE waste_sales ENABLE ROW LEVEL SECURITY;
ALTER TABLE expenses ENABLE ROW LEVEL SECURITY;
ALTER TABLE salary_records ENABLE ROW LEVEL SECURITY;

-- 允许 anon 角色全量读写（这是家庭记账，没有多用户隔离需求）
CREATE POLICY "anon_all_waste_records" ON waste_records FOR ALL TO anon USING (true) WITH CHECK (true);
CREATE POLICY "anon_all_waste_sales" ON waste_sales FOR ALL TO anon USING (true) WITH CHECK (true);
CREATE POLICY "anon_all_expenses" ON expenses FOR ALL TO anon USING (true) WITH CHECK (true);
CREATE POLICY "anon_all_salary_records" ON salary_records FOR ALL TO anon USING (true) WITH CHECK (true);

-- ========== 创建 Storage Bucket 用于废品照片 ==========
-- 这步需要在 Supabase Dashboard > Storage 中手动创建 bucket，名称: waste-photos
-- 然后在 bucket 的 Policies 中添加:
--   INSERT: 允许 anon
--   SELECT: 允许 anon
