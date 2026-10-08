# acquia_contenthub_dashboard — agent start

Submodule of **acquia_contenthub**. Ships an embedded **Angular dashboard app** (served from the
module's `dashboard/` build) for monitoring Content Hub syndication, plus an "automatic publisher
discovery" feature that keeps a CORS allow-list of publisher webhook origins in sync so the
dashboard can talk to publishers. Depends on `acquia_contenthub`; the discovery/CORS features
additionally require `acquia_contenthub_subscriber` (checked at runtime, not a hard dependency).

- **Config keys (`allowed_origins`, `auto_publisher_discovery`), the admin-settings toggle, CORS override, webhook sync** → [configure/dashboard.md](configure/dashboard.md)
- **Permission that gates the dashboard** → [permissions/permissions.md](permissions/permissions.md)
- **Drush command to refresh allowed origins** → [drush/commands.md](drush/commands.md)

## Routes
| Route | Path | Controller | Access |
|---|---|---|---|
| `acquia_contenthub_dashboard.ach_dashboard` | `/admin/acquia-contenthub/contenthub-dashboard` | `ContentHubDashboardController::loadContentHubDashboard` | `_contenthub_dashboard_access` |
| `acquia_contenthub_dashboard.ach_dashboard.dashboard` | `/admin/acquia-contenthub/contenthub-dashboard/dashboard/index` | `ContentHubDashboardController::indexPage` | `_contenthub_dashboard_access` |
| `acquia_contenthub_dashboard.redirect_entity_edit_form` | `/acquia-contenthub/entity-edit/{entity_type}/{uuid}` | `ContentHubRedirectEntitiesController::redirectToEntityEditForm` | `_access: 'TRUE'` |

The dashboard route renders an `<iframe>` pointing at the served Angular app; `indexPage` returns
that app's `index.html` with a rewritten `<base href>`. The redirect route resolves a Content Hub
UUID to a local entity's edit form.

Key facts:
- Access check service `access_check.acquia_contenthub_dashboard.access`
  (`_contenthub_dashboard_access`) = `ContentHubDashboardAccess`: requires permission
  `administer ach dashboard` **and** a connected Content Hub client.
- Config object `acquia_contenthub_dashboard.settings`: `allowed_origins` (sequence),
  `auto_publisher_discovery` (bool, default `TRUE`).
- Permission `administer ach dashboard` (restricted).
- Drush `acquia:contenthub-dashboard-allowed-origins` (aliases `ach-dashboard-allowed-origins`, `ach-dao`).
- Webhook subscriber `UpdateAllowedOrigins` on `AcquiaContentHubEvents::HANDLE_WEBHOOK` (priority 110).
- Service provider `AcquiaContenthubDashboardServiceProvider` swaps `http_middleware.cors` for `ContentHubCors`.
- Menu link under `system.admin`; `hook_theme` suggestions + libraries for the app.
