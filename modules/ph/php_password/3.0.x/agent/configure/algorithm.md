<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure PHP Password algorithm

## What it does
`PhpPasswordServiceProvider::alter()` runs during container build. If the core `password`
service definition has **no** arguments (true on 10.4/10.5/11.1/11.2) **and** a
`password.algorithm` container parameter is set, it injects:
```
[ password.algorithm , password.options (or []) ]
```
On core ≥ 10.6/11.3 the service already carries arguments, so the provider does nothing.
No hashing logic is added — core's `PhpPassword` uses PHP `password_hash()`.

## Set the parameters
Add to an existing services file (e.g. `sites/default/services.yml`):
```yaml
parameters:
  password.algorithm: argon2id      # argon2i | argon2id | 2y (bcrypt)
  password.options: []              # options array passed to password_hash()
```
If you don't already load a site services file, create one and register it in settings.php:
```php
$settings['container_yamls'][] = DRUPAL_ROOT . '/sites/default/services.yml';
```
Rebuild caches after changing parameters.

## Verify
Hash a value and inspect it:
```php
$info = password_get_info(\Drupal::service('password')->hash('test'));
// $info['algo'] should match the configured algorithm.
```

## Notes
- argon2i/argon2id require PHP compiled with libargon2.
- Existing bcrypt hashes remain valid; accounts re-hash to the new algorithm on next login.
- Options example (argon2): `{memory_cost: 65536, time_cost: 4, threads: 1}`; (bcrypt): `{cost: 12}`.
