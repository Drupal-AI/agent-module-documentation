# Permissions

From `ultimate_cron.permissions.yml`:

| Permission | Gates |
|---|---|
| `administer ultimate cron` | Full config: jobs list/edit/delete/enable/disable, discover jobs, settings pages. Marked `restrict access` (security-sensitive). |
| `view cron jobs` | View cron jobs and their logs. |
| `run cron jobs` | Run a job on demand and unlock stuck jobs (`.../run`, `.../unlock` routes). |

Route enforcement (`ultimate_cron.routing.yml`): the jobs collection, settings and discover
routes require `administer ultimate cron`; the run/unlock routes require `run cron jobs`
(plus a CSRF token); edit/delete/enable/disable/logs use entity access
(`CronJobAccessControlHandler`). Grant `administer ultimate cron` to trusted admins only.
