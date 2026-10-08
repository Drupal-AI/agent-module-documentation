Field Group Label provides a field type whose per-entity value replaces the displayed label of a Field Group (from the field_group module), letting each node or entity customise a group's heading instead of using one fixed group label.

---

The module defines a `field_group_label_field_type` field type (a `varchar` text field, default max length 255, cardinality 1, required value) with a matching textfield widget (`field_group_label_widget`, configurable size + placeholder) and formatter (`field_group_label_formatter`). The field is not rendered on its own: its formatter sets `#access = FALSE` and instead exposes the entered text as `#field_group_label` on the rendered element. `field_group_label_field_group_pre_render()` (an implementation of field_group's `hook_field_group_pre_render`) scans a group's children for a `field_group_label_field_type` child; if it finds one with a non-empty value it overrides the group's `#title` and `$group->label` with that value and unsets the child so the raw field is not shown. If the value is empty the original group label is preserved. The formatter escapes the value with `Html::escape()` + `nl2br()` before it becomes the label. Only the first such field in a group is used; others are ignored. Requires the field_group module (`^3.4 || ^4.0`); no settings page, permissions, config schema, or Drush.

---

- Give each node its own heading for a "Details" field group instead of one static label.
- Let editors rename a field-group section per entity (e.g. per-product spec-group titles).
- Show a dynamic, content-driven group label on a node's display.
- Localise or vary a group heading by individual entity rather than by display config.
- Add the field to a group and let its value drive that group's rendered title.
- Hide the underlying label field from output while still using its value as the heading.
- Fall back to the configured field_group label automatically when the entity leaves the field empty.
- Provide a placeholder hint (e.g. sample heading) in the label-entry widget.
- Control the width of the label-entry textfield via the widget size setting.
- Constrain the label length with the field's max-length storage setting.
- Use per-entity group labels on paragraphs to caption repeatable groups.
- Give tabs/accordions (field_group formatters) entity-specific titles.
- Build editor-friendly layouts where section names are part of the content.
- Support multiple field groups on one form, each with its own label field.
- Migrate static group headings to editable, per-entity headings.
- Rename a "Frequently asked questions" group to a question-specific heading per node.
- Let campaign pages set their own section headings without new displays.
- Replace a generic "Additional information" group label with something meaningful per record.
- Keep group markup/structure identical while only the heading text varies per entity.
