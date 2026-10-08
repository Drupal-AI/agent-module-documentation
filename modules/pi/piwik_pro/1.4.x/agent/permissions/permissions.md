# Permissions

| Permission | Gates | Notes |
|---|---|---|
| `administer piwik pro` | The settings form (`/admin/config/services/piwik-pro`) — all tracking config, visibility rules, cookie/CSP options. | `restrict access: TRUE` (treated as a sensitive/administrative permission). |

Only one permission. It controls what tracking code runs site-wide, so it is marked
`restrict access` and should be granted only to trusted administrators. The dashboard submodule
adds its own separate permissions (`administer piwik pro dashboard`, `access piwik pro
dashboard`).
