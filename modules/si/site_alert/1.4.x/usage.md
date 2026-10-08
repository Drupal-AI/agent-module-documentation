Site Alert lets administrators display one or more site-wide alert banners (with low/medium/high severity and optional start/end scheduling) to every visitor, rendered through a block and kept fresh via AJAX independently of page caching.

---

The module defines a `site_alert` content entity (base table `site_alerts`) with fields: `label`
(internal), `active` (bool), `severity` (`low`/`medium`/`high` list), `message` (text_long), and
`scheduling` (a `daterange` start/end). Alerts are managed at `admin/config/system/site-alerts`
(`configure` route `entity.site_alert.collection`). A `SiteAlertBlock` block plugin renders all
currently-active alerts (active + within any scheduled window, computed by the `GetAlerts` service via
an entity query) using the `site_alert` theme hook / `site-alert.html.twig`, wrapped in an
`aria-live="polite"` region. Because scheduled alerts must appear/disappear on time even on cached
pages, the block attaches JS (`drupal.site_alert`) that polls a maintenance-mode-accessible controller
route (`/ajax/site_alert`, `_access: TRUE`) every N seconds (block `timeout` setting, default 300; 0
disables polling) to fetch the current alerts; a `page_cache` workaround defers server-side rendering to
the JS path when scheduled alerts exist. A custom cache context (`active_site_alerts`) and the entity
list cache tags keep the block correct. Four permissions gate administer/add/update/delete; all roles
can view. A Drush command set (`site-alert:create|delete|enable|disable`, service `CliCommands`) manages
alerts from the CLI, including scheduling and severity. The alert `message` is admin-authored and
rendered as raw `#markup` (no text-format filtering), so treat the add/update permissions as trusted —
see `agent/permissions/permissions.md`.

---

- Show a site-wide maintenance/downtime notice to all visitors.
- Display a general informational banner (e.g. "New feature launched").
- Schedule an alert to appear at a future date/time and auto-expire.
- Run several alerts at once, each with its own severity styling.
- Mark an alert high severity so the theme styles it red/urgent.
- Temporarily disable an alert without deleting it (uncheck *Active*) to reuse later.
- Reactivate a previously created alert for a recurring event.
- Place the alert banner in any theme region via the *Site Alert* block.
- Tune how often the banner refreshes by setting the block *Timeout* (seconds).
- Disable client polling entirely by setting the block timeout to 0.
- Keep alerts current on fully page-cached sites (AJAX refresh bypasses the cache).
- Create an alert from CI/CD or a deploy script with `drush site-alert:create`.
- Schedule a maintenance-window alert from the CLI with `--start` and `--end`.
- Create an inactive alert via `drush site-alert:create … --no-active` and enable it later.
- Enable a specific alert by label with `drush site-alert:enable "my-alert"`.
- Disable one alert (`drush site-alert:disable "my-alert"`) or all alerts (`drush site-alert:disable`).
- Delete alerts by label with `drush site-alert:delete "my-alert"`.
- Grant editors only `add site alerts` / `update site alerts` without full administration.
- Provide an accessible alert region (`aria-live="polite"`) for screen readers.
- Announce an emergency notice that must reach even users on cached pages within the timeout window.
- Programmatically fetch active alerts in custom code via the `site_alert.get_alerts` service.
- Vary other cached output by the `active_site_alerts` cache context when needed.
