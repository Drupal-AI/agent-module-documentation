Field Count Formatter is a tiny field formatter that, instead of rendering a multi-value field's contents, simply outputs the number of values that have been entered.

---

The module provides a single field formatter plugin, `count` ("Field count"), in `src/Plugin/Field/FieldFormatter/Count.php` (extends `FormatterBase`). Its `viewElements()` returns `$items->count()` as markup (nested so the default field-title rendering is preserved); `settingsSummary()` reports "Displays the number of items/count." The formatter's annotation declares an empty `field_types` list, so it is offered for any field type on *Manage display*. It has no settings, no configuration page, no permissions, no dependencies beyond Drupal core — pick "Field count" as the format for any multi-value field to show a count (e.g. "3") rather than the values themselves.

---

- Show how many values a multi-value field holds instead of the values.
- Display the number of tags/terms on a taxonomy reference field.
- Show a count of uploaded files or images on a media/file field.
- Render "N items" style counts on a view display or teaser.
- Count entity-reference targets on a relationship field.
- Provide a compact numeric summary of a field on a listing.
- Display the number of paragraphs referenced by a field.
- Show a count of multi-value text field entries.
- Use as a lightweight badge-style indicator of collection size.
- Avoid rendering large multi-value fields fully when only the total matters.
- Apply to any field type (the formatter is offered universally).
- Keep the field label while replacing its output with a count.
- Show the number of comments, links or addresses stored in a multi-value field.
- Give admins an at-a-glance count of related items on an entity.
- Reduce render cost on listings where only the item total is relevant.
- Display "0" cleanly for empty multi-value fields.
- Add a count column to a Views table by setting the field's formatter to Field count.
- Summarise a gallery field as a photo count.
