CREATE TABLE IF NOT EXISTS request_logs_get (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    url TEXT NOT NULL,
    name_parameter TEXT,
    response_status INTEGER NOT NULL,
    response_text TEXT NOT NULL,
    timestamp DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS request_logs_post (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    url TEXT NOT NULL,
    name_parameter TEXT NOT NULL,
    response_status INTEGER NOT NULL,
    response_text TEXT NOT NULL,
    timestamp DATETIME DEFAULT CURRENT_TIMESTAMP
);
