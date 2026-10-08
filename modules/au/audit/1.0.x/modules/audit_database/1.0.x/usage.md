Scores database health: total/table sizes, missing primary keys, fragmentation, and logging config.

---

Registers the `database` analyzer (`DatabaseAnalyzer`, weight 3, MySQL/MariaDB focus). It queries `information_schema` (parameterized on the DB name) for total database size and per-table sizes, flags tables over `table_size_threshold` (100 MB) and databases over `database_size_threshold` (1000 MB), detects tables without a primary key, table fragmentation, leftover deleted-field tables, cache-backend and dblog logging configuration, and lists a full table inventory. `ignore_cache_backend_warnings` / `ignore_dblog_warnings` suppress those score penalties.

---

- Report total database size and flag it over `database_size_threshold` (1000 MB).
- List the largest tables and flag any over `table_size_threshold` (100 MB).
- Detect base tables missing a PRIMARY KEY (replication/performance risk).
- Find leftover `deleted field data` tables and table fragmentation.
- Review cache-backend and dblog logging configuration.
- Suppress external-cache warnings with `ignore_cache_backend_warnings` on small sites.
- Suppress dblog warnings with `ignore_dblog_warnings` when syslog is not used.
- All queries are parameterized against `information_schema` — no SQL injection surface.
- Weight 3 by default in the Project Score.
