<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Group Field lite (entitygroupfield_lite) — agent index

Attaches per-group-type **computed** entity-reference base fields to content entities and ships one
field widget so editors can join/leave Group entities from the host entity's own edit form. Package
`Group`. Depends on **`group`** (drupal/group ^3.0) and **`form_options_attributes`** (^2.1). Core
`^10 || ^11`. License GPL-2.0-or-later. Installed release **1.0.0-beta2** (pre-release, SA not-covered).

- **The computed field, the group_select widget, and how relationships are created/deleted on save** →
  [fields/field-and-widget.md](fields/field-and-widget.md)

## What it actually is (from source)

- **No config**: no `*.routing.yml`, `*.permissions.yml`, `*.services.yml`, `*.links.*.yml`, no
  `config/install` or `config/schema`, no settings form, no Drush, no submodules. It is purely a
  field definition + a field widget plugin + one entity hook.
- **Computed base fields** — `src/Hook/EntityHooks.php` `EntityHooks::attachGroupFields()`
  (`#[Hook('entity_bundle_field_info')]`; legacy shim in `entitygroupfield_lite.module`). For every
  `group_type` it defines an `entity_reference` field `group_<group_type_id>` targeting entity type
  `group`, set `computed + customStorage + readOnly`, attached only to the host entity type/bundle a
  group relation plugin targets. Cardinality = the plugin's group cardinality (0 → unlimited).
  `field class` = `EntityGroupFieldItemList`.
- **Item list** — `src/Field/EntityGroupFieldItemList.php` (`EntityReferenceFieldItemList` +
  `ComputedItemListTrait`). `computeValue()` reads current memberships via
  `GroupRelationship::loadByEntity()`. `postSave()` diffs submitted vs existing relationships and
  calls `$group->addRelationship()` / `group_relationship` storage `delete()` to sync them. `preSave()`
  is intentionally a no-op.
- **Widget** — `src/Plugin/Field/FieldWidget/GroupSelectWidget.php`, id **`group_select`**, label
  *"Group select list"*, extends core `OptionsSelectWidget`, `field_types = { entity_reference }`.
  Settings `override_label` (string) + `required` (bool). Collapses to a checkbox when ≤1 option;
  hidden inside the Group creation wizard; per-option availability set from the group relation
  create/delete permission via Form Options Attributes.

## Operate it

1. `composer require drupal/entitygroupfield_lite` (pulls group + form_options_attributes),
   `drush en entitygroupfield_lite -y`.
2. Set up Group: group type(s) + the relation plugin(s) whose target entity type/bundle you want.
3. On the host entity's **Manage form display**, drag the `group_<group_type_id>` field out of
   *Disabled* and choose the **Group select list** widget. Details in
   [fields/field-and-widget.md](fields/field-and-widget.md).
