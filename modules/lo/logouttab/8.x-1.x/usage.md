<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Logout Tab adds a "Log out" local task to the user profile page, next to View and Edit.

---

The intent is a small usability one: on a site where the account menu is not prominent, or a theme where logging out means finding a link in a footer, a tab on the profile page is a predictable place to look. The module adds the tab, hides it on other users' profiles through `hook_menu_local_tasks_alter()`, and makes its weight and target configurable. Version **8.x-1.2** on core `^9.1 || ^10 || ^11`. **On Drupal 10 and 11 the tab does not log you out**, and the reason is a core change rather than a bug in the module. `LogouttabController::logout()` does not end the session — it redirects to a configured path, which defaults to `user/logout`. Core has since added CSRF protection to that route: `user.logout` now requires `_csrf_token: 'TRUE'` with `_csrf_confirm_form_route: 'user.logout.confirm'`, so a plain redirect with no token is sent to a confirmation form instead. Verified on a clean install — following the tab lands on `/user/logout/confirm` showing *"Are you sure you want to log out?"*, and the session is still active. The behaviour is safe (core's protection is working exactly as designed, and this is why logout links cannot be triggered from another site), but the module's single feature now costs an extra click and does not do what the tab says. Anyone adopting it should check whether that is acceptable, or use core's own account menu logout link, which carries the token and works in one click.

---

- Add a logout link to the user profile.
- Give users a predictable logout location.
- Add a logout tab for a custom theme.
- Provide logout where the account menu is hidden.
- Add logout to a profile page.
- Configure the logout redirect target.
- Set the logout tab's position.
- Support a simplified user interface.
- Add logout for kiosk users.
- Provide logout on a mobile theme.
- Add a visible sign-out control.
- Support a site without an account menu.
- Give editors an obvious logout.
- Add logout to a member area.
- Provide logout on a profile-centric site.
- Configure where logout sends users.
- Add a sign-out tab for clarity.
- Support an accessibility request for a visible logout.
