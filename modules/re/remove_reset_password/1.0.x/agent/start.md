# Remove'Reset your password' — agent index

Hides the "Reset your password" tab (or all local tabs) on the login page for anonymous users,
and blocks the `user.pass` route server-side for anonymous users. No dependencies, no
permission of its own; config route gated by core `administer site configuration`.

- **The two settings, the config object, the tab-hiding hook and the route-blocking event
  subscriber** → [configure/settings.md](configure/settings.md)

Key facts:
- Config route `remove_reset_password.remove_reset_password` →
  `/admin/config/people/reset-password-form-settings` (perm `administer site configuration`).
- Config object `remove_reset_password.settings` (no schema shipped): booleans
  `remove_reset_password_button`, `remove_all_local_tabs`.
- `hook_menu_local_tasks_alter()` hides the `user.pass` tab (or all `data['tabs'][0]` tabs) on
  the `user.login` route — visual only.
- `PasswordSubscriber` (`KernelEvents::REQUEST`, prio 30): if `remove_reset_password_button`
  and the user is **anonymous** and route is `user.pass` → `AccessDeniedHttpException`.
  Fails closed: only anonymous, only that route, only when the flag is set.
