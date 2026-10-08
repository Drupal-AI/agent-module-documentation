<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Edit+ architecture — inline editing flow

## Install / enable

`drush en edit_plus`. Requires `navigation_plus`, `tempstore_plus`, `field_sample_value`,
`twig_events` (declared in `edit_plus.info.yml`; `edit_plus_update_10001` also installs
`tempstore_plus` on upgrade). No settings form — grant the **`access inline editing`** permission
to a role and use the "Change" tool inside Navigation+ Edit Mode. Deprecated (see start.md).

## The tool

`src/Plugin/Tool/EditPlus.php` — `#[Tool(id: 'edit_plus', label: 'Change', hot_key: 'c', weight: 40)]`
extending `navigation_plus\ToolPluginBase`. `addAttachments()` attaches the `edit_plus/library`
library plus CKEditor attachments for every non-webform filter format. `getIconsPath()` supplies the
pencil / mouse-cursor icons. Edit+ owns **no** Navigation+ `#[Sidebar]` panel; each opened form is
appended as its own right-sidebar panel (see the controller note below).

## Libraries (`edit_plus.libraries.yml`)

`library`: JS `js/edit-plus.js` + `js/edit-plus-tool-plugin.js` (ES modules) +
`js/edit_plus/sidebars/edit-plus-sidebar.js`; CSS `edit-plus.css`, `ckeditor.css`, `sidebar.css`.
Depends on `core/jquery`, several `core/ckeditor5*` bundles, `ckeditor5/internal.drupal.ckeditor5*`,
and `navigation_plus/{modes,sidebar,edit_mode,update_element}`. The JS ES-module tree under
`js/edit_plus/` implements the client editing behaviour (hotkeys, editable-element wiring, entity
form round-trips, indicators, and the field-plugin system — see api/extending.md).

## Routes (`edit_plus.routing.yml`)

All four are gated by `_permission: 'access inline editing'`:

- `edit_plus.entity_form` — `/edit-plus/entity-form/{entity_type}/{entity}` →
  `MultipleEntityFormController::entityForm`. `{entity}` is upcast via `entity:{entity_type}`.
- `edit_plus.tempstore.save` — `/edit-plus/tempstore/save/{entities}` → `Tempstore::save`.
- `edit_plus.tempstore.delete` — `/edit-plus/tempstore/delete/{entities}` → `Tempstore::delete`.
- `edit_plus.delete_confirmation_form` — `/edit-plus/tempstore/delete-confirm/{entities}` →
  `Form\ConfirmDiscardChangesForm`.

When `lb_plus` is installed, `EditPlusServiceProvider::alter()` also registers
`LbPlusRouteSubscriber` (`src/Routing/`) to add the Change-tool route for Layout Builder blocks and
the `edit_plus.form_alter.lb_block` service (`LayoutBuilderBlockFormAlter`).

## Building the form — `MultipleEntityFormController::entityForm()`

Loads the entity, replaces it with its tempstore version (`tempstoreRepository->get($entity)`),
gets the `default` form object, and builds it with `FormBuilder` (reusing an excerpt of core's
`FormController` argument-resolution trick). `EditPlusFormTrait::wrapForm()` wraps the built form in
a container with id `edit-plus-form_{type}-{id}` and Navigation+ sidebar classes. On the initial
call it returns the render array; when JS sets `ajaxReturnForm`, it returns an `AjaxResponse` with an
`AppendCommand` into `#navigation-plus-right-sidebar` (a cross-module DOM contract).

## Buffering edits — `Form\InlineEntityFormAlter`

Wired from `edit_plus_form_alter()` when Navigation+ mode is `edit` and the form_state flag
`edit_plus_form` is set. `formAlter()` removes the entity form's `::save` submit handler and adds its
own `update()`, changes the button to *"Update"*, hides the actions, and AJAX-ifies the submit
(`ajaxSubmit()` → `updateAjaxSubmit()`). `update()` does **not** save the entity — it writes it to
the tempstore (`tempstoreRepository->set($entity)`) and invalidates the `edit_plus:{type}.{id}`
cache tag (`getCacheTag()` in `edit_plus.module`). `entityContent()` re-renders the tempstore entity
in the current view mode for the live page update. `EditPlusFormTrait` handles field attribution
(`FieldAttributes` events), the "Add field" buttons for empty fields
(`addFieldToPageButton()`/`populateEmptyField()`, using `field_sample_value`), view-mode
resolution/validation, error handling, and AJAX page/form refresh commands.

For the standard entity edit page (`/node/{id}/edit`), `Form\EntityEditFormAlter` adds *Update* and
*Discard changes* buttons that write/clear the same tempstore, but only on the edit route of an
entity currently swapped from tempstore (`isTempstoredEntityEditRoute()`).

## Tempstore swap gate — `ParamConverter\EditPlusTempstoreActivationChecker`

Decorates `tempstore_plus.activation_checker`. `isActive()` returns FALSE unless the current user has
`access inline editing`, then defers to the inner checker — this is what makes rendered pages show
the tempstore (draft) version of entities. `onEntitySwapped()` records the entity via
`edit_plus_active_tempstore_entities()` (a `drupal_static`) so form alters know which edit pages to
augment.

## Saving / discarding — `Controller\Tempstore`

- `save(Request)` parses `{entities}` (`$request->get('entities')`, split on `::` then `.` into
  `type.id` pairs), and for each: loads the entity, invalidates its `edit_plus` cache tag, gets its
  tempstore version, `applyTempstoreChanges()` copies non-computed/non-read-only/non-key field values
  onto the loaded entity, calls `$entity->save()`, then deletes the tempstore entry. Redirects to the
  saved entity's (possibly changed) URL or an `edit_mode_use_path` query value, and clears
  `navigationMode` via a cookie.
- `delete(Request)` deletes each entity's tempstore entry and redirects to the destination.
- `applyTempstoreChanges()` skips fields when tempstore === original, and skips computed, read-only,
  and entity-key fields (except `label`).

## Hooks (`edit_plus.module`)

- `hook_preprocess_block()` — for `inline_block` blocks in Edit Mode, adds `edit_plus` variables and
  `data-edit-plus-*` attributes so block labels/content are inline-editable; adds `user.permissions`
  + `cookies:navigationMode` cache contexts.
- `hook_form_alter()` — routes to `InlineEntityFormAlter` (inline form) or `EntityEditFormAlter`
  (+ `lb_block` alter); `hook_module_implements_alter()` re-orders it last.
- `hook_theme()` + `template_preprocess_inline_textarea()` — the `inline_textarea` element/template.
- `hook_element_info_alter()` — adds `element.edit_plus:preRenderTextFormat` pre-render to
  `inline_textarea` (see api/extending.md).
- Media Library form alters delegate to `ViewsFormMediaLibraryWidgetAlter`.
