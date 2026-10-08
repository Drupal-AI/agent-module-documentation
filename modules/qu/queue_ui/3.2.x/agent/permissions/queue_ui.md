# Permissions

Defined in `queue_ui.permissions.yml` (via callback
`Drupal\queue_ui\QueueUIPermissions::permissions`).

| Permission | Title | Gates |
|---|---|---|
| `admin queue_ui` | Administer queues | Everything: the Queue manager overview and all its routes — batch process, remove leases, clear, inspect/view/release/delete items, and the per-queue cron settings form. Description: "View, run, and delete queues". |

It is the single permission the module provides; all `queue_ui.*` routes require it. Grant to
a trusted/administrative role only — it allows deleting queue items and running arbitrary
queue workers.

```
drush role:perm:add site_manager 'admin queue_ui'
```
