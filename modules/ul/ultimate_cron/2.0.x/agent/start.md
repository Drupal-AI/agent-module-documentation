# ultimate_cron — agent start

Replaces core cron with per-job scheduling. Each **cron job** (`ultimate_cron_job` config
entity) combines a scheduler + launcher + logger plugin. Still triggered by normal Drupal cron
(`drush cron` / crontab). Admin UI: **Admin → Config → System → Cron**
(`/admin/config/system/cron/jobs`, configure route `entity.ultimate_cron_job.collection`).
No module dependencies; core `^9.3 || ^10.1 || ^11`.

- Global settings + admin pages → [configure/settings.md](configure/settings.md)
- Define a cron job (config entity + callback formats) → [configure/jobs.md](configure/jobs.md)
- Plugin types it defines (scheduler / launcher / logger) → [plugins/plugins.md](plugins/plugins.md)
- Run/manage jobs in code (CronJob entity + services) → [api/api.md](api/api.md)
- Lifecycle hooks (pre/post schedule/launch/run) → [hooks/hooks.md](hooks/hooks.md)
- Drush commands (list/run/logs/enable/disable/unlock) → [drush/drush.md](drush/drush.md)
- Permissions → [permissions/permissions.md](permissions/permissions.md)
