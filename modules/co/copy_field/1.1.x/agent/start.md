<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Copy field machine name (copy_field) — agent index

Per-content-type admin DX tool: adds a "Manage Copy fields" tab to a node type's
edit page that lists the bundle's `field_`-prefixed fields with a click-to-copy
button for each field machine name (uses bundled clipboard.js).

- **Version:** 1.1.x (`1.1.1`). **Core:** `^9 || ^10 || ^11`. **License:** GPL-2.0-or-later.
- **Runtime dependency:** core `node` module (alters node-type form, upcasts `entity:node_type`). No composer requirements, no external libraries (clipboard.js is vendored in `clipboardjs/`).
- **Provides:** no permissions, no config schema, no plugin types, no drush commands, no configuration route.

## What it provides

- **Route** `copy_feld.entity_field_copy` — `GET /admin/structure/types/manage/{node_type}/copy-field`
  → `CopyFieldListingController::copyField()`. Guarded by `_permission: 'administer content types'`
  **and** custom access `copy_field.config_condition_check::access` (note the route id typo "feld").
- **Local task tab** `copy_field.copy_field_tab` ("Manage Copy fields") under `entity.node_type.edit_form`.
- **Access check service** `copy_field.config_condition_check` (`Access\ConfigConditionCheck`) — allows only when `node.type.<bundle>:use_copy_field` is truthy; cache max-age 0.
- **Controller** `Controller\CopyFieldListingController` — builds a Label / Machine name table of `field_*` fields via `entity_field.manager`.
- **Hooks** (`copy_field.module`): `hook_form_alter` adds a "Use copy field" checkbox to `node_type_edit_form` (saved by `copy_field_node_type_form_submit` onto `node.type.<bundle>`); `hook_page_attachments` attaches the `copy_field/clipboard` library on the copy route; `hook_uninstall` clears the `use_copy_field` key from all `node.type.*` config.
- **Library** `copy_field/clipboard` (`copy_field.libraries.yml`) — `css/style.css`, vendored `clipboardjs/clipboard.min.js` + `clipboardjs/copy-to-clipboard.js`.

## Solution docs

- [How it works & operation](config/copy-field.md) — enable per bundle, route/access wiring, controller output, uninstall.
