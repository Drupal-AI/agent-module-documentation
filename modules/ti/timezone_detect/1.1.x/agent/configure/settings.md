# Configuring Timezone detect

## Settings form

Route `timezone_detect.admin` → `/admin/config/regional/timezone_detect`
(`TimezoneDetectSettings`, a `ConfigFormBase`), permission **administer site
configuration**. Edits config object `timezone_detect.settings`.

| Key | Type | Default (config/install) | Meaning |
|---|---|---|---|
| `mode` | string | `default` | When to set the user's timezone automatically (see below). |
| `watchdog` | bool | `1` | Log an entry every time a timezone is set. |

### `mode` values (constants on `TimezoneDetectInterface`)

- `default` (`MODE_DEFAULT`) — set the timezone on login **only if it is not yet set**
  (recommended). Also fires whenever `getTimeZone()` is empty.
- `login` (`MODE_LOGIN`) — update on **every** login (overwrites manual choices).
- `always` (`MODE_ALWAYS`) — update whenever the detected timezone changes, on any page
  (also overwrites manual choices).

Set via Drush:
```bash
drush config:set timezone_detect.settings mode always -y
drush config:set timezone_detect.settings watchdog 0 -y
```

## Requirement: default user timezone must be empty for `default` mode

`hook_requirements()` (runtime) raises a `REQUIREMENT_ERROR` on the status report when
`mode` is `default` **and** the site's default user timezone is not both configurable and
empty:

- Set it at Regional settings: `system.date` →
  `timezone.user.configurable = true` and
  `timezone.user.default = ''` (the "empty timezone" option, `UserInterface::TIMEZONE_EMPTY`).
- If new users already receive a non-empty default timezone, `default` mode never triggers
  detection for them. `login`/`always` modes bypass this requirement.

## How detection reaches the account (reference)

1. `hook_user_login()` sets `$_SESSION['timezone_detect']['update_timezone'] = TRUE` when
   `mode === login` or the account has no timezone yet.
2. `hook_page_attachments()` attaches `timezone_detect/init` and
   `drupalSettings.timezone_detect = {current_timezone, token}` for authenticated users
   (always, in `always` mode; otherwise when the session flag is set).
3. `js/timezone_detect.js` runs `jstz.determine().name()` (remapping the known-bad
   `Asia/Calcutta` → `Asia/Kolkata`) and, if it differs from `current_timezone`, POSTs
   `{timezone, token}` to `/timezone-detect/ajax/set-timezone`.
4. `SetTimezoneController::updateTimezone()` validates the CSRF `token`, rejects any value
   not in `timezone_identifiers_list()`, then saves the user entity's `timezone` field.

There are no other configuration surfaces; the module defines no permissions of its own.
