# Drush commands

Registered via `drush.services.yml` (service `performance_profiler.commands`,
`Commands\PerformanceProfilerCommands`, args `@messenger`, `@performance_profiler.benchmark`,
`@performance_profiler.database_actions`). Both commands print their results through the messenger.

| Command | Alias | Method | What it does |
|---|---|---|---|
| `pp-php` | `pp-php` | `benchmark()` | Runs the PHP micro-benchmark via `performance_profiler.benchmark`→`run()` (math, string, loop, if-else) and prints each timing plus the total. |
| `pp-db` | `pp-db` | `benchmarkDatabase()` | Runs the full DB benchmark via `performance_profiler.database_actions`→`run()`: drop→create→fill (10 000 rows/table)→query→drop of the `performance_profiler_db_test_*` tables, printing per-phase timings. |

```bash
ddev drush pp-php
ddev drush pp-db
```

`pp-db` creates, fills and drops real tables in the site's database — run it on dev/staging, not
production. Neither command changes module configuration.
