# Permissions

Defined in `cms_content_sync_health.permissions.yml`.

| Permission | Grants |
|---|---|
| `access sync health` | Access to the Sync Health dashboard — all routes in this submodule (`/admin/content/sync-health`, the version-mismatches aggregate, and the "Entity Status" View tab). |

This is the module's only permission. It lets you grant an operations/support role read-only
visibility into syndication health without granting the parent's `administer cms content sync`
(which controls Flow/Pool configuration). Not marked `restrict access`, but the pages only expose
sync status, counts and log excerpts — no configuration is editable through them.
