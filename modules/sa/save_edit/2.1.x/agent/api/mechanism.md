# Save & Edit — how the button works

All logic is in `save_edit.module` (no classes beyond the settings form). No hooks are invited;
this doc explains the mechanism so you can predict/override behaviour.

## `save_edit_form_alter(&$form, $form_state)`

Runs on every form. It acts only when **both**:

1. the current user has permission `use save and edit`, and
2. the form object is a `\Drupal\node\NodeForm` (Drupal <11.2) or `\Drupal\node\Form\NodeForm`
   (>=11.2), and the node's content type is enabled in `save_edit.settings.node_types`.

Then it:

- Clones `$form['actions']['submit']` into `$form['actions']['save_edit']` (inheriting its
  `#submit` handlers and, if present, a cloned `#attributes` object).
- Sets `#value` = `button_value`, `#name` = `save_edit`, `#weight` = `button_weight`, and removes
  `#button_type` (so it is not styled as primary unless `gin_primary` adds `#gin_action_item`).
- Injects `save_edit_form_submit_presave` right after core's `::submitForm`, and appends
  `save_edit_form_submit_redirect` as the final submit handler.
- Applies the button-hiding / relabeling toggles (`hide_default_save` also hides `unpublish`;
  `save_button_text` relabels the default Save when it is not hidden).

## Submit handlers

- **`save_edit_form_submit_presave(&$form, $form_state)`** — before the entity is saved, if
  `unpublish` is on, or `unpublish_new_only` is on and the entity `isNew()`, calls
  `$entity->setUnpublished()`.
- **`save_edit_form_submit_redirect(&$form, $form_state)`** — after save, sets the redirect to
  `$entity->toUrl('edit-form')`, carrying over any `destination` query param, so the editor lands
  back on the edit form rather than the node view / default redirect.

## Config sync hooks

`save_edit_entity_bundle_create()` / `save_edit_entity_bundle_delete()` add/remove the bundle key
in `save_edit.settings.node_types` when node content types are created or deleted, honoring
`enable_node_types_automatically` for the default on/off value of a new type.

To change behaviour, edit `save_edit.settings` (see [configure/settings.md](../configure/settings.md));
there is no plugin or service to override.
