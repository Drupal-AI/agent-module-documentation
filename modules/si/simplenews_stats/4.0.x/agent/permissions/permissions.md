# Permissions

Defined in `simplenews_stats.permissions.yml` (7 permissions).

| Permission | Gates |
|---|---|
| `administer simplenews stats` | `admin_permission` for both entity types; OR-branch on entity update/delete/create access. Flagged `restrict access: true`. |
| `access simplenews stats overview` | The two admin collection lists: `/admin/content/simplenews-stats` and `/admin/content/simplenews-stats-items`. |
| `view simplenews stats` | `view` operation on a `simplenews_stats` entity (canonical page); the two autocomplete routes (`simplenews_stats.entity_associated_autocomplete`, `simplenews_stats.user_autocomplete`). |
| `create simplenews stats` | `create` on `simplenews_stats` (OR `administer simplenews stats`). |
| `delete simplenews stats` | `delete` on `simplenews_stats` (OR `administer simplenews stats`). |
| `access simplenews stats results` | Per-node **Stats** tab (`/node/{node}/simplenews-stats`) for any Simplenews issue node. |
| `access simplenews stats results editable node` | Per-node **Stats** tab, but only for nodes the account also has core `update` access on (`SimplenewsStatsAdminController::simplenewsStatsAccess()`). |

Notes
- Access to entity operations is resolved in `SimplenewsStatsAccessControlHandler`:
  `view` → `view simplenews stats`; `update` → `edit simplenews stats` OR
  `administer simplenews stats`; `delete` → `delete simplenews stats` OR
  `administer simplenews stats`; create → `create simplenews stats` OR
  `administer simplenews stats`. (An `edit simplenews stats` permission is referenced
  by the update branch but there is no editable form and no such permission defined.)
- The two public tracking routes (`hit_view`, `hit_click`) require only core
  `access content` — recipients are not authenticated site users. See
  [../api/tracking.md](../api/tracking.md).

## Grant via Drush

```bash
drush role:perm:add editor 'access simplenews stats results editable node'
drush role:perm:add newsletter_admin 'access simplenews stats overview'
```
