<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration: the Manage Display UI and stored settings

ds_chains has **no settings page, route, or permission of its own**. All
configuration lives on an entity's *Manage display* screen and is stored as
third-party settings on the `entity_view_display` config entity.

## Install & enable

```bash
composer require drupal/ds_chains
drush en ds_chains -y
```

Requires **Display Suite** (`ds:ds >= 8.x-3.x`, from `ds_chains.info.yml`). No
Composer library requirements, no submodules.

## The form alter — `src/ChainsUi.php`

`ds_chains.module` implements
`hook_form_entity_view_display_edit_form_alter()`, which resolves `ChainsUi`
through the class resolver and calls `alterFieldUiManageDisplay($form, $form_state)`.

`alterFieldUiManageDisplay()`:

1. Reads `#entity_type` / `#bundle` from the form and the view mode from the
   display entity being edited.
2. **Returns early unless the display already uses a Display Suite layout**
   (`$entity_display->getThirdPartySetting('ds', 'layout', FALSE)`). ds_chains
   only augments DS-laid-out displays.
3. Builds a checkbox option per entity_reference field on the bundle whose
   target is a **content entity with a view builder** (same eligibility test as
   the deriver: `getFieldMapByFieldType('entity_reference')`, skip
   computed/calculated fields, require `ContentEntityInterface` +
   `hasViewBuilderClass()`).
4. Adds a `ds_chains` **details** element (group `additional_settings`,
   `#tree = TRUE`, weight `-100`) titled *"Chained fields for {bundle} in
   {view_mode}"* containing a `fields` **checkboxes** element, defaulted from the
   display's existing `ds_chains.fields` third-party setting.
5. Registers `[ChainsUi::class, 'buildEntity']` as an `#entity_builders` callback.

`ChainsUi::buildEntity()` (static) writes the ticked field list into the
display's `ds_chains.fields` third-party setting
(`array_filter($form_state->getValue(['ds_chains', 'fields']))`) and calls
`plugin.manager.ds->clearCachedDefinitions()` so the deriver re-runs and new
chained DS fields appear.

## Stored configuration & schema — `config/schema/ds_chains.schema.yml`

Two schema entries; there are no config objects or `config/install` defaults —
everything is third-party settings on existing display config:

- `core.entity_view_display.*.*.*.third_party.ds_chains` — mapping with `fields`,
  a **sequence of strings** (the enabled host reference-field machine names).
  This is what `ChainsUi::buildEntity()` writes and what
  `ChainsDeriver::getEnabledViewModes()` reads.
- `ds.field_plugin.ds_chains:*` — extends
  `field.formatter.settings.[%parent.formatter]` (so the chosen formatter's own
  settings validate) and adds `chain_settings.ui_limit` (**integer**), the
  multi-value display cap used by `ChainedField::build()`.

## Operating workflow

1. Give the display a Display Suite layout (Manage display → *Layout for Display
   Suite*).
2. On Manage display, open **Chained fields** and tick the entity reference
   field(s) to expose; save.
3. The referenced entity's display-configurable fields now appear as placeable DS
   fields (`"{ref label}: {chained label}"`). Place one, choose a formatter and
   its settings; for an unlimited-cardinality reference set the **UI Limit**.
