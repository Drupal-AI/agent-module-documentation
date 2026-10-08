# Configuration

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → People → Session limit**, or navigate directly to
   `/admin/config/people/session-limit`.

All settings are stored in the `session_limit.settings` config object, so they
export and deploy with `drush config:export`.

## Maximum number of sessions

- **Maximum sessions** (`session_limit_max`, default **1**) — the site-wide
  default number of simultaneous sessions each user may have. Set it to `0` for
  unlimited. A user's HTTP and HTTPS sessions are counted as one, so a single
  browser only ever counts once.

## When the limit is exceeded

Choose what happens the moment a user goes over their limit
(`session_limit_behaviour`):

- **Ask the user** *(default)* — the new session is redirected to `/session-limit`
  and the user is prompted to pick which existing session to end.
- **Automatically log out the oldest session** — the module silently ends the
  oldest session(s) until the user is back within the limit, with no prompt.
- **Prevent the new login** — the just-created session is destroyed and the user
  is returned to anonymous, so the existing sessions win and the new login is
  blocked.

## Per-role limits

Below the default is a fieldset of **per-role overrides**
(`session_limit_roles`). For each role you can choose:

- **Uses default** — the role adds no override; the site default applies.
- **No limits** — members of the role are never session-limited.
- A specific number (**1–5**) — the role's own maximum.

When a user has several roles, the module grants them the **most generous** limit
of their roles (and unlimited if any of their roles is set to "No limits").

## Message and severity

- **Logged-out message** (`session_limit_logged_out_display_message`) — the text
  shown to a user whose session was force-ended. The placeholder `@number` is
  replaced with their maximum.
- **Message severity** (`session_limit_logged_out_message_severity`, default
  **warning**) — how that message is styled: error, warning, status, or none (to
  suppress the message entirely).

## Advanced options

- **Include administrator (User 1)** (`session_limit_admin_inclusion`, default
  off) — by default User 1 is never limited; enable this to apply limits to User 1
  as well.
- **Ignore masqueraded sessions** (`session_limit_masquerade_ignore`) — when the
  **Masquerade** module is installed, don't count sessions created while
  masquerading toward the user's total. This field only takes effect with
  Masquerade enabled.
- **Log enforcement events** (`session_limit_log_events`, default off) — write
  enforcement actions to the log (channel `session_limit`) so you can audit when
  sessions are dropped or blocked.

## Save

Click **Save configuration**. Changes take effect on subsequent logins. You can
also edit any of these values from the command line, for example
`drush cset session_limit.settings session_limit_behaviour 2` to switch to
"prevent the new login."
