# Field Group Label — agent index

A field type whose per-entity value overrides the displayed label of a field_group group. Requires the
`field_group` module. No settings page, permissions, config schema, or Drush.

- **Adding & configuring the field, the widget/formatter, and how the group-label override works** →
  [configure/field.md](configure/field.md)

Key facts:
- Field type `field_group_label_field_type` (`varchar`, default max_length 255, cardinality 1, value
  required); widget `field_group_label_widget` (settings `size`, `placeholder`); formatter
  `field_group_label_formatter`.
- The field never renders itself: formatter sets `#access = FALSE` and passes the value as
  `#field_group_label`.
- `field_group_label_field_group_pre_render()` (implements `hook_field_group_pre_render`) replaces the
  group's `#title` / `$group->label` with the value when non-empty, unsets the child, and uses only the
  first such field per group. Empty value → original label kept. Value is `Html::escape()` + `nl2br()`.
