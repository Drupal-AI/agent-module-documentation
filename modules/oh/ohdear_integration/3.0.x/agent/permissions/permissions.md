# Permissions

Defined in `ohdear_integration.permissions.yml`.

| Permission | Grants |
|---|---|
| `access ohdear info` | View the Oh Dear report pages at `/admin/reports/ohdear/{info,broken-links,uptime}/{monitor_id}` (OhdearInfoController). |

That is the only permission this module defines.

The health-check endpoint (`/json/oh-dear-health-check-results`) does **not** use this
permission. `OhDearIntegrationController::access()` grants it when the request carries
the configured health-check secret, or when the account holds the `monitoring reports`
permission (defined by the `monitoring` dependency). See
[../api/healthcheck-endpoint.md](../api/healthcheck-endpoint.md).
