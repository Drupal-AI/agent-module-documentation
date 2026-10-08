# Job Scheduler — agent index

A developer API for scheduling one-off or periodic tasks, executed during cron. You declare a
scheduler (hook) and add jobs (service). Jobs are `job_schedule` content entities. No UI beyond a
settings form.

- **Schedule/remove jobs with the `job_scheduler.manager` service and the job array shape** →
  [api/scheduler-service.md](api/scheduler-service.md)
- **Declaring schedulers & workers (the hooks) and the worker callback signature** →
  [hooks/hooks.md](hooks/hooks.md)
- **Settings (`limit`, `time`, `logging`), the admin form, cron behaviour, the entity** →
  [configure/settings.md](configure/settings.md)

Key facts:
- Service: `job_scheduler.manager` (`JobSchedulerInterface`) — `set()`, `remove()`, `removeAll()`, `perform()`, `rebuildAll()`.
- Job array keys: `name`, `type`, `id`, `period` (secs) or `crontab`, `periodic` (bool), `data` (arbitrary).
- Entity: `job_schedule` (base_table `job_schedule`), fields incl. `name`, `type`, `id`, `period`, `crontab`, `periodic`, `next`, `last`, `data`.
- Config: `job_scheduler.settings` (`logging`, `limit`=200, `time`=30) at `/admin/config/system/job-scheduler`.
- Submodule `job_scheduler_waiting` (nested): a long-running worker for jobs that wait indefinitely.
