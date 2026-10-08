<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# login_time_restriction — agent start

Per-user time-window login/browse restriction. Each user has a `field_ltr_access_time` date/time-range
field; outside the window, login is refused and the active session is force-logged-out. Depends on
`time_range`. Config: `/admin/login_time_restriction/settings` (`administer site configuration`) —
enable, per-day vs date-range, message, warning minutes, sticky timer.

Enforcement (both server-side, sound):
- `login_time_restriction_user_login_validate` on `user_login_form` → sets form error if outside window.
- `ValidRequestEventSubscriber` (RESPONSE event, prio 5) → `user_logout()` + redirect to
  `user.login?access_logout=1` when the window has closed for the current user.

Routes: `/ltr_access-time-confirmed` and `/ltr_confirm_logout` require `_user_is_logged_in`; the logout
route also requires `_csrf_request_header_token`. Field edit gated by permission
`allow access time modification` (restrict access: true) — users can't set their own window.

Security: enforcement is server-side on both login and every request, and CSRF-protected on the logout
route; no obvious bypass found.
