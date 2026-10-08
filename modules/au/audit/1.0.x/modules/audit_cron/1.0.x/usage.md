Scores cron health: last-run recency, queue backlog, and hook_cron/queue-worker implementations.

---

Registers the `cron` analyzer (`CronAnalyzer`, weight 2). It reports whether cron has run recently (stale after `cron_stale_hours`, default 24), lists registered queue workers and flags backlogged queues (over `queue_warning_threshold`, default 100 items), and enumerates `hook_cron` implementations across enabled modules.

---

- Detect that cron has not run within the last `cron_stale_hours` (24) hours.
- Flag queues with a backlog over `queue_warning_threshold` (100) items.
- List every registered QueueWorker plugin.
- Enumerate modules implementing `hook_cron`.
- Gate CI on cron health: `drush audit:run cron --fail-on=error`.
- Adjust staleness/backlog thresholds in the submodule settings.
- Weight 2 by default in the Project Score.
