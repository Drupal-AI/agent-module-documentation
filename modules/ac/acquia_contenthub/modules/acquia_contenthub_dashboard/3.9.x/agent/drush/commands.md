# Drush — allowed origins

Registered via `drush.services.yml` (service
`acquia_contenthub_dashboard.allowed_origins_commands`, class `ContentHubAllowedOriginsCommands`).

| Command | Aliases | Purpose |
|---|---|---|
| `acquia:contenthub-dashboard-allowed-origins` | `ach-dashboard-allowed-origins`, `ach-dao` | Fetch publisher webhook origins from the Content Hub service and merge them into `acquia_contenthub_dashboard.settings:allowed_origins`. |

## Behavior (`allowedOrigins()`)

Calls `ContentHubAllowedOrigins::getAllowedOrigins()` — which queries the service for
`type: client` entities and collects each publisher's
`metadata.settings.webhook.settings_url` — then merges the result (`array_unique`) into the
existing `allowed_origins` config and saves it. No-op when the query returns nothing. Use it to
refresh the CORS allow-list on demand instead of waiting for an inbound webhook (see
[../configure/dashboard.md](../configure/dashboard.md)).
