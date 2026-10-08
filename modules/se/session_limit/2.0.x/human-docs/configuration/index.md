# Configuration

All of Session Limit's settings live on one form. Go to **Configuration → People →
Session limit settings** (`/admin/config/people/session-limit`). Access is gated by
core's **Administer site configuration** permission — the module defines no
permissions of its own.

## The settings, field by field

| Setting | Default | What it does |
|---|---|---|
| **Maximum number of sessions** | `1` | The site‑wide default number of simultaneous active sessions allowed per user. `0` means unlimited. |
| **When the session limit is exceeded** | *Ask* | What happens when a user goes over their limit — see the three behaviours below. |
| **Per‑role limits** | *(none)* | Override the default for specific roles. Enter a number per role, or `-1` for unlimited. |
| **Logged‑out message** | *(a default sentence)* | The message shown to a user whose session was force‑ended. `@number` is replaced with their maximum. |
| **Message severity** | *Warning* | How that message is displayed: error, warning, status, or none (no message). |
| **Limit the super administrator (user 1)** | Off | If on, user 1 is session‑limited too. By default user 1 and anonymous users are never checked. |
| **Ignore masqueraded sessions** | Off | If on, sessions started by masquerading don't count toward the limit. Only relevant when the Masquerade module is enabled. |
| **Log events** | Off | Log every enforcement action to the site log (the `session_limit` channel) for auditing. |

Click **Save configuration** when done. The settings are a config object, so they
export and deploy with `drush config:export`.

## What happens when the limit is exceeded

The **behaviour** setting has three options:

- **Ask** *(default)* — the user is redirected to a `/session-limit` page and asked
  to pick which of their existing sessions to end.
- **Drop oldest** — the module automatically logs out the oldest session(s) until
  the user is back under the limit.
- **Prevent new** — the just‑created session is destroyed and the user is returned to
  anonymous, i.e. the new login is blocked.

You can also set the behaviour from the command line, for example to block extra
logins:

```bash
drush cset session_limit.settings session_limit_behaviour 2
```

(Behaviour values are `0` = ask, `1` = drop oldest, `2` = prevent new.)

## How a user's effective limit is worked out

For each user, the module starts from the site‑wide **Maximum number of sessions**
and then looks at their roles' per‑role limits:

- if any of their roles is set to unlimited (`-1`), the user is unlimited;
- otherwise the user gets the **largest** limit among their roles.

So per‑role overrides *raise* a user to the most generous limit their roles allow.
A resolved value below `1` means unlimited. (Per‑user limits are not currently
supported.) The `/session-limit` and `/user/logout` paths are always exempt from the
check.

## For developers

Enforcement can be steered from a custom module through three events —
`session_limit.bypass` (skip the check for a request), `session_limit.collision` (a
limit was hit), and `session_limit.disconnect` (a session is about to be ended; can
be prevented or given a custom message) — plus a `session_limit` service with
helper methods. See the [`agent/`](../agent/start.md) docs for the API.
