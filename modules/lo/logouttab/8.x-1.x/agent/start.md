<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Logout Tab (logouttab) — agent index

Adds a **"Log out" local task** to `/user/{user}`. Route `entity.user.logouttab` requires only
`_user_is_logged_in: 'TRUE'`; the tab is hidden on other users' profiles by
`hook_menu_local_tasks_alter()` (a **display-level** check). Settings at
`/admin/config/people/logouttab` behind `administer users`. Version **8.x-1.2**.
Core requirement `^9.1 || ^10 || ^11`.

**On Drupal 10/11 the tab does not log you out — verified on a clean install.**
`LogouttabController::logout()` does **not** end the session; it redirects to a configured path
(default `user/logout`). Core has since added CSRF protection there:
```yaml
user.logout:
  requirements:
    _user_is_logged_in: 'TRUE'
    _csrf_token: 'TRUE'
  options:
    _csrf_confirm_form_route: 'user.logout.confirm'
```
So a token-less redirect is sent to the confirmation form. Following the tab lands on
`/user/logout/confirm` — *"Are you sure you want to log out?"* — with the session **still active**.

**This is core working as designed** (it is why logout cannot be triggered from another site), not a
vulnerability. But the module's single feature now costs an extra click and does not do what the tab
says. **Core's own account-menu logout link carries the token and works in one click.**

Note the controller is harmless for other uids since it only redirects — the display-level tab check
is adequate here.
