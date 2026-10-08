# Flood settings — agent index

Thin admin UI over Drupal core's `user.flood` config (failed-login flood limits). One
form, one permission, no schema/plugins/Drush. `configure` route:
`flood_settings.settings` at `/admin/config/system/flood`.

- **The settings form: every key it writes, option ranges, the permission, and how to set
  the same values with drush** → [configure/settings.md](configure/settings.md)

Key facts:
- Writes core config object `user.flood` keys: `uid_only` (bool), `ip_limit`, `ip_window`,
  `user_limit`, `user_window`.
- Access: permission `manage flood settings` (not `restrict access: true`).
- No config of its own (no `config/install`, no schema); it edits core's `user.flood`.
- Defaults offered in code: IP limit 50 / window 3600s, user limit 5 / window 21600s.
