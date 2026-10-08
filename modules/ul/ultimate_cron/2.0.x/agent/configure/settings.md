# Global settings & admin pages

Config object `ultimate_cron.settings` (schema `config/schema/ultimate_cron.schema.yml`,
defaults in `config/install/ultimate_cron.settings.yml`). These are site-wide defaults;
each job can override scheduler/launcher/logger config individually.

Admin routes (all under `/admin/config/system/cron`, permission `administer ultimate cron`):

| Route | Path | Purpose |
|---|---|---|
| `entity.ultimate_cron_job.collection` | `/jobs` | List/reorder/run/disable jobs (the configure route) |
| `ultimate_cron.discover_jobs` | `/jobs/discover` | Re-scan modules for new cron jobs |
| `ultimate_cron.general_settings` | `/settings` | Global settings form |
| `entity.ultimate_cron_job.logs.*` | `/jobs/logs/{job}` | Per-job execution logs |

(The launcher/logger/scheduler settings sub-routes exist but are `_access: FALSE` — disabled;
those options are configured per job instead.)

Key `ultimate_cron.settings` values (defaults shown):

| Key | Default | Meaning |
|---|---|---|
| `bypass_transactional_safe_connection` | FALSE | Use a separate DB connection for logs inside transactions. |
| `queue.enabled` | FALSE | Expose queue workers as individual cron jobs. |
| `queue.throttle.enabled` | TRUE | Throttle queue jobs by thread/threshold. |
| `queue.throttle.threads` | 4 | Max parallel threads for queues. |
| `queue.throttle.threshold` | 10 | Items needed before spawning extra threads. |
| `launcher.max_threads` | 1 | Default max concurrent job threads. |
| `launcher.lock_timeout` | 3600 | Seconds before a job's lock is considered stale. |
| `launcher.max_execution_time` | 3600 | Seconds a job may run before being cut off. |
| `logger.database.method` | 3 | Retention strategy for DB logs. |
| `logger.database.expire` | 1209600 | Log expiry (seconds, 14 days). |
| `logger.database.retain` | 1000 | Max log rows kept per job. |
| `scheduler.simple.rule` | `*/15+@ * * * *` | Default Simple scheduler interval. |
| `scheduler.crontab.rules` | `['*/10+@ * * * *']` | Default Crontab rules. |

Read/write: `drush config:get ultimate_cron.settings`,
`drush config:set ultimate_cron.settings launcher.max_execution_time 1800 -y`.

Note: Ultimate Cron takes over what cron executes but does **not** trigger cron. Keep a real
trigger (`drush cron` via crontab); avoid core's Automated Cron on cached sites. Ultimate Cron
alters the core cron settings form (`ultimate_cron_form_system_cron_settings_alter`) to expand
the Automated Cron interval options.
