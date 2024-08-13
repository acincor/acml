-- 数据表 --
CREATE TABLE IF NOT EXISTS "T_Status" (
    "id" TEXT,
    "status" TEXT,
    "create_at" TEXT,
    "createTime" TEXT DEFAULT (datetime('now', 'localtime')),
    PRIMARY KEY("id")
);
