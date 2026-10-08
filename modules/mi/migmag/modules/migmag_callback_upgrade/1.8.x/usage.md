<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Migrate Magician Callback Process Plugin Upgrade (`migmag_callback_upgrade`) backports Drupal core 9.2's improved `callback` migrate process plugin (which adds the `unpack_source` option) to older cores — and is a deliberate no-op on core 9.2 and later.

---

Core's `callback` process plugin gained an `unpack_source` option in Drupal 9.2, which lets a source array be spread as multiple arguments to the callable. On sites still on Drupal 8.x–9.1 you can't use `unpack_source`. This tiny submodule provides `Drupal\migmag_callback_upgrade\MigMagCallback` (extends core `Callback` and implements the newer `unpack_source` behaviour) and an implementation of `hook_migrate_process_info_alter()` that swaps the core `callback` plugin's class to `MigMagCallback` **only when** `version_compare(\Drupal::VERSION, '9.2.0', 'lt')` is true. On Drupal 9.2, 10, or **11 this condition is false, so the module changes nothing** — the core `callback` plugin is already the modern version. It exists purely for backwards compatibility on old cores. No configuration, routes, permissions, Drush commands, or dependencies. On this Drupal 11 site, enabling it has no observable effect on the `callback` plugin definition.

---

- Use `unpack_source` with the `callback` process plugin on a Drupal 8.x–9.1 site.
- Spread a source array as separate arguments to a callable in a migration on old core.
- Backport core 9.2's `callback` behaviour without upgrading core.
- Keep a legacy-core migration project using modern `callback` syntax.
- Enable on an old site so migrations written for 9.2+ still run.
- Provide `MigMagCallback` as the callback implementation on pre-9.2 cores.
- Avoid rewriting `callback` steps that rely on `unpack_source` for old-core compatibility.
- Confirm on modern core (9.2+/10/11) that the plugin is intentionally a no-op.
- Document why the module is present but inert on a Drupal 11 upgrade target.
- Support a staged upgrade where the source site is still on Drupal 8.
- Ship a consistent Migrate Magician bundle that also covers old cores.
- Let a shared migration codebase run on both old and new core versions.
- Understand the version gate (`< 9.2.0`) before expecting any effect.
- Remove the module safely on 9.2+ since it does nothing there.
- Keep `callback` process steps portable across core versions.
