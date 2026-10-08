<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Bring Back jQuery.once() — agent index

Re-adds the `core/jquery.once` asset library (jquery-once 2.2.3) and re-defines `core/jquery`
(3.7.1) so legacy `$(sel).once('id')` JavaScript keeps working on Drupal 10/11.
**Zero configuration**: no settings form, `configure: null`, no permissions, no services,
no plugins, no Drush, no config schema, no submodules. Enable + `drush cr` is the whole setup.

- **The libraries it provides, how to depend on them, and the `$.fn.once` API** →
  [api/libraries.md](api/libraries.md)

Key facts:

- The only code is `jquery_once_library_info_alter()` in `jquery_once.module`, which fires when
  `$extension === 'core'`.
- `core/jquery` → version `3.7.1`, js `/<module path>/lib/jquery_3.7.1_jquery.min.js`, weight `-20`.
- `core/jquery.once` → version `2.2.3`, js `/<module path>/lib/jquery-once-2.2.3/jquery.once.min.js`,
  weight `-19`, depends on `core/jquery`.
- The same pair is also declared under this module's own namespace:
  `jquery_once/jquery` and `jquery_once/jquery.once`.
- It does **not** touch `core/once` / `Drupal.once` — both APIs coexist.
