<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Reference Select Create (entity_reference_select_create) — agent index

A field widget that renders an `entity_reference` field as a **select list** (core dropdown) and
appends a modal **"Create"** button. Clicking it opens the target entity's own creation form in a
Drupal AJAX dialog; on save the new entity is appended to the select as a pre-selected option with
no page reload. Package `Custom`. **Core-only**, no contrib deps. `core_version_requirement:
^10 || ^11`. License GPL-2.0-or-later. Version 1.0.2-alpha1.

- **The widget, its settings, and the full inline-create flow (modal route, form_alter, AJAX)** →
  [fields/widget.md](fields/widget.md)

## What it actually is

- One plugin: `EntityReferenceSelectCreateWidget` (id **`entity_reference_select_create`**, label
  *"Select list with create button"*), in
  `src/Plugin/Field/FieldWidget/EntityReferenceSelectCreateWidget.php`, **extends core
  `OptionsSelectWidget`**. `field_types = { "entity_reference" }`, `multiple_values = TRUE`.
- One controller: `EntityReferenceSelectCreateController::form()` renders the target entity's
  creation form for the modal.
- One route: **`entity_reference_select_create.modal_form`** at
  `/admin/entity-reference-select-create/{entity_type}/{bundle}/{form_mode}/{field_name}`,
  `_permission: 'access content'`. The controller itself enforces the entity `create` access.
- One AJAX command: `SelectCreateOptionCommand` (client command `entityReferenceSelectCreate` in
  `js/entity-reference-select-create.js`) that appends the new option to the select.
- One hook: `hook_form_alter()` in `.module` wires the modal form's submit to AJAX.
- **No permissions.yml, no config schema, no config/install, no services, no submodules, no Drush,
  no settings/config route.** Configuration is entirely per-field via Manage form display.

## Settings (widget `defaultSettings()`)

`target_bundle` (`''`; a select shown only when the field allows >1 target bundle), `form_mode`
(`'default'`), `button_label` (`'Add'`), plus everything inherited from `OptionsSelectWidget`.
Details in [fields/widget.md](fields/widget.md).
