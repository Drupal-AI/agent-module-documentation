# Permissions

Defined in `remove_http_headers.permissions.yml`.

| Permission | Gates |
|---|---|
| `remove_http_headers settings access` | Access the settings form (`remove_http_headers.remove_http_headers_settings`, `/admin/config/system/remove-http-headers`) — i.e. editing the `headers_to_remove` list. Marked `restrict access: TRUE` (security-sensitive, administrative). |

This is the module's only permission; it is the `_permission` requirement on the configure
route.

```bash
drush role:perm:add site_manager 'remove_http_headers settings access'
```
