Job Scheduler Waiting runs a named Job Scheduler scheduler in a continuous, never-timing-out loop (via a long-running process such as supervisord) instead of waiting for periodic cron runs.

---

This submodule targets schedulers whose jobs should be picked up as soon as they are due rather than on the next cron tick. It ships a long-running worker: `job_scheduler_waiting_perform_job($name)` calls `\Drupal::service('job_scheduler.manager')->perform($name)` in an infinite `while (TRUE)` loop with `set_time_limit(0)`, sleeping ~1s between empty passes and rebuilding the container after any batch. It is intended to be run as a supervised process — the module includes a `misc/worker` shell script and a `misc/drupal.supervisord.conf` template (one `[program:...]` per waiting job, parameterised by `DRUSH_COMMAND` and `JOB_NAME`). The module registers its worker as a legacy Drush 8-style command (`job-scheduler-waiting-perform`, alias `jswp`) in `job_scheduler_waiting.drush.inc`; note that legacy `.drush.inc` command files are not loaded by modern Drush (10+), so on a current site you invoke the underlying loop from your own process/script rather than relying on that alias. Functionally each loop iteration is exactly one `perform($name)` — the same dispatch logic cron uses, just run continuously for one scheduler.

---

- Process a scheduler's jobs the moment they become due, without waiting for the next cron run.
- Run a dedicated always-on worker per queue-like scheduler under supervisord.
- Drive near-real-time background processing for a specific Job Scheduler name.
- Keep a worker alive with `set_time_limit(0)` for long-running or high-frequency jobs.
- Use the bundled `misc/drupal.supervisord.conf` template to define one program per waiting job.
- Point the `misc/worker` script's `JOB_NAME`/`DRUSH_COMMAND` env vars at a specific scheduler.
- Rebuild the service container between batches to avoid stale state in a long-lived process.
- Offload time-sensitive scheduled tasks (e.g. immediate imports) from the shared cron cycle.
- Complement periodic cron: cron handles the rest while this worker focuses on one hot scheduler.
- Continuously perform a single named scheduler's due jobs in a loop.
- Autostart/autorestart a Drupal job worker as a managed OS service.
- Scale processing by running multiple supervised worker programs for different job names.
- Reduce latency between a job's `next` timestamp and its execution.
- Provide a daemon-style execution model on top of Job Scheduler's cron-based API.
- Isolate a heavy or blocking scheduler into its own process rather than the cron run.
