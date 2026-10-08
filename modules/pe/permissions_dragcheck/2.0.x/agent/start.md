<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions DragCheck (permissions_dragcheck) — agent index

A client-side UX enhancement for the core permissions admin page (`admin/people/permissions`,
route `user.admin_permissions`). It lets an admin tick a run of permission checkboxes by clicking and
dragging across them, and tints each cell green when checked / lemon when unchecked for at-a-glance
feedback. It is **JavaScript only**: it attaches libraries to the core permissions form and changes
nothing server-side — the permission grant/save is still core's own form submit. Version **2.0.2**.

Mechanism (whole module is ~40 lines of PHP + 15 lines of JS): `permissions_dragcheck.module`
implements two hooks. `hook_help()` prints a one-line help blurb on the `user.admin_permissions`
route. `hook_form_user_admin_permissions_alter()` attaches two libraries to the form's
`#attached['library']`. The behavior in `js/init.js` (`Drupal.behaviors.permissions_dragcheck`)
binds to `table#permissions :checkbox:not([readonly],[disabled])`, sets the cell background colour on
`change`, and calls `.dragCheck()` (from the bundled third-party jQuery plugin) to enable drag
selection. There is no PHP that reads, writes, or authorises anything.

- Depends on: nothing declared in info.yml (`dependencies:` absent). Runtime front-end dep only:
  core `jquery`, plus the external **scarlac/drag-check-js** library, which the site admin must drop
  into `/libraries/drag-check-js/` (loaded from `/libraries/drag-check-js/dist/jquery.dragcheck.js`).
- Core: `^8.9 || ^9 || ^10 || ^11`.
- Package: none (no `package:` in info.yml).
- Settings page / configure route: none (`configure` null).
- Permissions: none (runtime-verified: 0 provided). Routes: none. Services: none. Config schema:
  none (no `config/` dir). Plugin types: none. Drush: none.
- No security surface (pure client-side JS attached to the core form; server-side save is untouched).

## What you'd do → where
- **Install the JS library, how the form_alter attaches, and how the drag/colour behavior works** →
  [usage/drag-select.md](usage/drag-select.md)
- Use it: open `admin/people/permissions`, then click-and-drag across a column/run of checkboxes to
  tick them all, then **Save permissions**. Nothing to configure.
- Install the JS library: place scarlac/drag-check-js under `/libraries/drag-check-js/` (see
  README for the composer `type: package` snippet). Without it the module still enables but the drag
  behavior no-ops (the plugin's `.dragCheck()` is undefined).

## Key facts (real machine names)
- Hooks: `permissions_dragcheck_help`, `permissions_dragcheck_form_user_admin_permissions_alter`
  (in `permissions_dragcheck.module`).
- Altered form: `user_admin_permissions` (route `user.admin_permissions`, path
  `admin/people/permissions`).
- Libraries (`permissions_dragcheck.libraries.yml`): `permissions_dragcheck/drag-check-js`
  (the third-party plugin + `js/init.js`, dep `core/jquery`) and
  `permissions_dragcheck/permissions-drag-check` (`js/init.js`, dep `core/jquery`).
- JS: `js/init.js` — `Drupal.behaviors.permissions_dragcheck`, selector `table#permissions
  :checkbox`, `.dragCheck()`, cell colours `#73B355` (checked) / `#FFFACD` (unchecked).
- External front-end library: `scarlac/drag-check-js` at `/libraries/drag-check-js/dist/jquery.dragcheck.js`.
