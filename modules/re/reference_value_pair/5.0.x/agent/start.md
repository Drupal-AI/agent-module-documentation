<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Reference Value Pair (reference_value_pair) — agent index

Defines ONE field type, `reference_value_pair`, that stores an **entity reference plus a
free-text scalar value** in a single field delta (e.g. taxonomy term + "50", product + quantity).
The field type extends core `EntityReferenceItem`, so it is a full entity-reference field with an
extra `value` column. Ships two widgets and one formatter, plus Views and Feeds integration.

- Dependency: core `field` only. Core: `^10 || ^11`.
- `configure` route: none (no settings page). Configuration is per-field, on the standard
  Field UI storage/field/form-display/display forms.
- No permissions, no services, no drush, no routes. Defines no new plugin *types* (it provides
  plugin *instances* for core field-plugin types + a Feeds target).

Solution docs:
- **Add/operate the field, its storage & field settings, columns** → [fields/field-type.md](fields/field-type.md)
- **Configure the input widgets (autocomplete / select)** → [fields/widgets.md](fields/widgets.md)
- **Configure display / template the output** → [fields/formatter.md](fields/formatter.md)
- **Filter/sort/relate on the pair in Views** → [views/integration.md](views/integration.md)

Key facts (real machine names):
- Field type: `reference_value_pair` (class `…\Plugin\Field\FieldType\ReferenceValuePair`,
  extends `EntityReferenceItem`; `list_class` = core `EntityReferenceFieldItemList`).
- Default widget: `reference_value_autocomplete_widget`; also `reference_value_select`.
- Default formatter: `reference_value_formatter`.
- Feeds target plugin id: `reference_value_pair` (maps properties `target_id` + `value`).
- Stored columns: `target_id` (int-unsigned or varchar_ascii) + `value` (varchar, length =
  `max_length`); index on `target_id`. Properties: `value`, `target_id`, `entity` (computed).
- Storage settings: `max_length` (255), `is_ascii` (FALSE), `case_sensitive` (FALSE),
  `target_type` (node, else user). Field settings: `handler` (default), `handler_settings`.
- Theme hook: `reference_value_pair_formatter`; template `reference-value-pair-formatter.html.twig`.
- Config schema: `field.storage_settings.reference_value_pair`, `field.field_settings.reference_value_pair`,
  `field.widget.settings.reference_value_select`, `field.widget.settings.reference_value_autocomplete_widget`,
  `field.formatter.settings.reference_value_formatter`.
