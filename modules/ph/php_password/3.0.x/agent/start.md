<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# PHP Password algorithm (php_password) — agent index

**Forward-compat layer: sets Drupal's `password` service to a configurable PHP hashing algorithm (argon2id/argon2i/bcrypt) via container parameters.**

- **Version:** 3.0.x (release 3.0.0) · Core: ^10.4 || ^11.1
- **Mechanism:** `PhpPasswordServiceProvider::alter()` — if the core `password` service has 0 args and a `password.algorithm` parameter exists, injects `[password.algorithm, password.options]`
- **Config (container parameters, e.g. `sites/default/services.yml`):** `password.algorithm` (`argon2id` | `argon2i` | `2y`), `password.options` (array for `password_hash`)
- **No routes, no permissions, no forms.** Delegates all hashing to core's PHP `password_hash()` implementation.

See [configure/algorithm.md](configure/algorithm.md)

**Security:** Sound. No home-grown crypto — defers to PHP's native, memory-hard algorithms via core's password service; hashes stay standard and core-verifiable. Only caveat is operational (don't configure a weak algorithm/cost; argon2 needs libargon2). No security findings.
