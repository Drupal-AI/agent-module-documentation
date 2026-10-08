# Permissions

Defined in `simple_cron.permissions.yml`.

| Permission | Restrict access | Grants |
|---|---|---|
| `administer simple cron` | yes | Full control: the settings form (`simple_cron.settings`), and edit / enable / disable / unlock / run on every job. It is the entity's `admin_permission`. |
| `view simple cron jobs` | no | Reach the job collection page (`/admin/config/system/cron/jobs`) to view the list. |
| `run simple cron jobs` | no | Reach the collection page and use the **Run** operation on an enabled, unlocked job. |

## How they gate routes

- `simple_cron.settings` → requires `administer simple cron`.
- `entity.simple_cron_job.collection` → requires any of
  `administer simple cron` **+** `view simple cron jobs` **+** `run simple cron jobs` (OR).
- `entity.simple_cron_job.run` → `CronJobAccessControlHandler` allows it for holders of
  `run simple cron jobs` **or** `administer simple cron`, and only when the job is enabled and not
  locked.
- `edit_form`, `enable`, `disable`, `unlock` → `administer simple cron` only (via the access handler);
  `delete` is always forbidden.

Grant via drush: `ddev drush role:perm:add operator 'run simple cron jobs'`.

Note: the single-URL run (`/cron/<system.cron_key>?job=<id>`) is not gated by these permissions — it
rides core's `system.cron` route and is authorized by the secret `system.cron_key`.
