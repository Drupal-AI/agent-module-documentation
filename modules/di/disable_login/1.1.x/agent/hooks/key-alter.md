# hook_disable_login_key_alter()

The one hook the module invites (`disable_login.api.php`). It lets custom code override the
secret value at runtime, so you can rotate keys or source them externally instead of storing a
static value in config.

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

- In `DisableLoginAccessCheck::hasValidSecretToken()` — the altered value is what the incoming
  `?<querystring>=...` must match. So the alter effectively changes the required URL.
- In `SettingsForm::buildForm()` — if a hook changes the stored `secret`, the form shows an
  extra read-only "Altered secret key" item so an admin can see the effective value.

## Notes

- `$secret` is passed by reference; assign to it, don't return.
- The `querystring` (parameter name) is **not** alterable via this hook — only the value.
- Because the alter runs on every login-page access check, keep it cheap (no heavy I/O).
