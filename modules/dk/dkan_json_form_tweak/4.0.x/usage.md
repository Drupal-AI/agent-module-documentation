DKAN JSON Form Tweaks improves the editing experience of DKAN's JSON-schema-generated metadata forms by adding property navigation, collapse buttons and per-value removal controls.

---

DKAN builds its dataset (and other data-entity) editing forms dynamically from a JSON schema via the `json_form_widget` module. For large schemas with many properties and multi-value arrays these forms become long and awkward to edit. This module decorates the `json_form_widget` builder services (`FormBuilder`, `FieldTypeRouter`, `SchemaUiHandler`, `ValueHandler`) and adds three opt-in UI aids, each toggled through third-party settings on the entity form-display configuration for the `data` bundle: a Bootstrap dropdown that jumps focus to any top-level property ("navigation"), a Close/Open button that collapses all `details` elements of a multi-value property ("close_details"), and a per-item "Remove" checkbox that deletes single values from a multi-value property on save ("remove_multivalue"). It also registers `fieldset__dkan_field_type_router` and `form_element__dkan_field_type_router` theme suggestions so themers can target JSON-form-generated elements. The tweaks are purely presentational/editorial; they require DKAN and json_form_widget and add no routes, permissions or Drush commands.

---

- Add a "Go to property" dropdown to a large DKAN dataset form so editors can jump straight to any property.
- Reduce scrolling on schemas with dozens of properties (e.g. rich DCAT/data.json dataset schemas).
- Collapse every open `details` element under a multi-value property with one Close button click.
- Re-open all collapsed value groups of a multi-value property with the toggle's Open state.
- Give editors a "Remove" checkbox next to each entry of a multi-value array property (keywords, distributions, contact points, etc.).
- Permanently delete a single distribution from a dataset without clearing the whole field.
- Delete individual simple array items (e.g. one keyword) instead of only being able to append.
- Offer a workaround for DKAN issue #4335 around per-value removal.
- Enable the navigation aid only on specific form-display modes (default, or a custom mode) via third-party settings.
- Turn each tweak on or off independently per entity form display through the Field UI "Manage form display" screen.
- Apply the tweaks to nested sub-schema forms (e.g. distribution, publisher) as well as the top-level dataset form.
- Add template suggestions to visually distinguish JSON-form-generated fieldsets and form elements in a custom theme.
- Improve moderator/data-steward productivity when curating open-data catalog metadata.
- Keep DKAN's schema-driven form generation intact while layering usability on top (decorator pattern, no core hacks).
- Provide keyboard-focus jumping to the first focusable input of a chosen property.
- Support Bootstrap-based DKAN admin themes where the navigation dropdown uses `bootstrap.Dropdown`.
- Configure the tweaks entirely through exported configuration (third-party settings on `core.entity_form_display.*`).
- Let large-catalog operators standardise the editing UI across multiple data-entity bundles that share the `data` bundle form.
- Avoid custom JavaScript by relying on the module's bundled navigation and close-details behaviors.
- Combine close and remove controls so editors can both tidy and prune long multi-value lists.
