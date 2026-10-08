# toggle_editable_fields — agent start

Ships one field formatter, `toggle_editable_formatter`, for **boolean** fields. It renders the
value as a Bootstrap Toggle switch (built from a per-item `AjaxToggleForm`) that the user flips
in the display to re-save the entity over AJAX — inline editing, no edit form. No config UI,
no routes, no permissions of its own; everything is done in the field's **display settings**
(Manage display / Views field). Requires the external `bootstrap-toggle` library under
`/libraries` and the contrib `libraries` module. Config schema:
`field.formatter.settings.toggle_editable_formatter`.

- Enable the formatter + its Bootstrap Toggle settings (labels, size, styles, dimensions) → [configure/formatter.md](configure/formatter.md)
- How the inline save works and the access checks that gate it → [extend/save-path.md](extend/save-path.md)
