# Permissions

Defined in `acquia_contenthub_dashboard.permissions.yml`.

| Permission | Machine name | Notes |
|---|---|---|
| Administer Acquia ContentHub Dashboard | `administer ach dashboard` | Declared with `restrict access: true` (an administrative, trusted-roles-only permission). Separate from the base module's `administer acquia content hub`, so dashboard access can be delegated independently. |

## How it gates access

The dashboard routes require `_contenthub_dashboard_access`, resolved by the access-check service
`access_check.acquia_contenthub_dashboard.access` (`ContentHubDashboardAccess::access()`). It
grants access only when the account **holds `administer ach dashboard`** *and* the Content Hub
client is connected (`ClientFactory::getClient()` returns a client); otherwise it returns
`AccessResult::forbidden()`. The result is tagged with the `acquia_contenthub_settings` cache tag,
so it re-evaluates when connection settings change.
