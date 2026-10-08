# Permissions

| Permission | Machine name | Restricted | Gates |
|---|---|---|---|
| Administer Cache Utility configuration | `administer cache utility configuration` | `restrict access: true` | The settings form route `cache_utility.settings`, and the submodule's four toolbar flush routes (`cache_utility_admin_toolbar.flush_cache.*`, which additionally require `_csrf_token`). |

That is the only permission the project defines (`cache_utility.permissions.yml`).

The JSON API routes (see [../api/http-endpoints.md](../api/http-endpoints.md)) are **not** gated by
this permission — they are declared `_access: 'TRUE'` at the routing layer and authenticate in the
controller by matching the `CU-ACCESS-KEY` request header against `cache_utility.settings`
→ `security.accessKey`. That is the mechanism that lets external machine callers (a deploy pipeline)
reach them without a Drupal session.
