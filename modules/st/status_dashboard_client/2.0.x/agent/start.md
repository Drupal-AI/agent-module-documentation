# Status Dashboard Client — agent index

Client-side companion to the **Status Dashboard** module. Exposes one secret-protected JSON
endpoint reporting core/module versions, pending security & feature updates, and requirement
errors, for a central dashboard to poll. Depends on core `update`. One permission, one setting.

- **The endpoint, its access check + shared secret, the settings form, JSON payload shape** →
  [configure/endpoint.md](configure/endpoint.md)
- **`hook_status_dashboard_json_response_alter()` to extend the payload** →
  [hooks/alter.md](hooks/alter.md)

Key facts:
- Route `status_dashboard_client.check` = `GET /status_dashboard/check` (`no_cache`), access =
  custom check `_status_dashboard_access_check` comparing header `x-dashboard-secret` to the
  stored `secret`.
- Settings form route `status_dashboard_client.settings_form` =
  `/admin/config/development/status-dashboard-client`; permission
  `administer status_dashboard_client configuration` (restricted).
- Config object `status_dashboard_client.settings` holds only `secret`. No config schema ships.
- Payload keys: `date`, `core`, `modules`, `security_updates`, `feature_updates`, `sitename`,
  `url`, `error_count`.
- No default `secret` ships (no `config/install`); set one after enabling.
