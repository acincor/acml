-- 数据表 --
CREATE TABLE IF NOT EXISTS "T_Status" (
    "status" TEXT,
    "create_at" TEXT,
    "cellBody" TEXT,
    "createTime" TEXT DEFAULT (datetime('now', 'localtime')),
    PRIMARY KEY("cellBody")
);
