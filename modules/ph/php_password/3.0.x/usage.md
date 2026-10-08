<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
PHP Password is a forward-compatibility layer that lets you choose Drupal's password hashing algorithm (argon2id, argon2i, or bcrypt) via container parameters, backporting a core feature.

---

Drupal core is moving toward configurable password hashing algorithms. On Drupal 10.4/10.5 and 11.1/11.2 the core `password` service takes no constructor arguments (fixed algorithm); from 10.6/11.3 it accepts an algorithm and options. This module's `PhpPasswordServiceProvider` bridges that gap: in `alter()` it inspects the `password` service definition and, only when it currently has zero arguments and a `password.algorithm` container parameter is defined, injects that algorithm plus optional `password.options`. It adds no hashing code of its own — the actual hashing is done by core's PHP `password_hash()`-based implementation, so hashes carry the standard PHP prefixes and remain verifiable by core.

Configuration is done through container parameters in a `services.yml` (e.g. `sites/default/services.yml`): `password.algorithm` (`argon2id`, `argon2i`, or `2y`/bcrypt) and `password.options` (the option array passed to `password_hash`). Because it defers entirely to PHP's native, memory-hard algorithms and to core's password service, it is a sound approach — argon2id is a strong default and there is no home-grown crypto, weak RNG, or custom hash format. The only caveat is operational: choosing a weak algorithm/cost or misconfiguring options would weaken hashing, and argon2 requires PHP built with libargon2. Enabling the module is enough on the affected core versions; on newer core that already supports the parameters, the service already has arguments so the module cleanly does nothing.

---

- Switch Drupal password hashing to argon2id
- Use argon2i instead of the default bcrypt
- Keep bcrypt (`2y`) but tune its options
- Backport configurable hashing to core 10.4/10.5/11.1/11.2
- Set `password.algorithm` in `sites/default/services.yml`
- Pass `password.options` (memory/time/threads or cost) to `password_hash`
- Strengthen password storage without custom code
- Standardise the hashing algorithm across environments via config
- Load a custom services.yml through `$settings['container_yamls']`
- Verify the active algorithm with `password_get_info()` on a fresh hash
- Migrate existing hashes gradually as users log in and re-hash
- Adopt memory-hard hashing (argon2) where PHP supports it
- Keep hashes verifiable by Drupal core (standard PHP prefixes)
- Avoid patching core to change the password algorithm
- Rely on PHP native `password_hash` rather than bespoke crypto
- Let the module no-op safely on core that already supports parameters
- Choose argon2 options appropriate to server memory
- Document the chosen algorithm in unversioned services config
- Roll back by removing the parameters / disabling the module
- Audit password hashing strength during a security review
