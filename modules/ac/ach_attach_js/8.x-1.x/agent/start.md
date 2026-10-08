<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ACH Attach JS (ach_attach_js) — agent index

A tiny front-end helper for **Acquia Lift + Acquia Content Hub**. It ships one asset library that
listens for Lift's `acquiaLiftContentAvailable` browser event and calls **`Drupal.attachBehaviors()`**
on the injected decision-slot markup, so Drupal JS behaviors run on content Lift adds *after* page
load. Package `Acquia`. Core requirement `^9.2 || ^10 || ^11`. License GPL-2.0-or-later.
Version `8.x-1.0-alpha6`. **Unsupported / obsolete upstream**, not security-advisory covered.

- **The library, the event bridge, and every way to attach it** → [api/library.md](api/library.md)
- **The Attacher sub-module (path-based attachment config form)** →
  documented in its own tree:
  `modules/ac/ach_attach_js/modules/ach_attach_js_attacher/8.x-1.x/`

## What it actually is

- **No PHP, no plugins, no routes, no permissions, no config** in the parent module. It is purely
  a Drupal library definition plus one JS file.
- `ach_attach_js.libraries.yml` declares library **`ach-attach-js`** → `js/ach-attach-js.js`,
  depending on core libs `core/drupal`, `core/drupalSettings`, `core/jquery`, `core/once`.
- `js/ach-attach-js.js` = `Drupal.behaviors.achAttachJs`. On first attach (guarded by
  `once('ach-attach-js', 'body')`) it registers a `window` listener for **`acquiaLiftContentAvailable`**;
  when fired it finds `$('[data-lift-slot="' + e.detail.decision_slot_id + '"]')` and calls
  `Drupal.attachBehaviors($slot[0], drupalSettings)`.
- Nothing runs unless the library is attached to a page — the parent does not attach it itself.

## Dependencies

- Core only (`core/drupal`, `core/drupalSettings`, `core/jquery`, `core/once`). No composer
  requirements, no contrib deps. Acquia Lift/Content Hub is an external front-end product, not a
  Drupal module dependency.

## Submodule

- **`ach_attach_js_attacher`** — optional; provides an admin form to attach the `ach-attach-js`
  library on chosen paths (core Request Path condition). See its own doc tree.

## Attaching the library (summary)

- Sub-module UI (paths), or manually: theme `.info.yml` `libraries:`, `#attached['library'][] =
  'ach_attach_js/ach-attach-js'`, or Twig `attach_library('ach_attach_js/ach-attach-js')`.
- Full detail in [api/library.md](api/library.md).
