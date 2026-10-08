# Job Scheduler Waiting — agent index

Runs one Job Scheduler scheduler continuously in a long-running process instead of on cron. Thin
glue on top of `job_scheduler`. No config, no config route, no permissions.

- **The worker loop, the supervisord setup, and the legacy Drush command** →
  [api/worker.md](api/worker.md)

Key facts:
- Core action per loop iteration = `\Drupal::service('job_scheduler.manager')->perform($name)`
  (same dispatch as cron; see the parent module's `api/scheduler-service.md`).
- Function: `job_scheduler_waiting_perform_job($name)` — infinite loop, `set_time_limit(0)`, sleeps ~1s.
- Legacy command `job-scheduler-waiting-perform` / alias `jswp` lives in a `.drush.inc` file, which
  **modern Drush does not load** — drive the loop from your own supervised process instead.
- Ships `misc/worker` (shell) and `misc/drupal.supervisord.conf` (one program per waiting job).
