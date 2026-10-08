Entity Form Field Label lets you override a field's displayed label per form mode and per display mode, so the same field can read "Documents" on one form and "Attachments" on another — without changing the field's global label.

---

The module adds a "Rewrite label" checkbox and a "New label" textfield to the third-party settings of every field **widget** (on *Manage form display*) and every field **formatter** (on *Manage display*), via `hook_field_widget_third_party_settings_form()` and `hook_field_formatter_third_party_settings_form()`. When "Rewrite label" is ticked, the entered label replaces the field's title: on forms it is applied in `hook_field_widget_complete_form_alter()` (with special handling for entity-reference, color, and composite/multi-value fields), and on display it is applied in `hook_preprocess_field()`. Leaving the new label empty hides the label entirely (`#title_display => invisible`). Composite fields (e.g. Date Range, name) accept multiple labels separated by `||`, one per sub-element (e.g. `Event Start Date||Event End Date`). A settings summary line ("Label alterations: …") is added to the widget/formatter summary. There is no config form, route, or permission — settings are stored as field third-party settings (schema `field.widget.third_party.entity_form_field_label` / `field.formatter.third_party.entity_form_field_label`, keys `rewrite_label` and `new_label`), so they travel with the entity form/view display config. Depends only on core `field`; works with Display Modes and Layout Builder.

---

- Give a field different labels on different form modes (e.g. "Attach file" vs "Documents").
- Give a field different labels on different display/view modes.
- Hide a field's label on a specific form mode by ticking rewrite and leaving the label empty.
- Hide a field's label on a specific display mode.
- Relabel a Date Range field's two inputs separately with `Start||End`.
- Relabel composite fields (name, address-like) sub-elements individually via `||`.
- Rename an entity-reference field's title on the edit form.
- Show a friendlier label to editors without renaming the field globally.
- Localize/shorten labels per display context.
- Override a base/shared field's label only where a custom form mode needs it.
- Adjust labels inside Layout Builder-managed displays (>= supported versions).
- Adjust labels for inline entity form widgets.
- Keep the underlying field machine name and global label untouched.
- Apply a marketing-friendly label on a public-facing view mode.
- Apply a technical label on an admin form mode.
- Provide distinct labels for the same field reused across multiple bundles' modes.
- See at a glance which fields are relabeled via the settings-summary line.
- Store label overrides in exportable config that deploys with the display.
- Avoid a custom preprocess/form-alter module just to rename a field label.
- Combine with core Form Modes to build role- or workflow-specific edit forms with tailored labels.
