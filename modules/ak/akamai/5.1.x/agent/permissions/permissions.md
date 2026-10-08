# Akamai permissions

From `akamai.permissions.yml`. Both are `restrict access: TRUE` (security-sensitive).

| Permission | Gates |
|---|---|
| `administer akamai` | Access the Akamai configuration form (`akamai.settings`, `/admin/config/akamai/config`). |
| `purge akamai cache` | Access the manual cache-clear form (`akamai.cache_clear`, `/admin/config/akamai/cache-clear`) and the "Akamai Cache Clear" block. |

The container menu route `akamai.config_menu` (`/admin/config/akamai`) is visible to holders of
`administer akamai` **or** `purge akamai cache`. Grant `purge akamai cache` to editors who need to
flush pages but should not see or change API credentials.
