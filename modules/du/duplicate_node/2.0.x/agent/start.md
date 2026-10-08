<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Duplicate Node Layout & Block (duplicate_node) — agent index

Clones a node into a pre-filled **new node edit form** (paragraphs deep-cloned, translations
copied, re-owned to current user), with optional **Layout Builder** layout + inline-block
duplication. Depends on core **`node`** + **`layout_builder`**. No composer deps. Core
`^9 || ^10 || ^11`. License GPL-2.0-or-later. Version **2.0.x** (installed 2.0.2).

## What it provides

- **Route** `duplicate_node.node.duplicate_node` — `/duplicate/{node}/duplicate_node`, custom
  access, renders a node edit form built from a duplicate; a Duplicate **tab**
  (`*.links.task.yml`), **contextual link** (`*.links.contextual.yml`), and entity **operation**
  (`hook_entity_operation`).
- **Two settings routes/forms**: `duplicate_node.settingsform`
  (`/admin/config/duplicate-node-settings`) and `duplicate_node.paragraph_settings_form`
  (`/admin/config/duplicate-node-settings-paragraph`), both gated by
  `Administer Duplicate Node Settings`.
- **Permissions**: static `Administer Duplicate Node Settings`; dynamic per-type
  `duplicate {type} content` via `DuplicateNodePermissions::duplicateTypePermissions`
  (`permission_callbacks`).
- **Config object** `duplicate_node.settings` (no config schema shipped).
- **Services**: `duplicate_node.entity.form_builder` (the duplication engine),
  `duplicate_node.node_finder`, `duplicate_node.address_event_subscriber`.
- **Views field** `duplicate_node_link` (plugin `DuplicateLink`) via `hook_views_data_alter`.
- **Hooks**: `hook_entity_type_build` (adds `duplicate_node` node form op),
  `hook_entity_operation`, `hook_form_alter` (moderation-state grouping), `hook_help`.
- **Alter hooks for integrators** (`duplicate_node.api.php`): `hook_duplicated_node_alter`,
  `hook_duplicated_node_paragraph_field_alter`.

## Solution docs

- Route, controller, duplicate flow, access model, permissions →
  [routes/duplicate.md](routes/duplicate.md)
- Settings forms, `duplicate_node.settings` keys, field/paragraph exclusion, Layout Builder
  block duplication → [config/settings.md](config/settings.md)
- Duplication engine, finder, address subscriber, Views field, hooks →
  [api/internals.md](api/internals.md)
