# Inactive Autologout — agent index

Logs authenticated users out after a period of inactivity, with a countdown warning modal and
optional per-role timeouts. Driven entirely by the `inactive_autologout.settings` config object
plus a JS library attached via `hook_page_attachments()`. No dependencies beyond core.

- **All settings keys (enable, timeout, role-based timeout, modal), the settings form, permission, and the JS routes** →
  [configure/settings.md](configure/settings.md)

Key facts:
- Config object `inactive_autologout.settings`: `enable` (int 0/1), `timeout` (seconds, string,
  min 120), `role_based_timeout` (int 0/1), `modal_title`, `modal_text` (use `@count` for the
  countdown), plus dynamic `<role_id>` (0/1) and `<role_id>_timeout` (seconds) keys.
- Settings form route `inactive_autologout.admin_settings_form`
  (`/admin/config/people/autologoutsettings`), permission `administer inactiveautologout`.
- The feature only runs when `enable=1`, and only for authenticated users (library
  `inactive_autologout/user_autologout`). Timeout is sent to JS in **milliseconds**.
- Routes: `/autologout` (does `user_logout()` + redirect to login), `/autologout_active` and
  `/autologout_gettimestamp` (AJAX activity-timestamp tracking).
