<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Body Class (body_class) — agent index

Stores a per-node string of space-separated CSS classes and emits them onto the `<body>` tag of that
node's canonical page. All logic lives in **`body_class.module`** (no plugins, no entities, no fields,
no services, no Drush). Depends only on core **`node`**. Package `Other`. Core `^9 || ^10 || ^11`.
License GPL-2.0-or-later. Version 1.1.1.

- **Config form, usage list, permission, the DB table, and how the class reaches the body tag** →
  [config/settings.md](config/settings.md)

## What it actually is

- One custom DB table **`body_class`** (`hook_schema` in `body_class.install`): `nid` (int, PK) +
  `css_class` (varchar 255). Dropped on uninstall.
- Config object **`body_class.settings`** with a single key `enabled_content_types` (sequence;
  install default `['_all']`). Schema in `config/schema/body_class.schema.yml`.
- One permission **`administer body class`** (`restrict access: true`).
- Two admin routes (both `_permission: administer body class`):
  `body_class.settings` = `/admin/config/development/body_class` (settings form) and
  `body_class.admin_list` = `/admin/config/development/body_class/list`
  (`BodyClassListController::listPage`, usage table).
- One form class: `Form/BodyClassSettingsForm` (extends `ConfigFormBase`).

## Mechanism (from source)

- **Input:** `body_class_form_node_form_alter()` adds a `#type => textfield` "CSS Class(es)" field
  (group `additional_settings`, maxlength 255) — but only if the current user has `administer body
  class` and the node's bundle is in `enabled_content_types` (or `_all`). Default value is read from
  the `body_class` table for the node.
- **Validation:** `body_class_validate_css_classes()` splits on whitespace and rejects any token not
  matching `/^-?[_a-zA-Z]+[_a-zA-Z0-9-]*$/` (letters/underscore start, then letters/digits/hyphen/
  underscore).
- **Persistence:** submit handler `body_class_node_form_submit()` → `body_class_upsert($nid, $class)`
  (transaction-wrapped insert/update, or delete when empty). `hook_node_delete` removes the row;
  `hook_node_insert`/`update` also honor a programmatic `$node->body_class_value`. Field-edit access is
  re-checked in `body_class_entity_field_access()` (requires the same permission).
- **Output:** `body_class_preprocess_html()` runs only when the current route has a `node` parameter;
  it reads `css_class`, `explode(' ')`, runs each token through `Html::getClass()`, and appends to
  `$variables['attributes']['class'][]` (an Attribute array — no raw string concatenation).
- **Usage list:** `BodyClassListController` selects rows with a non-empty `css_class`, paged 50 via
  `PagerSelectExtender`, sortable via `TableSortExtender`; the class cell is rendered as
  `['#plain_text' => $record->css_class]`.

All DB access uses the query builder (parameterized). Cache tags `node:<nid>` are invalidated on every
write/delete; `config:body_class.settings` on config save.
