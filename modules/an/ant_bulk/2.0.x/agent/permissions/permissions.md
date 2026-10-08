# Permissions

The module defines one permission (`ant_bulk.permissions.yml`); its settings form reuses a core one.

| Permission | Machine name | `restrict access` | Gates |
|---|---|---|---|
| Use automatic bulk translations | `use bulk auto translate` | `true` | Route `ant_bulk.translate` — the `/ant-bulk/translate` bulk translate form |
| Administer site configuration (core) | `administer site configuration` | — | Route `ant_bulk.settings` — the `/admin/config/regional/ant-bulk-settings` settings form |

Notes:
- `use bulk auto translate` carries `restrict access: true`, so Drupal flags it with a
  restricted-permission warning on the permissions UI; grant it only to trusted editorial/admin roles.
- The Drush command `ant_bulk:translate` runs from the CLI and is not gated by a Drupal permission
  (shell access to the site is the control).
