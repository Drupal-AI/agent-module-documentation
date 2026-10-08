<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# hook_disable_login_key_alter()

The one hook the module invites (declared in `disable_login.api.php`). It lets custom code
override the secret *value* at runtime, so you can rotate keys or source them externally instead
of storing a static value in config.

```php
/**
 * Implements hook_disable_login_key_alter().
 *
 * @param string $secret
 *   The secret key value, passed by reference.
 */
function mymodule_disable_login_key_alter(&$secret) {
  // Example: rotate monthly.
  $secret = 'login-' . date('Y-m');
  // Or pull from an environment variable / key store.
  // $secret = getenv('LOGIN_SECRET');
}
```

## When it fires

- In `DisableLoginAccessCheck::access()` — the module handler runs
  `->alter('disable_login_key', $secret_key)` on the stored `secret` before the constant-time
  `hash_equals()` comparison, so the altered value is what the incoming `?<querystring>=...` must
  match. The alter effectively changes the required URL.
- In `SettingsForm::buildForm()` — it runs the same alter on the stored `secret`; if the value
  changes, the form adds a read-only "Altered secret key" item so an admin can see the effective
  value.

## Notes

- `$secret` is passed by reference; assign to it, don't return.
- The `querystring` (parameter name) is **not** alterable via this hook — only the value.
- The alter runs on every login-page access check, so keep it cheap (no heavy I/O).
- The alter does not bypass IP flood control: an IP that has exceeded `user.flood:ip_limit` is
  still forbidden for the rest of the window even if it later supplies the altered key.
