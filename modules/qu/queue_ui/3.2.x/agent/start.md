# queue_ui — agent start

Admin UI + Drush + manager for the queues Drupal core creates via the Queue API. Lists
every queue worker and lets you batch-process, release leases, clear, inspect items, and
tune per-queue cron limits. No config entities, no external deps. Config UI:
**Admin → Config → System → Queue manager** (`/admin/config/system/queue-ui`); route
`queue_ui.overview_form`. Single permission `admin queue_ui`.

- Overview UI: process / release / clear / inspect queues, routes & operations → [configure/queue_ui.md](configure/queue_ui.md)
- Drush commands (process, release, ±all) → [drush/queue_ui.md](drush/queue_ui.md)
- `QueueUI` inspection plugin type (support a custom backend) → [plugins/queue_ui.md](plugins/queue_ui.md)
- Permission → [permissions/queue_ui.md](permissions/queue_ui.md)
