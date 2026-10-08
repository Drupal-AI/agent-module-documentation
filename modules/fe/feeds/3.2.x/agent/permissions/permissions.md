# Permissions

Defined in `feeds.permissions.yml` plus a dynamic callback
(`Drupal\feeds\FeedsPermissions`).

Global:

| Permission | Gates |
|---|---|
| `administer feeds` | Create/update/delete feed types; run import/delete on **any** feed type. (Restricted.) |
| `access feed overview` | View the `/admin/content/feed` overview of all feeds. |

Per **feed type** (generated for each `feeds_feed_type` id `<id>`, most with an `own` variant):

- `view [own] <id> feeds`
- `create <id> feeds`
- `update [own] <id> feeds`
- `delete [own] <id> feeds`
- `import [own] <id> feeds` — run an import.
- `schedule_import [own] <id> feeds` — trigger a background (cron/queue) import.
- `clear [own] <id> feeds` — delete the items a feed imported.

The `own` variants restrict the action to feeds the user owns. This lets you give each editor
control over their own feeds of a shared type without granting `administer feeds`.
