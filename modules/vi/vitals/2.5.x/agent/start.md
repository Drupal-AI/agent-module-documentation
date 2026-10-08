# Vitals — agent index

Read-only JSON site-health endpoint for external monitoring. One endpoint `/vitals/{token}`
returns Drupal version, PHP version, active themes, and pending/security updates. Token is a
128-hex-char secret in `state` (`vitals.token`), compared with `hash_equals`, flood-limited to
10 tries/IP/hour; invalid → configurable 404 (default) or 403. Depends on core `update`.

- **Settings form, the endpoint, token generation/rotation, unauthorized action, enabling checks** →
  [configure/settings.md](configure/settings.md)
- **The `vitals_check` plugin type (add your own health check)** →
  [plugins/vitals_check.md](plugins/vitals_check.md)

Key facts:
- Config route `vitals_settings` at `/admin/config/services/vitals`, permission `administer vitals`.
- Endpoint route `vitals.content` at `/vitals/{token}`, permission `access content` + token check.
- Config `vitals.settings`: `vitals_unauthorized_action` (`403`|`404`, default `404`),
  `vitals_enabled_plugins` (map of enabled check ids).
- Token lives in **state** `vitals.token` (not config); set on install, regenerable from the form.
- Built-in checks: `cms_version`, `php_version`, `themes`, `updates`.
- No Drush commands.
