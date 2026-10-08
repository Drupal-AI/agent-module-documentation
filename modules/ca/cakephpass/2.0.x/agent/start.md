<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# cakephpass — agent orientation

- Login-compatibility shim that lets CakePHP-migrated users authenticate with their legacy `$C$`-prefixed hashes.
- Mechanism: `src/CakephpassServiceProvider.php` swaps the core `password` service for `src/Password/CakePhPassword.php`.
- Config lives ONLY in `settings.php` under `$settings['cakephpass']` (`enabled`, `salt`, `type`); no admin UI, routes, or permissions.
- Verification runs only when core check fails AND hash starts with `$C$` AND `enabled` is TRUE; comparison via `hash_equals()`.
- Security note: intentionally supports weak SHA1/MD5 legacy hashes but only for already-migrated accounts; does not weaken default auth.
