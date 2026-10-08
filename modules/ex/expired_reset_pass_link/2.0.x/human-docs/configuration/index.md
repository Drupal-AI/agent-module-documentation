# Configuration

Expired Reset Pass Link adds a single, focused setting: how long a password‑reset
(one‑time login) link remains valid. There's nothing else to configure.

## Set the timeout in the UI

1. Log in as a user with the **Administer account settings** permission (an
   administrator by default).
2. Go to **Configuration → People → Account settings**, or navigate directly to
   `/admin/config/people/accounts`.
3. Find the **password‑reset link timeout** setting that this module adds. Enter
   the number of seconds a reset link should stay valid.
4. Click **Save configuration**.

### Choosing a value

Drupal's built‑in default is **86400 seconds (24 hours)**. Shortening it reduces
the window in which a leaked or forwarded reset link could be misused, which is the
security benefit of this module. A common tightened value is **3600** (one hour) —
long enough for a legitimate user to receive the email and click through, but far
shorter than a full day. Balance security against your users' habits: too short and
people whose email is delayed will find their link already expired and have to
request another.

## Alternative: set it in `settings.php`

The setting maps to Drupal's core `user.settings` value, so you can also set it
directly in `settings.php` (useful for keeping the value under version control or
enforcing it per environment):

```php
$settings['user.settings']['password_reset_timeout'] = 3600;
```

The value is in **seconds**. A value defined this way in `settings.php` overrides
the configured value, so if you manage it here, treat the UI field as informational
for that environment.
