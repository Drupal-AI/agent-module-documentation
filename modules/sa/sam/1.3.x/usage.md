Simple Add More (SAM) improves the editing UX of multi-value fields that have a fixed cardinality: instead of rendering every allowed empty element up front, it shows only one empty element and an "Add another item" button that reveals the next one on demand.

---

By default Drupal core exposes the maximum number of allowed values for a limited-cardinality field, so a field permitting 5 values renders 5 empty rows, which clutters the editing form. SAM attaches client-side JavaScript (the `sam/simplify` library) that hides the extra empty elements and replaces them with a single "Add another item" button plus help text showing how many more items can be added; each click reveals one more empty element. It works purely on the form/theme layer via `hook_field_widget_complete_form_alter()` and `hook_preprocess_field_multiple_value_form()` — it flags empty deltas (beyond the first) with `data-sam-simplify`, marks the widget wrapper, and the JS fades those rows out and adds "Add another item" / per-row "Remove" buttons. SAM only acts on fields whose cardinality is greater than 1 (fixed limited cardinality — unlimited and single-value fields are untouched) and only on a curated allow-list of widget types (text, textarea, email, number, telephone, link, path, uri, entity_reference_autocomplete, linkit, etc.). Editors can opt a specific widget out through a per-widget "Skip simplification" third-party setting on the form display, and developers can extend the supported widget list via `hook_sam_allowed_widget_types_alter()`. The button, remove, and singular/plural help-text labels are configurable at **Admin → Configuration → Content authoring → Simple Add More Settings** (`sam.admin_settings`, config object `sam.settings`), gated by the `administer sam` permission. The module has no PHP dependencies, defines no services or plugins, and ships no submodules.

---

- Show only one empty element for a fixed multi-value field instead of all allowed rows.
- Give editors an "Add another item" button that reveals one more empty element per click.
- Reduce visual clutter on content forms with several limited-cardinality fields.
- Display live help text like "3 additional items can be added" that updates as rows are revealed.
- Add a per-row "Remove" button that clears a value and returns the element to the pool.
- Keep the first empty element visible on a brand-new (0-value) field so editors can start typing.
- Preserve all existing non-empty values while only hiding surplus empty rows.
- Rename the "Add another item" button label site-wide via settings.
- Rename the "Remove" button label site-wide via settings.
- Customize the singular remaining-items help text (uses the `@count` placeholder).
- Customize the plural remaining-items help text (uses the `@count` placeholder).
- Apply the simplification to string textfield and textarea widgets (including text with summary).
- Apply it to email, telephone, number, path, and uri widgets.
- Apply it to link and link-attributes widgets on multi-value link fields.
- Apply it to entity_reference_autocomplete and Linkit autocomplete widgets.
- Opt a single widget out via the "Skip simplification" checkbox on the form display's widget settings.
- Add support for a custom or contrib widget type with `hook_sam_allowed_widget_types_alter()`.
- Clear CKEditor 4/5 instances correctly when an editor removes a rich-text row.
- Improve UX of a paragraphs-adjacent workflow where a plain field has a small fixed max.
- Leave unlimited-cardinality fields alone (SAM only targets cardinality > 1).
- Leave single-value fields untouched (no add-more behavior needed).
- Deploy the label/help-text settings as configuration between environments via config export.
- Restrict who can change SAM's labels using the `administer sam` permission.
- Keep rows with validation errors visible so editors can fix them (error-aware preprocessing).
- Reorder revealed rows automatically so the widget's delta weights stay consistent.
- Provide a cleaner add-more experience without switching to a paragraphs/inline-entity workflow.
- Fire a `change` event when clearing a removed field so listeners (e.g. Maxlength) stay in sync.
