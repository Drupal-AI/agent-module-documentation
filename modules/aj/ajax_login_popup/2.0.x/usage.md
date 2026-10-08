<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Ajax Login Popup shows the user login form in an AJAX modal instead of navigating to /user/login, with configurable post-login redirection.

---

Install the module and configure redirection at /admin/config/ajax_login_popup/setting (permission: administer site configuration). The login form is served at /user/path and only to anonymous users (_user_is_logged_in: FALSE); it extends the core UserLoginForm, so authentication uses core user.auth plus flood control.

---

- Show the login form in an AJAX modal.
- Serve the form at /user/path for anonymous only.
- Extend the core UserLoginForm.
- Reuse core user.auth and flood protection.
- Configure post-login redirection in settings.
- Gate settings behind 'administer site configuration'.
- Set uid only after successful password auth.
- Restrict the login route to logged-out users.
- Improve login UX without a full page load.
- Serve as a login/theming enhancement.
- Provide one settings form and one login route.
- Note: verified sound (no auth bypass).
- Depend on no other contrib modules.
- Keep credentials handled by core auth.
- Work on Drupal 9 and 10.
- Redirect users after login per config.
- Present a themed modal dialog.
- Avoid custom password handling.
