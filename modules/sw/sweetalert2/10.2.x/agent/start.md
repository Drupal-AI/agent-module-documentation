<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# SweetAlert2 (sweetalert2) — agent index

Asset-library wrapper for the **SweetAlert2** JavaScript library (styled `alert()`/`confirm()`
replacement modals via `Swal.fire()`). The whole module is three files: `sweetalert2.libraries.yml`
declares the library `sweetalert2_js`, `sweetalert2.module` attaches it, and `sweetalert2.install`
verifies the JS asset is present. There is no config form, no route, no service, no permission, no
block and no plugin type.

The one behavioural fact that matters: **`hook_preprocess_page()` attaches the library on every
page** (`sweetalert2.module:30`, `$variables['#attached']['library'][] = 'sweetalert2/sweetalert2_js'`),
so enabling the module loads `sweetalert2.all.js` site-wide with no further wiring. You do **not**
need to attach the library yourself — you only write JS that calls `Swal.fire({...})`. The library
is **not bundled**: `hook_requirements()` (`sweetalert2.install:17`) checks for
`DRUPAL_ROOT/libraries/sweetalert2/dist/sweetalert2.all.js` and shows `REQUIREMENT_ERROR` if it is
absent, so a "module enabled but dialogs still look native" report is almost always a missing
library file, not a code fault — check the status report first. The module version tracks the
wrapper, not the upstream library; confirm which SweetAlert2 version is actually on disk before
relying on a specific API.

- Depends on: nothing (no `dependencies:` in `sweetalert2.info.yml`).
- Core: `^8 || ^9 || ^10 || ^11`. Package: `Other`.
- Settings page / configure route: none. Permissions: none. Drush: none. Services: none. Routes: none.
- Plugin types: none. Config schema: none.
- Hooks implemented: `hook_help` (`help.page.sweetalert2`), `hook_preprocess_page`, `hook_requirements`.

## Key facts (real machine names)
- Library: `sweetalert2/sweetalert2_js` — serves `/libraries/sweetalert2/dist/sweetalert2.all.js`,
  `dependencies: [core/drupal.ajax]` (`sweetalert2.libraries.yml`).
- Expected library path on disk: `libraries/sweetalert2/dist/sweetalert2.all.js` (project root).
- JS entry point (yours): `Swal.fire({ icon, title, text, ... })` — see https://sweetalert2.github.io.
- Files: `sweetalert2.libraries.yml`, `sweetalert2.module`, `sweetalert2.install`, `README.md`,
  `LICENSE.txt`.
