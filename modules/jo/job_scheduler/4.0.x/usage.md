Job Scheduler is a developer API for scheduling tasks to run once at a future time or periodically at a fixed interval (or on a crontab), executed during Drupal cron via a worker callback or a queue.

---

Job Scheduler provides no end-user UI beyond a small settings form; it is an API other modules build on. You declare named schedulers with `hook_cron_job_scheduler_info()` (each maps to a "worker callback" function, or a "queue name" for queued processing) and then add jobs with the `job_scheduler.manager` service (`->set(['name' => …, 'type' => …, 'id' => …, 'period' => …, 'periodic' => TRUE])`). Each job is stored as a `job_schedule` content entity with a computed `next` execution timestamp (from `period` or a `crontab` line). On every cron run, `job_scheduler_cron()` calls the manager's `perform()`, which finds due jobs (bounded by the `limit` and `time` settings), dispatches each to its worker callback or queue, and — for periodic jobs — reschedules them. Jobs are uniquely identified by `[type, id]` and can be removed with `->remove()` / `->removeAll()`. A derived core QueueWorker (`job_scheduler_queue:<queue name>`) handles queued schedulers. The settings form (`/admin/config/system/job-scheduler`) toggles detailed logging and tunes how many jobs and how many seconds each cron run may spend, plus a "Rebuild" button that reconstructs schedule info via `rebuildAll()`.

---

- Unpublish a node automatically at a set future date/time (schedule a one-off job).
- Periodically re-import an external feed every hour via a recurring job.
- Send a reminder email a fixed number of days after a user registers.
- Expire and clean up temporary content on a fixed interval.
- Run a heavy maintenance task on a crontab expression (e.g. nightly at 02:00).
- Queue thousands of scheduled items for background processing instead of inline worker calls.
- Reschedule a periodic job automatically after each successful run.
- Deactivate expired memberships or subscriptions on a daily schedule.
- Retry a failed integration sync at a later time.
- Drive the Feeds module's periodic import scheduling (a classic consumer of this API).
- Schedule per-entity jobs keyed by `[type, id]` so each entity has its own timer.
- Cancel a scheduled job when its source entity is deleted (`removeAll` by name/type).
- Batch-limit cron work with the `limit` and `time` settings to avoid long cron runs.
- Log run-time statistics of scheduled jobs to watchdog for monitoring.
- Rebuild all schedule information after changing scheduler declarations.
- Trigger cache clears or index rebuilds on a fixed cadence.
- Implement "publish on" / "unpublish on" scheduling in a custom content workflow.
- Fan scheduled work out to a named queue processed by cron queue workers.
- Compute the next run time from a *NIX crontab line rather than a fixed period.
- Provide a reliable timer backbone for any module needing deferred or recurring execution.
