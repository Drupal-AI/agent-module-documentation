# Configuration

All of the module's settings live under **Configuration → People → Login & Access
Security** (`/admin/config/people/session-management/…`), across several forms, each
gated by the core **Administer site configuration** permission. The main features and
their settings are grouped below.

## Session monitor (the per-user Sessions tab)

On the main **Session Management** settings form:

- **Enable session monitor** (default on) — turns on the per-user **Sessions** tab at
  `/user/{user}/mo_sessions`, where a user can review their own active sessions (IP
  address, browser, device, last activity). Only the account's **owner** can see their
  tab, and only while this is enabled. Turning it off hides the tab.
- **Date/time format** (default `Y-m-d H:i:s`) — how session timestamps are shown. Use a
  PHP date format, or the literal `time_passed` for a relative "… ago" display.

The browser/device columns come from the user agent captured at login. Note: the "Delete
session" action on this list is a **premium** feature and does nothing in the free
version.

## Session limit (simultaneous logins)

- **Enable session limiter** — cap how many simultaneous sessions an account may have.
- **Session limit count** (default `1`) — the maximum number of concurrent sessions.

When a user exceeds the limit, the module invalidates their **oldest** session on the
next authenticated request; the displaced user is effectively logged out and sees a
warning message the next time they load a page.

## Auto-logout (inactivity timeout)

On the **Auto Logout** form. Auto-logout is driven client-side (JavaScript watches for
inactivity and, when idle, logs the user out through core's logout route, so OAuth
single-logout modules can still hook in). Settings include:

- **Auto-logout enabled** — turn the inactivity timeout on.
- **Timeout** — how long a user may be idle before logout.
- **Response time** — how long the "are you still there?" warning is shown before it
  logs the user out anyway.
- **Force logout** — log out idle users even if they never respond to the warning.
- **Redirect after logout** — where to send the user once logout completes (e.g. the
  login page).
- **Modal text** — the warning dialog's **width**, **title**, **message**, and the
  **Accept** / **Deny** button labels (defaults *Accept* / *Deny*).

## IP login restriction

On the **Login settings** form:

- **IP login restriction** — only allow logins from an allow-list of IPs.
- **IP range list** — the allowed addresses, one per entry, expressed as **CIDR** blocks
  (e.g. `10.0.0.0/8`), **start-end** ranges, or **single IPs**. Both IPv4 and IPv6 are
  supported.
- **IP message** — the error message shown when a login is blocked by IP.

This adds a validator to the login form, so a login attempt from outside the allow-list
is rejected with your message.

## Reports and other forms

- **Audits and logs** — a login/logout activity report for administrators.
- **Licensing / Support / Request trial / Modal info** — miniOrange premium/upsell and
  support forms.

## Setting values without the UI

The module's config object is `session_management.settings`. Note that its config schema
only formally types the `enable_session_monitor` key; the other keys are read at runtime.
You can still set any of them with core config commands, for example:

```bash
ddev drush config:set session_management.settings session_limit_count 2 -y
```
