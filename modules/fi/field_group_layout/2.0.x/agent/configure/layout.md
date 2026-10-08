<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure — Layouts field-group formatter

No admin settings page; configured per display in the Field UI.

## Apply a layout to a field group
1. On *Manage form display* or *Manage display* for a bundle, add a field group (Field Group module) or edit one.
2. Set the group's **Format** to **Layouts** and open its settings.
3. Choose a layout in **Select a layout** (options from `plugin.manager.core.layout` —
   e.g. `layout_onecol`, `layout_twocol`, `layout_threecol_25_50_25`, plus any theme/module layout).
4. Save. The layout's regions appear as draggable targets; drag child fields into the desired region.
   Region sub-groups are made non-draggable/locked to keep the structure intact.

Changing the layout later triggers `_field_group_layout_field_layout_update_handler()` which remaps existing
fields into the new layout's regions and prunes regions that no longer exist.

## Where it is stored
In the entity display config under `third_party.field_group.<group_name>`:
- `format_type: layouts`
- `field_layout: <layout_plugin_id>` (also mirrored in `format_settings.field_layout`)
- `region_mapping` — maps each layout region to the fields placed in it
- `format_settings`: `open` (bool), `description` (text), `required_fields` (bool) — from
  `field_group.field_group_formatter_plugin.layouts` schema.

## Notes
- Skipped when the display has Layout Builder enabled (the module defers to Layout Builder).
- Also provides a `default` formatter (fieldset) with `open` / `description` / `required_fields` settings.
- `field_group_layout_layout_alter()` relabels the core `layout_builder_blank` layout (workaround for core
  issue #3392572).
