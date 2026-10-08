Database Dashboard adds a read-only admin report at `/admin/reports/database` that shows your Drupal database size and the largest tables by size and by row count.

---

The module registers a single controller route under Reports that queries MySQL/MariaDB `information_schema` and renders five cards: total database size in GB, the top-20 tables by size, the top-20 tables by row count, and the same two views restricted to the `cache*` tables. Sizes are read via `SUM(data_length + index_length)` and formatted as MB/GB; row counts come from `information_schema.TABLES.TABLE_ROWS` (an engine estimate for InnoDB). All schema queries run over a *second* database connection keyed `schema` that the administrator must add to `settings.php` (pointing at the `information_schema` database on the same MySQL/MariaDB server); without that connection the page errors. Output is uncached (`max-age = 0`) so it always reflects the current schema. The module ships only a controller, a `hook_theme()` implementation, a Twig template and a CSS library — no config forms, no entities, no plugins, no Drush commands. Depends on the core `mysql` module.

---

- Get a quick overview of your Drupal database's total on-disk size in GB.
- Identify the twenty largest tables by size to target for cleanup or archiving.
- Identify the twenty tables with the most rows to spot runaway growth.
- See at a glance how much space the `cache*` tables consume.
- Check how many rows the cache tables hold before deciding to truncate them.
- Do lightweight capacity monitoring of a site database without external tooling.
- Diagnose which table is bloating a database after a spike in disk usage.
- Confirm the effect of a `drush cache:rebuild` or cache-table truncation by re-loading the report.
- Spot oversized log/watchdog or queue tables from the size ranking.
- Give a client or stakeholder a simple visual of database growth over time (by revisiting the page).
- Support a "why is my database so large?" investigation during a performance audit.
- Decide whether a table warrants partitioning or archiving based on its row count.
- Sanity-check that a batch import or migration populated the expected tables.
- Verify that a module uninstall actually dropped or emptied its tables.
- Compare table sizes before and after enabling a heavy module.
- Provide developers a self-service database size view instead of shell access to MySQL.
- Detect that cache tables have grown unusually large (a symptom of an ineffective cache backend).
- Include a database-size glance in a routine site-health check.
- Estimate backup size implications from the reported total database size.
- Surface the biggest tables to plan an information_schema-based maintenance script.
