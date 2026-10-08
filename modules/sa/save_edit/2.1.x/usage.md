Save & Edit adds an extra "Save & Edit" (or "Apply") action button to node add/edit forms that saves the node and returns the editor straight back to its edit form instead of the canonical/redirect page, with optional auto-unpublish and default-button overrides.

---

The module is a `hook_form_alter()` on the node form (`\Drupal\node\NodeForm` / `\Drupal\node\Form\NodeForm`). For content types enabled in its configuration and users holding the *use save and edit* permission, it clones the standard Submit action into a new `save_edit` action, relabels it (default "Save & Edit"), and appends two submit handlers: `save_edit_form_submit_presave` (which can force the node unpublished) and `save_edit_form_submit_redirect` (which overrides the post-save redirect to the node's `edit-form`, preserving any `destination`). All behaviour is driven by the `save_edit.settings` config object: `button_value`, `button_weight`, `node_types` (a map of bundle → bundle-or-"0" listing which content types get the button), `unpublish` / `unpublish_new_only` (auto-unpublish on save), and a set of toggles to hide or relabel the core Save/Publish/Preview/Delete buttons (`hide_default_save`, `save_button_text`, `hide_default_publish`, `hide_default_preview`, `hide_default_delete`). When the Gin admin theme is active a `gin_primary` option promotes the button to a primary action. `hook_entity_bundle_create()` / `_delete()` keep `node_types` in sync as content types are added or removed (auto-enabling new ones only when `enable_node_types_automatically` is on). The settings form lives at `/admin/config/save_edit/settings` (route `save_edit.save_edit_settings_form`, permission *administer save and edit*). No entities, plugins, or Drush commands are added.

---

- Add a "Save & Edit" button so authors can save a draft and keep editing without navigating away.
- Rename the button to "Apply" or another familiar label via `button_value`.
- Enable the button only on specific content types (e.g. Article but not Basic page).
- Automatically unpublish nodes whenever they are saved with Save & Edit (`unpublish`).
- Unpublish only on first creation so subsequent saves keep the node's status (`unpublish_new_only`).
- Position the button horizontally among the form actions with `button_weight`.
- Promote the button to a Gin theme primary action instead of the "More actions" dropdown.
- Hide the default Save button so editors must use Save & Edit (`hide_default_save`).
- Relabel the default Save button text without hiding it (`save_button_text`).
- Hide the Publish, Preview, or Delete buttons to simplify the node form UI.
- Auto-enroll every newly created content type into Save & Edit (`enable_node_types_automatically`).
- Keep a long-form editing workflow where writers repeatedly save and continue.
- Preserve an incoming `destination` query parameter through the save-and-return-to-edit redirect.
- Give reviewers a way to save edits and immediately re-check the same edit form.
- Reduce round-trips for editors filling in many fields across several sittings.
- Restrict the feature to trusted roles using the *use save and edit* permission.
- Gate configuration access behind the *administer save and edit* permission.
- Provide an "apply changes" pattern similar to other CMS admin UIs.
- Enforce a draft-first workflow by combining Save & Edit with auto-unpublish.
- Manage the enabled content types and button text entirely through exported config.
- Keep the node on its edit form after save for iterative content modeling.
- Clean up the node form action bar down to just the buttons your editors need.
