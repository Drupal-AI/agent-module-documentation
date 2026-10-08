<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CakePhPass

## What it is / when to use

- Overrides Drupal's `password` service so users migrated from a CakePHP application can log in with their original (CakePHP-format) password hashes.
- Useful only during or after a content/user migration from CakePHP into Drupal, where existing hashes are stored with a `$C$` prefix.
- Purely a login-compatibility shim; it does not create UI, routes, or config entities.

---

## Install & configure

- Install like any module (`composer require drupal/cakephpass`, then enable). It registers `CakephpassServiceProvider` which swaps the core `password` service class for `CakePhPassword`.
- All behaviour is driven from `settings.php` under the `cakephpass` settings key — there is no admin form.
- Add to `settings.php`: `$settings['cakephpass'] = ['enabled' => TRUE, 'salt' => '<cakephp-salt>', 'type' => 'sha1_strict'];`
- If `enabled` is not set/true, or a hash does not start with `$C$`, the module does nothing and core hashing applies.

---

## Usage & API notes

- `CakePhPassword::check()` first delegates to core `PhpassHashedPassword::check()`; only if that fails and the stored hash begins with `$C$` does it attempt CakePHP verification.
- CakePHP verification requires a non-empty `salt` in settings; without it, verification returns FALSE.
- Supported `type` values: `sha1_strict` (default), `sha256_strict`, or any algorithm accepted by PHP `hash()`.
- The hashed string is computed as `salt . password`, matching CakePHP's `Security::hash()` legacy behaviour.
- Comparison uses `hash_equals()`, so the check is timing-attack resistant.
- On first successful login the account keeps its legacy hash; core does not automatically re-hash it to the modern algorithm.
- The module intentionally supports weak legacy algorithms (SHA1/MD5) — only for accounts already carrying such hashes.
- If none of the configured hash functions are available it falls back to `md5()`.
- Because it is gated behind both the `$C$` prefix and the `enabled` flag, default installs do not weaken core authentication.
- There is no route, block, permission, or service beyond the password-class override.
- To retire legacy hashes, force a password reset for migrated users after go-live.
- Uninstalling reverts the `password` service to Drupal core's implementation.
- Only affects verification; new passwords set in Drupal are hashed with core's phpass algorithm.
- The `$C$` prefix is stripped before comparison (note: implementation uses `ltrim`, which strips characters, not the exact prefix).
- Keep the CakePHP `salt` value in sync with the source application, or migrated logins will fail.
- No external services or network calls are made.
