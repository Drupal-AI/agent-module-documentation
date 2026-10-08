<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# migmag_callback_upgrade — agent index

Backports core 9.2's `callback` process plugin (with `unpack_source`) to older cores. **No-op
on Drupal 9.2+ / 10 / 11.** No config, routes, permissions, Drush, or dependencies.

- **The version gate & MigMagCallback class** → [api/callback.md](api/callback.md)

Key fact: `hook_migrate_process_info_alter()` sets the `callback` plugin's class to
`MigMagCallback` **only when** `\Drupal::VERSION < 9.2.0`. On this Drupal 11 site the condition
is false, so the `callback` plugin definition is unchanged (still core
`Drupal\migrate\Plugin\migrate\process\Callback`).
