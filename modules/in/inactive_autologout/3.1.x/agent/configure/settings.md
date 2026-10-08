# Configure Inactive Autologout

All behavior comes from the `inactive_autologout.settings` config object. Settings form:
route `inactive_autologout.admin_settings_form` → `/admin/config/people/autologoutsettings`,
guarded by the `administer inactiveautologout` permission.

## Config keys

| Key | Type | Default | Meaning |
|---|---|---|---|
| `enable` | int 0/1 | `0` | Master switch. When 0 nothing is attached and no logout happens. |
| `timeout` | string (seconds) | `'120'` | Default idle time before logout. **Must be ≥ 120** (form-validated). Sent to JS as `timeout*1000` ms. |
| `role_based_timeout` | int 0/1 | `0` | When 1, use a per-role timeout instead of the default for users who have an enabled role. |
| `modal_title` | string | `'Session Expiring'` | Title of the warning modal. |
| `modal_text` | string (HTML ok) | `'You will be logged out in <span id="autologout-countdown-number" class="countdown-number">@count</span> seconds due to inactivity.'` | Warning body. Use `@count` for the live countdown number. |
| `<role_id>` | int 0/1 | — | Dynamic: enable role-based timeout for a specific role (e.g. `editor`). |
| `<role_id>_timeout` | int (seconds) | — | Dynamic: idle time for that role (also validated ≥ 120 when its role is enabled). |

Role keys are added by the settings form for every role except `anonymous` and `authenticated`.
The config schema stores them via a catch-all `[a-zA-Z0-9_-]+` string mapping.

## Role-based timeout logic

When `role_based_timeout` is on, `hook_page_attachments()` iterates the current user's roles
(excluding `authenticated`) and, for the **first** role whose `<role_id>` config flag is truthy,
uses `<role_id>_timeout` (if non-empty) in place of the default `timeout`. Otherwise the default
applies.

## Enable it with drush

```bash
# turn on with a 5-minute idle timeout
drush cset inactive_autologout.settings enable 1 -y
drush cset inactive_autologout.settings timeout 300 -y

# customise the warning modal
drush cset inactive_autologout.settings modal_title 'Session ending' -y

# per-role example: 3-minute timeout for the 'editor' role
drush cset inactive_autologout.settings role_based_timeout 1 -y
drush cset inactive_autologout.settings editor 1 -y
drush cset inactive_autologout.settings editor_timeout 180 -y

drush cget inactive_autologout.settings
```

## Runtime / routes

- Only runs when `enable=1` and the user is authenticated; the library
  `inactive_autologout/user_autologout` (jquery.inactivity + custom JS) is attached and
  `drupalSettings.inactive_autologout` receives `timeout` (ms), `enable`, `modal_title`, `modal_text`.
- `/autologout` — controller `AutologoutController::autologout()` runs `user_logout()` and
  redirects to `user.login`. `/autologout_active` stores the client timestamp in the session;
  `/autologout_gettimestamp` returns it (both AJAX, GET, logged-in only).

## Notes
- Shipped defaults (config/install): `timeout: '120'`, `enable: 0`, `role_based_timeout: 0`,
  plus the default `modal_title` / `modal_text` above. Restore these explicitly rather than
  relying on state.
- No Drush commands, no plugin types, no dependencies beyond Drupal core.
