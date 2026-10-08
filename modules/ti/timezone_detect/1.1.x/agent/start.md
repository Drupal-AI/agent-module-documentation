# Timezone detect — agent index

Detects a logged-in user's timezone in the browser (jsTimezoneDetect / `jstz`) and saves
it to their Drupal account so date/time output renders in each user's local timezone.
Core-only dependency. No permissions defined by the module.

- **Modes, the settings form, the requirements check, the AJAX flow and config keys** →
  [configure/settings.md](configure/settings.md)

Key facts:
- Config: object `timezone_detect.settings`, keys `mode` (`default`|`login`|`always`)
  and `watchdog` (bool). Install default: `mode: default`, `watchdog: 1`.
- `configure` route `timezone_detect.admin` → `/admin/config/regional/timezone_detect`
  (permission `administer site configuration`).
- Flow: `hook_user_login()` / `hook_page_attachments()` attach library `timezone_detect/init`
  and `drupalSettings.timezone_detect.{current_timezone, token}` for authenticated users →
  `js/timezone_detect.js` runs `jstz.determine()` → POSTs `{timezone, token}` to route
  `timezone_detect.update_timezone` (`/timezone-detect/ajax/set-timezone`,
  requirement `_user_is_logged_in: TRUE`).
- `SetTimezoneController::updateTimezone()` validates the CSRF token
  (`csrf_token`), checks the value is in `timezone_identifiers_list()`, then saves it to
  the user entity `timezone` field (logs a notice when `watchdog` is on).
- `hook_requirements()` warns if `mode` is `default` but the site default user timezone is
  not configurable + empty (detection won't fire for new users otherwise).
- No new plugin types, no Drush.
