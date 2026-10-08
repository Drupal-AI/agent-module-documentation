<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Display Suite Chains (ds_chains) — agent index

Lets a **Display Suite** layout place a single field **from a referenced entity** directly among the
host entity's own fields, rendered with any applicable field formatter — instead of rendering the
whole referenced entity in a view mode. Requires **Display Suite** (`ds:ds >= 8.x-3.x`). Packaged
version **8.x-1.3**; branch `8.x-1.x`. Core `^8 || ^9 || ^10 || ^11`. No permissions, no routes, no
config UI of its own — configuration lives on the entity's **Manage Display** tab.

## Solution docs

- **The `ds_chains` DS field plugin and its deriver** (how `ChainedField::build()`
  resolves and renders a referenced entity's field; how `ChainsDeriver` derives one
  plugin per `entity_type/bundle/field_name/chained_field_name`) →
  [plugins/chained-field.md](plugins/chained-field.md)
- **Configuration: the Manage Display UI and stored settings** (the `ChainsUi`
  form alter, the `ds_chains.fields` third-party setting, config schema, install)
  → [config/manage-display.md](config/manage-display.md)

## What it does

An entity with an entity reference field can display any field of the *referenced* entity type in
its own layout. Instead of one more view mode (author teaser) or a preprocess function, the
referenced field becomes a placeable item on Manage Display next to the native fields.

## Mechanism (read the source, not the stub)

- **`ds_chains.module`** — `hook_form_entity_view_display_edit_form_alter()` delegates to
  `ChainsUi::alterFieldUiManageDisplay()`.
- **`src/ChainsUi.php`** — only acts when the display already has a DS layout
  (`getThirdPartySetting('ds', 'layout')`). Adds a "Chained fields" details section (checkboxes) of
  the entity's entity_reference fields whose **target is a content entity with a view builder**. The
  chosen fields are saved into the display's `ds_chains.fields` third-party setting by an entity
  builder, which then clears the DS plugin manager's cached definitions.
- **`src/Derivative/ChainsDeriver.php`** — derives one DS field per
  `entity_type/bundle/field_name/chained_field_name` for every display-configurable field on each
  reachable target bundle. `getEnabledViewModes()` restricts each derivative to the view modes where
  the parent reference field was actually enabled in `ds_chains.fields`.
- **`src/Plugin/DsField/ChainedField.php`** — the DS field plugin (`@DsField id = "ds_chains"`).
  - `build()` iterates each delta of the host reference field, resolves the referenced entity, and
    renders the chained field via the **target entity type's own view builder** (`viewField()`) with
    the selected formatter and `label => hidden`. It checks the chained field's `access('view')`,
    adds each referenced entity as a cache dependency, and returns cache metadata when nothing renders.
  - `formatters()` offers only formatters applicable to the chained field's type.
  - `settingsForm()` embeds the underlying formatter's settings form; unlimited-cardinality
    reference fields also get a **UI Limit** (`chain_settings.ui_limit`) to cap rendered items.
  - `isAllowed()`/`validViewMode()` gate the field to its bundle and enabled view modes.
- **`config/schema/ds_chains.schema.yml`** — schema for the `ds_chains.fields` display setting and
  the `ds.field_plugin.ds_chains:*` `chain_settings.ui_limit`.

## Configure it

1. Enable `ds` and give the display a Display Suite layout (Manage Display → Layout for Display Suite).
2. On Manage Display, open **Chained fields** and tick the entity reference field(s) to expose.
3. The referenced entity's fields now appear as placeable DS fields; drag, pick a formatter, and set
   its formatter settings (plus UI Limit for multi-value references).

## Notes

- Only entity_reference fields whose target is a **content entity with a view builder** are eligible.
- Each rendered chained field is an extra entity load; the UI Limit exists to bound multi-value lists.
- Similar module: Field formatter (single referenced field per reference field); ds_chains configures
  each referenced field independently.
