# Save & Edit — how the button works

All logic is in `save_edit.module` (no classes beyond the settings form). No hooks are invited;
this doc explains the mechanism so you can predict/override behaviour.

## `save_edit_form_alter(&$form, $form_state)`

Runs on every form. It acts only when **both**:

1. the current user has permission `use save and edit`, and
2. the form object is a `\Drupal\node\Form\NodeForm` (Drupal >=11.2) or, where that older class
   still exists, a `\Drupal\node\NodeForm` (Drupal <11.2) — the `class_exists()` guard keeps the
   removed pre-11.2 class from being referenced on Drupal 12 — and the node's content type is
   enabled in `save_edit.settings.node_types`.

Then it:

- Clones `$form['actions']['submit']` into `$form['actions']['save_edit']` (inheriting its
  `#submit` handlers and, if present, a cloned `#attributes` object).
- Sets `#value` = `button_value`, `#name` = `save_edit`, `#weight` = `button_weight`, and removes
  `#button_type` (so it is not styled as primary unless `gin_primary` adds `#gin_action_item`).
- Injects `save_edit_form_submit_presave` right after core's `::submitForm`, and appends
  `save_edit_form_submit_redirect` as the final submit handler.
- Applies the button-hiding / relabeling toggles (`hide_default_save` hides the core Save action;
  `save_button_text` relabels the default Save when it is not hidden; `hide_default_preview` /
  `hide_default_delete` hide those actions).

## Submit handlers

- **`save_edit_form_submit_presave(&$form, $form_state)`** — before the entity is saved, if
  `unpublish` is on, or `unpublish_new_only` is on and the entity `isNew()`, calls
  `$entity->setUnpublished()`.
- **`save_edit_form_submit_redirect(&$form, $form_state)`** — after save, sets the redirect to
  `$entity->toUrl('edit-form')` (the current entity's own internal edit-form route), carrying over
  any `destination` query param as a route parameter and then removing it from the request, so the
  editor lands back on the edit form rather than the node view / default redirect. If another
  submit handler has already set a response on the form state, and core would otherwise redirect
  (`FormState::getRedirect()` returns a `Url`), it converts that redirect into an HTTP 303
  `RedirectResponse` so the Save & Edit redirect still takes effect; when core would not redirect
  at all (AJAX/HTMX-disabled, programmed, or rebuilding form), the existing response is left alone.

## Config sync hooks

`save_edit_entity_bundle_create()` / `save_edit_entity_bundle_delete()` add/remove the bundle key
in `save_edit.settings.node_types` when node content types are created or deleted, honoring
`enable_node_types_automatically` for the default on/off value of a new type.

## Install hook

`save_edit_install()` sets `gin_primary` to `1` if the Gin admin theme is the active (or default)
admin theme at install time. Update hooks (`save_edit_update_810x`) clean up removed config keys
(`dropbutton`, `hide_default_publish`) and add `enable_node_types_automatically` / `gin_primary`.

To change behaviour, edit `save_edit.settings` (see [configure/settings.md](../configure/settings.md));
there is no plugin or service to override.
