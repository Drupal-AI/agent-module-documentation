# Configuration

CakePhPass has **no admin form**. Everything is controlled from a single
settings block you add to your site's `settings.php` (or `settings.local.php`).
Until you add it and set `enabled` to `TRUE`, the module stays dormant and
Drupal's normal password handling applies.

## The settings block

Add this to `settings.php`:

```php
$settings['cakephpass'] = [
  'enabled' => TRUE,
  'salt'    => '<your-cakephp-salt>',
  'type'    => 'sha1_strict',
];
```

### What each key does

- **`enabled`** — the master switch. If it is not set, or not `TRUE`, the module
  does nothing at all.
- **`salt`** — the salt value from your original CakePHP application. CakePHP
  hashed passwords as `salt . password`, so verification will only succeed if
  this exactly matches the source application's salt. A missing or empty salt
  makes verification fail every time. Keep it in sync with the source app.
- **`type`** — the hashing algorithm. Supported values are `sha1_strict`
  (the default), `sha256_strict`, or any algorithm name accepted by PHP's
  `hash()` function. (If none of the configured hash functions are available,
  the module falls back to `md5()`.)

## How verification behaves

- On each login, Drupal's core password check runs first. CakePhPass only takes
  over when that check fails **and** the stored hash begins with `$C$` **and**
  `enabled` is `TRUE`.
- Comparison uses PHP's `hash_equals()`, so it is resistant to timing attacks.
- A successful legacy login does **not** automatically re-hash the account to
  Drupal's modern algorithm — the account keeps its legacy hash until the
  password is changed.

## Recommended clean-up

Because this keeps weak legacy hashes (SHA1/MD5) alive, the recommended path is
to **force a password reset for migrated users after go-live**. Once everyone
has reset, their accounts are re-hashed with Drupal's modern algorithm and you
can remove the `settings.php` block and uninstall the module. Uninstalling
reverts the `password` service to Drupal core's implementation.
