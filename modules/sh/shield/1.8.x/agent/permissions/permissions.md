# Permissions

Defined in `shield.permissions.yml`.

| Permission | Gates |
|---|---|
| `administer shield` | Access the Shield settings form (`/admin/config/system/shield`) — enable/disable, set credentials and exceptions. |

Note: this permission only controls the config UI. The shield itself operates at the HTTP
middleware layer for **all** visitors regardless of Drupal roles/permissions; access is
granted by the Basic Auth credentials (or an exception), not by Drupal permissions.
