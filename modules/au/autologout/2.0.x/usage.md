Automated Logout logs users out after a configurable period of inactivity, with an optional warning dialog and countdown, to protect unattended sessions.

---

Autologout adds an idle-session timeout to a Drupal site: after a set number of seconds without activity a user is automatically logged out and (optionally) redirected. A JavaScript timer runs in the browser, periodically dialing back to the server to keep the session alive while the user is active and to fetch the remaining time; when the timer expires the module ends the session server-side. Before logging out it can show a modal warning dialog with a countdown and Yes/No buttons so the user can stay logged in. Timeouts can be global, per-role (with a choice of the highest or lowest matching role value), or per-user (users with a permission can set their own threshold). Site builders configure everything on one settings form at Admin → Configuration → People → Automated logout, including the timeout, padding, warning message, redirect URL, admin-page enforcement, IP allow-list, and dialog text. A warning block is provided, and developer hooks let other modules prevent logout on specific pages, force refresh-only behavior, or react after an autologout occurs. Configuration is stored as `autologout.settings` plus per-role `autologout.role.*` objects, all exportable.

---

- Automatically log out staff after N minutes of inactivity for security compliance.
- Protect unattended admin sessions on shared or kiosk computers.
- Show a warning dialog with a countdown before logging a user out.
- Let users click "Yes" to extend their session before timeout.
- Set a global inactivity timeout for the whole site.
- Configure different timeout values per role (e.g. editors vs admins).
- Use the highest (or lowest) timeout when a user has multiple roles.
- Allow trusted users to set their own logout threshold.
- Redirect logged-out users to a custom URL (e.g. a login or notice page).
- Include the current page as a destination so users return after re-login.
- Enforce (or exempt) autologout on administrative pages.
- Display a custom "you have been logged out due to inactivity" message.
- Keep a session alive while a user is filling a long form via a refresh-only page.
- Prevent autologout on specific pages using `hook_autologout_prevent()`.
- Trigger custom cleanup after an autologout via `hook_autologout_user_logout()`.
- Add an IP allow-list so certain networks are never auto-logged-out.
- Place a warning/countdown block in a region of the theme.
- Set the modal dialog width, title, and Yes/No button labels.
- Log autologout events to watchdog for auditing.
- Use an alternate (non-AJAX) logout method for cached or edge cases.
- Force secure/HttpOnly cookies for the autologout timer cookie.
- Meet HIPAA/PCI-style requirements for automatic session termination.
- Reduce risk of session hijacking on abandoned workstations.
- Migrate legacy Drupal 6/7 autologout role settings via the provided migrate plugins.
- Give anonymous-facing kiosk logins a short forced session lifetime.
