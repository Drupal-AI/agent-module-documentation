# Permissions

| Permission | Gates | Notes |
|---|---|---|
| `administer piwik pro dashboard` | The settings form — set the Client ID and select the Key holding the client secret. | `restrict access: TRUE` (sensitive: controls API credentials). |
| `access piwik pro dashboard` | Viewing the dashboard page **and** the three JSON API routes (`/api/piwik-dashboard/overview`, `/devices`, `/top-pages`). | Grant to roles that should see analytics; it exposes the fetched Piwik PRO data. |

Note: the JSON API routes are protected only by `access piwik pro dashboard`; anyone with that
permission can hit them directly and receive the analytics JSON. They do not expose the client
secret (that stays in the Key module), but they do return traffic statistics — grant
accordingly.
