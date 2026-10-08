<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Views Entity Form Field adds every editable entity field to the Views "Add field" list as a real form widget, turning a view into a bulk edit table where many entities are saved with one submit.

---

`hook_views_data_alter()` walks every entity type that has a `views_data` handler, collects the field definitions of all its bundles that are `isDisplayConfigurable('form')`, and registers one extra views field per field name on the entity's base (or data) table, id `form_field_<field_name>`, titled **"Form field: &lt;label&gt;"** with help listing the bundles it appears in. All of them are served by a single views field plugin, `@ViewsField("entity_form_field")` → `Drupal\views_entity_form_field\Plugin\views\field\EntityFormField`. The plugin extends `FieldPluginBase`, uses `UncacheableFieldHandlerTrait` and `EntityTranslationRenderTrait`, does nothing in `query()`, and returns an HTML comment placeholder from `getValue()`; the real work happens in `viewsForm()`, which instantiates the configured field widget through `plugin.manager.field.widget` with form mode `views_view` and builds one widget per result row, keyed by the row's entity id. Per-field options live under `options.plugin`: `type` (widget plugin id), `settings` (widget settings), `third_party_settings`, `hide_title`, `hide_description` and `fallback_view_mode`. Access is checked per row (`$entity->access('update')` and `$items->access('edit')`); inaccessible rows are hidden, or rendered read-only in the chosen fallback view mode, and the submit button disappears when nothing is editable. On submit, `viewsFormValidate()`/`viewsFormSubmit()` extract widget values back into the entities, validate them and flag violations on the widgets, and `saveEntities()` saves only entities that actually changed (compared field-by-field against `loadUnchanged()`), reporting "N items saved" / which ones failed. A CSS library (`views_entity_form_field/views_form`) supplies the classes that hide widget titles and descriptions, and a config schema (`views.field.entity_form_field`) covers the options for config export.

---

- Build an editorial dashboard where a whole content list's titles are editable inline.
- Bulk-toggle a "Featured" boolean on dozens of nodes from one screen.
- Let a merchandiser edit prices or stock levels of many commerce entities at once.
- Bulk-assign taxonomy terms to a filtered list of articles.
- Edit media alt text for every image in a view in one pass.
- Give a moderator a queue view with an inline "moderation state" select per row.
- Provide a weight/sort-order column that editors can retype and save together.
- Fix a batch of publication dates without opening each node form.
- Expose a checkbox column for an "approved" flag on a webform-submission-like entity.
- Bulk edit user profile fields from a filtered user view.
- Choose a specific widget per column (autocomplete vs select vs textfield) in the Views UI.
- Hide widget titles and descriptions so the view still reads like a table.
- Render a read-only fallback view mode for rows the current user may not edit.
- Combine editable and non-editable columns in the same view.
- Restrict who can bulk edit by exposing the view on a permission-protected page.
- Edit fields of a related entity through a views relationship (each row keyed by its own entity id).
- Edit translations by adding a language filter and letting the plugin resolve the row translation.
- Add an inline "internal notes" text field for a content operations team.
- Bulk correct imported data right after a migration without writing an update hook.
- Give a client an "edit everything on one page" screen instead of a multi-step flow.
- Only persist changed rows — untouched entities are never re-saved.
- Surface widget validation errors next to the offending row instead of failing the whole form.
- Export the whole editable view as configuration (`views.view.*` with `plugin_id: entity_form_field`).
- Reuse existing field widget settings (e.g. datetime widget config) inside the view.
- Prototype a lightweight alternative to a custom bulk-edit form.
- Avoid combining it with a Views Bulk Operations bulk form, which fights for the submit button.
