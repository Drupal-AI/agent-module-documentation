TableField required lets you mark specific rows and/or columns of a TableField as mandatory, so editors must fill in every cell in those rows/columns before the form saves.

---

TableField required is a submodule of TableField that adds per-row and per-column required validation to a table field, configured through the field's own settings form rather than a separate admin page. It alters the **field config edit form** (`hook_form_field_config_edit_form_alter`) for any field of type `tablefield`, adding a "Tablefield required settings" details section with three inputs: **Required rows** and **Required columns** (comma-separated, zero-based indexes — `0` is the first row/column, so `0,2` targets the first and third), and a **multivalue_inherit** checkbox. These are saved as field **third-party settings** under the `tablefield_required` namespace (schema in `config/schema/tablefield_required.schema.yml`), not as a standalone config object. At form-build time it stores the settings on the widget element (`hook_field_widget_tablefield_form_alter`) and registers an extra `#process` callback on the `tablefield` render element (`hook_element_info_alter`). That process callback walks the widget's table and sets `#required = TRUE` on every cell input that falls in a configured required row or column. The feature is deliberately **secondary to the core "Required field" checkbox**: the settings section is only shown while the standard `required` box is unchecked, and the processing is skipped when the element is already `#required`, and it never runs on the field-config path itself. For multi-value fields, only the first table (delta 0) is validated unless **Inherit mandatory property for multi-value tables** is checked, which extends the same required rows/columns to every table instance. There is no permission, no menu, and no Drush command — it is purely field-level validation configuration.

---

- Make an entire row of a table mandatory (e.g. the header row) by listing its index under Required rows.
- Make an entire column mandatory (e.g. a "Name" column) by listing its index under Required columns.
- Require several rows at once with a comma-separated list like `0,2,4`.
- Require several columns at once, e.g. `0,1` to force the first two columns.
- Require both specific rows and specific columns on the same table field.
- Force editors to complete the first row and first column of a data grid before saving.
- Use zero-based indexes (`0` = first) so you can target rows/columns precisely.
- Keep a field optional overall while still forcing key cells to be filled in.
- Configure the rules directly on the field's settings page — no separate admin screen to visit.
- Store the rules as portable third-party settings that export with the field configuration.
- Apply the same required rows/columns to every table in a multi-value field via the inherit option.
- Limit validation to only the first table of a multi-value field by leaving inherit unchecked.
- Ensure a required "totals" or "signature" row is never left blank on a submitted table.
- Guarantee a units/label column is always populated across a spec table.
- Add mandatory cells to a table field without writing any custom validation code.
- Defer to Drupal's standard whole-field Required checkbox when you need every cell required.
- Prevent partially filled critical rows from being saved on content forms.
- Mark the first column of a comparison matrix required so every option has a label.
- Enforce data completeness on structured tables collected from editors.
- Deploy required-cell rules between environments as part of the field's exported config.
