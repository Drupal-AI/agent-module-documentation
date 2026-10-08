Login & Access Security (machine name `session_management`) is a miniOrange module that limits simultaneous logins per account, auto-logs-out idle users, restricts login by IP, records login/logout reports, and lets each user view their own active sessions.

---

The module bundles several session/login controls around core's `sessions` table and Views. A
`SessionLimitSubscriber` event subscriber checks on every authenticated request whether the user's session
count exceeds `session_limit_count`; if so it invalidates the oldest session (rewriting its `sessions` row to
`uid 0` with a warning message the displaced user sees on next request). Auto-logout is driven client-side: on
authenticated pages `hook_page_attachments_alter` attaches `js/mo_logout.js` plus `drupalSettings` (timeout,
response time, force-logout, modal text); when idle, JS calls the `session_management.logout` controller which
returns a CSRF-signed `user.logout` URL to navigate to (so OAuth single-logout modules can hook in). IP login
restriction adds a validator to the login form using a configurable allow-list (CIDR / ranges / single IPs,
IPv4+IPv6). A per-user "Sessions" tab (`/user/{user}/mo_sessions`) lists that user's active sessions
(hostname/IP, browser, device, last activity) — custom access allows it **only for the account owner** when the
monitor is enabled, and the in-UI "Delete session" action is a paid ("premium") feature that is a no-op in this
free version. Admin config lives under *People → Login & Access Security* across several forms (session
settings, auto-logout, login/IP settings, reports, modal), all gated by the core `administer site
configuration` permission; the module provides a config schema but defines no permissions of its own and no
Drush. Depends on core Views. Much of the settings UI advertises premium upsell (trial/licensing/support
forms).

---

- Limit each account to N simultaneous sessions and terminate the oldest when exceeded.
- Warn a user that an older session was ended because the session limit was reached.
- Automatically log out users after a configurable period of inactivity.
- Show an "are you still there?" modal before auto-logout, with customizable title/message/buttons.
- Force-logout idle users even if they never respond to the warning modal.
- Redirect users to the login page after an auto-logout completes.
- Preserve OAuth single-logout (SLO) flows by routing logout through core `user.logout`.
- Restrict which IP addresses may log in using an allow-list.
- Express the IP allow-list as CIDR blocks (e.g. `10.0.0.0/8`), ranges (`start-end`), or single IPs.
- Support both IPv4 and IPv6 in the login IP restriction.
- Show a custom error message when a login is blocked by IP.
- Let each user review their own active sessions (IP, browser, device, last activity time).
- Give users a "Sessions" tab on their account page to spot unrecognized logins.
- Format session timestamps with a configurable date format or "time ago" relative display.
- Record login/logout activity in a report for administrators.
- Enable or disable the per-user session monitor globally.
- Scope all admin configuration to holders of `administer site configuration`.
- Detect browser and device from the stored user agent for the session list.
- Combine session limiting with auto-logout for stricter account security policies.
- Provide a foundation for session governance on multi-user or membership sites.
