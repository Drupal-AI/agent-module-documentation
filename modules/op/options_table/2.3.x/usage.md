<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Options Table provides a `options_table` field widget ("Draggable Table") for options field types, offering the same on/off selection as core's Check boxes/radio buttons widget but with an extra drag-and-drop **Weight** column so editors can store the selected options in a chosen order.

---

The module ships a single field widget plugin, `OptionsTableWidget` (id `options_table`, label "Draggable Table"), that extends core's `OptionsWidgetBase` and declares `field_types` `entity_reference`, `list_integer`, `list_float`, and `list_string` with `multiple_values: TRUE`. Instead of a flat list of checkboxes/radios it renders a `#type => table` with a tabledrag handle per row, a checkbox (multi-value) or radio (single-value) toggle, and a hidden `weight` element; selected rows sort to the top in their stored delta order and the editor drags rows to reorder them. On validate, `validateElement()` reads the weights, `ksort()`s the enabled options, drops the `_none` option, and transposes the result into ordered field deltas — so for multi-value fields the delta order of stored values reflects the table order. The only widget setting is `toggle_label`, an optional column heading for the checkbox/radio column; everything else is inherited from core. Configuration is a normal widget selection on an entity's **Manage form display**, stored in the `entity_form_display` config entity as `content.<field>.type: options_table` with `settings.toggle_label`. The module has no config entity of its own, no permissions, no Drush commands, no admin page (`configure: null`), and only requires core's Options module.

---

- Let editors reorder the values of a multi-value list field (e.g. drag "Featured, News, Events" into a preferred display order) instead of an unordered set of checkboxes.
- Store a ranked list of entity-reference selections where delta order matters (e.g. an ordered set of related articles).
- Replace the core "Check boxes/radio buttons" widget on a `list_string` field so the selected order is persisted.
- Provide a sortable multi-select for a `list_integer` field such as priority levels.
- Order tags/terms on a taxonomy term reference field the editor picks from a fixed set.
- Give a single-value `list_string` field a radio-style draggable table (single selection, no reordering needed but consistent UI).
- Add a descriptive column header to the toggle column via the `toggle_label` widget setting (e.g. "Show?").
- Present a fixed vocabulary of options as a tidy table with weight handles rather than a long checkbox column.
- Keep an editor's chosen ordering of "sections to display" so a view or template can render them in that sequence.
- Configure the widget per form mode, e.g. draggable table on the default form but plain checkboxes on a compact form.
- Standardise ordered multi-select UX across content types by choosing the same widget on each field.
- Migrate a field from core checkboxes to an ordered widget without changing field storage or type.
- Let content authors curate the order of allowed values for an entity-reference field limited to a small set.
- Provide accessible, drag-to-order selection for options fields where sequence conveys meaning (steps, tiers, rankings).
- Deploy the widget choice through exported config (`content.<field>.type: options_table`) so all environments match.
- Turn a `list_float` rating/scale field into a reorderable table selection.
- Use the widget on a media or user entity's options field via that entity's form display.
- Preselect the single allowed option automatically when a required single-value field has exactly one choice.
- Avoid writing a custom widget just to add weight/ordering to an options field.
- Combine ordered selection with core's allowed-values list so editors pick and rank from the same vocabulary.
- Reorder entity-reference selections that feed an ordered rendering (e.g. a "related links" block).
- Give a required options field a clear required marker in the table caption/header.
- Offer editors a compact, single-column table for boolean-like "enable these features" selections with ordering.
