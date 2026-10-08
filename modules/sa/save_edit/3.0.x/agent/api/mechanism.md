<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Save & Edit — how the button works

Hook logic lives in `\Drupal\save_edit\Hook\SaveEditHooks` (`src/Hook/SaveEditHooks.php`), an
autowired service (`save_edit.services.yml`) whose constructor injects `ConfigFactoryInterface`
and `AccountProxyInterface`. `save_edit.module` holds `#[LegacyHook]` wrappers that call
`\Drupal::service(SaveEditHooks::class)`, plus the two procedural submit handlers below (core
invokes those by function name, so they remain procedural). There is no plugin or service to
override the behaviour beyond decorating/altering the `SaveEditHooks` service.

## `SaveEditHooks::formAlter(&$form, $form_state)` — `#[Hook('form_alter')]`

Runs on every form. It acts only when **both**:

1. the current user has permission `use save and edit` (`$this->currentUser->hasPermission(...)`), and
2. the form object is a `\Drupal\node\Form\NodeForm`, and the node's content type is enabled in
   `save_edit.settings.node_types` (the check is
   `in_array($content_type, array_values($enabled_node_types), TRUE)`).

Then it:

- Clones `$form['actions']['submit']` into `$form['actions']['save_edit']` (inheriting its
  `#submit` handlers); if `submit`'s `#attributes` is an object it is `clone`d onto the new action.
- Sets `#value` = `button_value`, `#name` = `'save_edit'`, `#weight` = `button_weight`, and removes
  `#button_type` (so it is not styled as primary unless `gin_primary` adds `#gin_action_item`).
- Injects `save_edit_form_submit_presave` right after core's `::submitForm` in the `#submit` array
  (via `array_splice`), and appends `save_edit_form_submit_redirect` as the final submit handler.
- Applies the button-hiding / relabeling toggles: `save_button_text` relabels the default Save
  action when it is not hidden; `hide_default_save` sets `submit['#access'] = FALSE`;
  `hide_default_preview` / `hide_default_delete` set `#access = FALSE` on those actions.

Note: this branch references only `\Drupal\node\Form\NodeForm` (no pre-11.2 `\Drupal\node\NodeForm`
fallback), consistent with the `^11.2 || ^12` core requirement.

## Submit handlers (procedural, in `save_edit.module`)

- **`save_edit_form_submit_presave(&$form, $form_state)`** — before the entity is saved, if
  `unpublish` is on, or `unpublish_new_only` is on and the entity `isNew()`, calls
  `$entity->setUnpublished()`.
- **`save_edit_form_submit_redirect(&$form, $form_state)`** — after save, sets the redirect to
  `$entity->toUrl('edit-form')` (the current entity's own internal edit-form route), carrying over
  any `destination` query param as a route parameter and then removing it from the request, so the
  editor lands back on the edit form rather than the node view / default redirect. If another
  submit handler has already set a response on the form state and core would otherwise redirect
  (`FormState::getRedirect()` returns a `Url`), it converts that redirect into an HTTP 303
  `RedirectResponse` so the Save & Edit redirect still takes effect; when core would not redirect
  at all (AJAX/HTMX-disabled, programmed, or rebuilding form), the existing response is left alone.

## Config sync hooks

`SaveEditHooks::entityBundleCreate()` / `entityBundleDelete()`
(`#[Hook('entity_bundle_create')]` / `#[Hook('entity_bundle_delete')]`) add/remove the bundle key
in `save_edit.settings.node_types` when node content types are created or deleted, honoring
`enable_node_types_automatically` for the default on/off value of a new type (`<bundle>` vs `'0'`).

## Install hook

`save_edit_install()` (in `save_edit.install`) sets `gin_primary` to `1` if the Gin admin theme is
the active (or default) admin theme at install time. Update hooks (`save_edit_update_810x`) clean
up removed config keys (`dropbutton`, `hide_default_publish`) and seed
`enable_node_types_automatically` / `gin_primary`.

To change behaviour, edit `save_edit.settings` (see [../configure/settings.md](../configure/settings.md)).
