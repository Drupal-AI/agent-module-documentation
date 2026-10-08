# Configure

![Node Revision Delete configuration](../../../../../../../screenshots/node_revision_delete/2.1.x/settings.png)

Main settings form `AdminSettingsForm` at `/admin/config/content/node_revision_delete` (route
`node_revision_delete.admin_settings`), config object `node_revision_delete.settings` (schema
`config/schema/node_revision_delete.schema.yml`). Per-content-type plugin config uses schemas
`node_revision_delete.plugin.schema.yml` / `.plugin_type.yml`.

Global settings (`config/install/node_revision_delete.settings.yml`):

| Key | Type | Default | Meaning |
|---|---|---|---|
| `disable_automatic_queueing` | bool | FALSE | If TRUE, candidates are not auto-queued on cron; run manually instead. |
| `verbose_log` | bool | FALSE | Log details of each deletion. |
| `bulk_delete_threshold` | int | 50 | Max revisions processed per bulk run. |

Per content type you enable one or more **NodeRevisionDelete** strategy plugins (amount /
created / drafts / only_drafts) and their parameters (e.g. how many to keep, max age) — see
[../plugins/strategy.md](../plugins/strategy.md).

Other forms/routes:
- `node_revision_delete.reset_node_type` (`/reset/{node_type}`) — reset a content type's config.
- `node_revision_delete.queue` (`/queue`) — trigger a queueing/deletion run from the UI.

`ConfigSubscriber` reacts to config changes; a `NodeRevisionDeleteRequeue` queue worker
re-queues remaining items. Read/write with drush:
```
drush config:set node_revision_delete.settings bulk_delete_threshold 100 -y
```
