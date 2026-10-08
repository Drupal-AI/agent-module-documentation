# session_management — configuration

All admin config is under `/admin/config/people/session-management/*` and gated by core
`administer site configuration`. Config object: `session_management.settings`. The shipped
`config/install/session_management.settings.yml` seeds defaults; the config **schema only types
`enable_session_monitor`**, so the other keys below are read via `->get()` without typed-config coverage.

## Admin routes (all `_permission: administer site configuration` unless noted)

| Route | Path | Form |
|---|---|---|
| `session_management.config_form` (the `configure` link) | `.../session-management/session-management` | `SessionSettingsForm` |
| `session_management.autologout_form` | `.../mo-autologout` | `AutoLogoutSettingsForm` |
| `session_management.login_protection_form` | `.../login-settings` | `LoginSettingsForm` |
| `session_management.login_report` | `.../mo-audits-and-logs` | `UserLoginReport` |
| `session_management.licensing_form` | `.../licensing` | `MiniorangeSupport` (premium/upsell) |
| `session_management.support_form` / `.request_trial` | `.../support`, `.../requestTrial` | `MoSupportTrialForm` |
| `session_management.modal_info` | `.../modal-info` | `ModalInfoForm` |
| `session_management.session_manage` | `/user/{user}/mo_sessions` | `SessionMonitorForm` (custom access, owner-only) |
| `session_management.logout` | `/session_management/logout` | controller; POST + `_user_is_logged_in` + CSRF header |

## Settings keys (by feature)

Seeded defaults: `enable_session_monitor: true`, `date_time_format: 'Y-m-d H:i:s'`, `session_limit_count: 1`,
`mo_modal_width: 400`, `mo_modal_title`, `mo_modal_message`, `mo_modal_yes_button_text: Accept`,
`mo_modal_no_button_text: Deny`.

- **Session monitor / list:** `enable_session_monitor` (bool; also shows/hides the per-user Sessions tab via
  `hook_menu_local_tasks_alter`), `date_time_format` (a PHP date format, or the literal `time_passed` for
  relative "… ago").
- **Session limit:** `enable_session_limiter` (bool), `session_limit_count` (int). Enforced by
  `SessionLimitSubscriber` on each authenticated request — see api/services.md.
- **Auto-logout** (read in `session_management_page_attachments_alter`, pushed to JS): `autologout_enabled`,
  `autologout_timeout`, `autologout_response_time`, `force_logout`, `redirect_after_logout`, plus modal:
  `mo_modal_width`, `mo_modal_title`, `mo_modal_message`, `mo_modal_yes_button_text`,
  `mo_modal_no_button_text`.
- **IP login restriction:** `ip_login_restriction` (bool), `ip_range_list` (array of CIDR / `start-end` /
  single IPs, IPv4+IPv6), `ip_message` (error shown on blocked login). Validated on the login form by
  `session_management_validate_ip_restriction` → `mo_login_restriction` service.

## Behaviour notes
- On login, `session_management_user_login` stores the request `User-Agent` in the session as `mo_browser`
  (used to render Browser/Device columns in the sessions list).
- The Sessions list "Delete" operation is a **premium** feature: for non-administrator users it links back
  with `?delete=session`, which only shows a "you do not have permission" warning — no deletion occurs in
  this free version.
