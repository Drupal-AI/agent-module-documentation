Ultimate Cron replaces Drupal core's monolithic cron with individually scheduled, independently loggable cron jobs that can run in parallel, each with its own timing rules, launcher and log retention.

---

Core Drupal runs every module's `hook_cron()` on a single run with one shared window, so one slow task can block or starve the others. Ultimate Cron turns each cron callback into a discrete **cron job** config entity that you schedule, run, disable, unlock and inspect on its own. Each job is composed from three swappable plugin types: a **scheduler** (Simple presets or full Crontab-style rules like `*/15+@ * * * *`) that decides when the job is due, a **launcher** (serial by default, with lock timeouts and thread/pool limits) that runs it, and a **logger** (database or cache) that records every execution with duration, user and severity. Jobs are auto-discovered from existing `hook_cron()` implementations and queue workers, and additional jobs can be declared as `ultimate_cron.job.*` config with a callback (function, service method, static method, hook, or invokable class). It is still driven by the normal Drupal cron trigger, so you keep using `drush cron` or a system crontab; Ultimate Cron just takes over what actually executes. A per-job admin UI at `admin/config/system/cron/jobs` plus global settings pages let site builders reorder, throttle and monitor tasks, while Drush commands (`cron:list`, `cron:run`, `cron:logs`, `cron:enable/disable/unlock`) cover the same ground from the CLI. Queue workers can optionally be exposed as their own jobs so heavy queues run on a different cadence than the rest of cron.

---

- Split core's single cron run into per-task jobs that fail independently.
- Schedule a specific job to run every 5, 15 or 30 minutes via Simple presets.
- Write full crontab-style rules (`0+@ */6 * * *`) for fine-grained timing.
- Stagger heavy jobs so they don't all fire in the same cron window.
- Run one cron job on demand from the admin UI without running all of cron.
- Trigger a single job from the CLI with `drush cron:run <job>`.
- Force a job to run ignoring its schedule with `drush cron:run <job> --force`.
- Disable a noisy or broken cron job while leaving the rest running.
- Enable or disable all jobs at once with `drush cron:enable/disable --all`.
- Unlock a job whose process crashed and left a stale lock.
- View per-job execution logs with duration, status and messages.
- Inspect logs from the CLI with `drush cron:logs <job> --limit=20`.
- List which jobs are behind schedule with `drush cron:list --behind`.
- Set a maximum execution time and lock timeout per job to cap runaways.
- Cap concurrency with launcher thread/pool limits to avoid overload.
- Choose database logging with retention (keep last N logs / expire after N seconds).
- Choose lightweight cache-based logging for high-frequency jobs.
- Expose individual queue workers as separate jobs to control their cadence.
- Throttle queue processing with a thread count and item threshold.
- Declare extra cron jobs in a module via `config/install` YAML with a custom callback.
- Point a job's callback at a service method, static method or invokable class.
- Auto-discover new cron jobs when modules are installed or caches rebuilt.
- Reorder job execution via weights on the jobs list.
- Replace core's Automated Cron with a reliable external crontab trigger.
- Add a custom scheduler, launcher or logger by implementing the plugin types.
- Hook into a job's lifecycle (pre/post schedule, launch and run) to add behavior.
- Monitor long-running jobs with progress reporting.
- Keep cron reliable on heavily cached sites where Automated Cron misses its window.
- Debug cron by looping `drush cron` and watching which jobs execute.
