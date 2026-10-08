<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Better Entity Reference Demo (better_entity_reference_demo) — agent index

Submodule of **better_entity_reference**. Reference/example code proving the parent's popover JS
API (`Drupal.berUI` + `Drupal.berTags`) is usable and extendable from a third-party module without
patching. Version `1.0.x` (ships with the parent, beta12). Package *Better Entity Reference*.
License GPL-2.0-or-later. Not for production.

- **Dependency:** `better_entity_reference:better_entity_reference`. Core `^10.6 || ^11.3 || ^12`.
- **No config, no permissions, no config schema.**

## What it provides (from source)

- **Route** (`better_entity_reference_demo.routing.yml`): `better_entity_reference_demo.page` at
  `/better-entity-reference/demo`, `_permission: 'access content'` — a read-only demo page
  (`src/Controller/DemoController.php`). The page renders a static intro (translatable literals,
  no user input) plus a mount point whose `data-ber-demo-items` is `json_encode()` of the fixed
  `DemoFruitItem::catalog()`; all interactivity is composed in `js/demo.js`.
- **Custom field plugins** (`src/Plugin/Field/`): field type `ber_demo_fruit` (`DemoFruitItem`),
  widgets `ber_demo_picker` (`DemoPickerWidget`, raw kit) and `DemoElementPickerWidget` (via the
  parent's `better_options` element), formatter `ber_demo_fruit` (`DemoFruitFormatter`, emoji tags).
- **Hooks** (`src/Hook/Hooks.php` + `.module` legacy shim): `hook_page_attachments`. The `.install`
  adds a *Demo fruit* field to the `test` content type on install **only if that type exists**, and
  removes the field storage on uninstall.
- **Services:** `Hook\Hooks` (autowired). **Libraries:** `better_entity_reference_demo/demo`
  (`js/demo.js`, `js/extend.js`).

## Notes

- `js/extend.js` is a documented reference for every parent widget extension event
  (`ber-ui:build*`, toolbar/list/button/upload hooks, and the in-flow `root.berTags` API).
- No security-relevant surface: the only route is a read-only page; the JSON payload is a fixed
  server-side catalog, not user data.

Parent index: [../../../../agent/start.md](../../../../agent/start.md).
JS kit reference: [../../../../agent/api/javascript.md](../../../../agent/api/javascript.md).
