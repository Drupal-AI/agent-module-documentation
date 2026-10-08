# Configure

## Settings form

Route `remove_reset_password.remove_reset_password` →
`/admin/config/people/reset-password-form-settings` (menu link *Configuration → People →
Remove Reset password*). Access: core permission **`administer site configuration`**. Form
`ResetPasswordSettingsForm` (a `ConfigFormBase`) editing `remove_reset_password.settings`:

| Setting | Effect |
|---|---|
| `remove_reset_password_button` | Hides the *Reset your password* tab on the login page for anonymous users **and** makes the `user.pass` route return 403 for anonymous users. |
| `remove_all_local_tabs` | Hides **all** local tabs on the login page for anonymous users (visual only). |

```yaml
# remove_reset_password.settings
remove_reset_password_button: true
remove_all_local_tabs: false
```

No config schema ships with the module (settings are plain booleans). Values can be overridden
per environment via `$config['remove_reset_password.settings'][...]` in `settings.php`.

## How it is enforced

1. **Tab hiding** — `remove_reset_password_menu_local_tasks_alter()` runs on the `user.login`
   route: if `remove_all_local_tabs`, sets `#access = FALSE` on every tab in
   `$data['tabs'][0]`; else if `remove_reset_password_button`, hides only the `user.pass` tab.
   This is presentation only.
2. **Route blocking** — `PasswordSubscriber::checkAccess()` on `KernelEvents::REQUEST`
   (priority 30): when the request route is `user.pass`, `remove_reset_password_button` is set,
   and the current user is anonymous, it throws `AccessDeniedHttpException`. So hiding the
   button also prevents anonymous users reaching `/user/password` directly.

## Behaviour notes / gotchas

- The server-side block is tied to `remove_reset_password_button` only. `remove_all_local_tabs`
  hides tabs visually but does **not** by itself block the `user.pass` route.
- Authenticated users are never blocked from `user.pass` by this module (fails closed toward
  keeping access for logged-in users; only anonymous access is denied).
- Other routes are unaffected — the subscriber early-returns unless the route is `user.pass`.
