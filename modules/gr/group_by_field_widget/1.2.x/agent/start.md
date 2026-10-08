<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Grouped by field widget (group_by_field_widget) — agent index

Provides ONE `entity_reference` **field widget** that renders the field's
options as nested, collapsible `details` groups instead of a flat list. Grouping
is driven by fields on the *referenced* entities, followed along
entity-reference paths (e.g. group Displays by Facility, then by Campus).
Core-only; no dependencies.

- Core requirement: `~9.0 || ^10.0 || ^11 || ^12`. License GPL-2.0-or-later.
- **No** routes, permissions, services, drush commands, or settings page.
  Configuration is the widget's own settings on *Manage form display*.
- Provides config schema (widget settings). Provides no plugin *types*.

## What you'd do

- **Understand / configure the widget, its settings, grouping and submission** →
  [fields/group-by-field-reference-widget.md](fields/group-by-field-reference-widget.md)

## Key facts

- Widget plugin id: `group_by_field_reference_widget`
  (label "Group by field reference widget"), class
  `Drupal\group_by_field_widget\Plugin\Field\FieldWidget\GroupByFieldReferenceWidget`,
  extends `OptionsWidgetBase`. Applies to `entity_reference` fields.
- Widget settings: `group_by` (array, up to 3 dot-delimited field paths),
  `open_details` (bool), `bundle_options` (array; only for Views-handler fields).
- Multi-value field → checkboxes; single-value field → radios (optional radios
  get JS library `group_by_field_widget/radio_toggle` to clear a selection).
- Config schema key: `field.widget.settings.group_by_field_reference_widget`
  (in `config/schema/`; a duplicate schema file at the module root is unused).
- Options come from the field's own selection handler
  (`OptionsWidgetBase::getOptions()`), not a custom query.
