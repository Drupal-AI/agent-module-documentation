# Configuration

Optimize Database Tables keeps its configuration minimal — you choose *what* to
optimize and then run it. Everything lives on one page.

## Before you start

- **Take a fresh database backup.** Optimization rewrites tables; always have a
  recent backup before running database maintenance.
- **Pick a low‑traffic window.** On large tables the operation can lock or rebuild
  the table temporarily, which can briefly affect the site's availability.
- **Restrict access.** The module provides its own permission for running
  optimization — grant it only to trusted administrators under **People →
  Permissions**, since it performs a direct, potentially disruptive database
  operation.

## Open the settings form

1. Log in as a user with the module's optimization permission (an administrator by
   default).
2. Go to **Configuration → System → Optimize Database Tables**, or navigate directly
   to `/admin/config/system/database_optimize_tables`.

## Choose what to optimize

The form offers a simple choice:

- **All tables** — optimize every table in the site's database. The straightforward
  option for routine, whole‑database maintenance.
- **A selected list of tables** — maintain a specific list and optimize only those.
  Use this when only certain tables (for example a large cache, log, or
  high‑churn content table) need attention, so you avoid touching everything.

## Run the optimization

Start the run from the form. The module uses Drupal's **Batch API**, so it processes
the work in chunks with a progress indicator and stays resilient to PHP timeouts on
big tables. When it finishes, it shows a summary: the **total size before and
after**, and the **amount of space reclaimed**.

## Running from the command line (Drush)

If you prefer the command line — or want to run optimization from a scheduled
maintenance job during off‑peak hours — use the bundled Drush command:

```bash
drush optimize_database_tables:run
```

```bash
# Shorter alias
drush optimize-dbt:run
```

```bash
# Show per-table details as it runs
drush optimize-dbt:run --details
```

The command shows a progress bar and, with `--details`, reports on each table as it
goes.
