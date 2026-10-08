<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Smart DB Tools (smart_db_tools) — agent index
**A CLI DbTools application whose dump command splits a DB export into per-table (and paged sub-) PHP scripts.**

- **Version:** 1.2.x (1.2.0)
- **Core:** ^10 || ^11 || ^12
- **Entry point:** `scripts/smart-db-tools.php` — CLI only (`PHP_SAPI !== 'cli'` guard).
- **Command:** `SmartDbDumpCommand` (extends core `DbDumpCommand`) with `--split-destination`, `--subsplit-limit` (default 1000), `--no-generator-comment`, `--file-comment`.
- **Routes / permissions / services / config:** none — developer/testing tool.

**Security:** No web-facing surface; the script hard-refuses non-CLI SAPIs. Dump SQL `SELECT * FROM {table}` uses schema-derived table names (not user input) with integer-cast LIMIT paging — no request-driven SQLi. No security findings.

See [drush/dump.md](drush/dump.md)
