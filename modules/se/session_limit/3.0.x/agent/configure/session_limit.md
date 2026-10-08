# Configure session limits

## Routes

| Route | Path | Access |
|---|---|---|
| `session_limit.config_form` | `/admin/config/people/session-limit` | `administer site configuration` (core perm) |
| `session_limit.limit_form` | `/session-limit` | any logged-in user (`_user_is_logged_in: TRUE`; used by the "ask" behaviour to choose a session to end) |

The module defines **no permissions of its own**; the settings form is gated by the core
`administer site configuration` permission. Menu link lives under the People admin index.

## Settings — `session_limit.settings`

Edit at `/admin/config/people/session-limit` or via `drush cset session_limit.settings <key> <value>`.
Config schema: `config/schema/session_limit.schema.yml` (settings export/deploy with
`drush config:export`). Defaults shown:

| Key | Default | Type | Meaning |
|---|---|---|---|
| `session_limit_max` | `1` | integer | Site-wide default max active sessions per user. `0` = unlimited. |
| `session_limit_behaviour` | `0` | integer | What to do when the limit is exceeded (see actions below). |
| `session_limit_roles` | `[]` | sequence | Per-role overrides, keyed by role id → integer limit (`-1` = unlimited, `0` = uses default). |
| `session_limit_logged_out_display_message` | *(long default string)* | label | Message shown to a user whose session was force-ended. `@number` is replaced with their max. |
| `session_limit_logged_out_message_severity` | `warning` | string | Severity of that message: `error`, `warning`, `status`, or `_none` (no message). |
| `session_limit_admin_inclusion` | `0` | integer | If truthy, User 1 is also session-limited (by default User 1 and anonymous are never checked). |
| `session_limit_masquerade_ignore` | `false` | boolean | If true, masqueraded sessions don't count (form field + effect only when the Masquerade module is enabled). |
| `session_limit_log_events` | `false` | boolean | Log enforcement events to Watchdog (channel `session_limit`). |

The role fieldset offers per-role options: *Uses default* (`0`), *No limits* (`-1`), or an
integer `1`–`5`. Form validation rejects a negative `session_limit_max`.

## Behaviour when the limit is exceeded (`session_limit_behaviour`)

From `SessionLimit::getActions()` — the radio options on the form:

| Value | Constant | Effect |
|---|---|---|
| `0` | `ACTION_ASK` (default) | Redirect the user to `/session-limit` (HTTP 307) and ask which existing session to end. |
| `1` | `ACTION_DROP_OLDEST` | Automatically log out the oldest session(s) until back under the limit. |
| `2` | `ACTION_PREVENT_NEW` | Destroy the just-created session and return the user to anonymous (block the new login). |

Example: block extra logins instead of the default prompt —
`drush cset session_limit.settings session_limit_behaviour 2`.

## How the effective limit is resolved

`SessionLimit::getUserMaxSessions($account)`:
1. Start from the site default `session_limit_max`.
2. For each of the user's roles with a non-empty entry in `session_limit_roles`: if any is
   `-1` (`USER_UNLIMITED_SESSIONS`) the user is **unlimited**; otherwise the user gets the
   **largest** (`max()`) role limit. (Per-user limits are not currently implemented.)

A value `< 1` means unlimited (the check only fires when `max_sessions > 0` and
`active_sessions > max_sessions`). Active sessions are counted DISTINCT by `sid` so a user's
HTTP and HTTPS sessions count as one. The check runs on `KernelEvents::REQUEST` (priority 32);
the `/session-limit` (`session_limit.limit_form`), `/user/logout` (`user.logout`), CSS/JS
aggregate (`system.css_asset`, `system.js_asset`) and image-style (`image.style_public`,
`image.style_private`) routes are always bypassed. Once a session has passed the check twice it
is flagged verified (`$_SESSION['session_limit']`) and skipped on later requests.
