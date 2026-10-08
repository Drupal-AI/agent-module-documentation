<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Selection flow: hooks, iframe bridge & AJAX callback

All of this lives in `ckeditor5_entity_browser.module` plus two small JS files. There is **no
routing.yml, permissions.yml or services.yml** — the module rides on Entity Browser's own routes and
selection-storage service.

## The iframe bridge (why an iframe)

CKEditor 5's link UI opens the browser via `Drupal.ckeditor5.openDialog()`, which loads the Entity
Browser form **inline** into the AJAX modal (same document as the editor). Re-rendering Entity
Browser widgets (Views/DropzoneJS/tabs) inline is fragile — per-widget libraries and drupalSettings
are not re-delivered on widget switch. So the module mirrors Entity Browser's iframe display: the
outer request is replaced by an `<iframe>` that loads the same browser as a full standalone page.

`hook_form_BASE_FORM_ID_form_alter()` → `ckeditor5_entity_browser_form_entity_browser_form_alter()`:

- Reads `uuid` from the query or FormState, fetches its `entity_browser.selection_storage` entry, and
  acts **only when that entry has the `ckeditor` flag** (set in the plugin's
  `getDynamicPluginConfig()`). This scopes the alter to CKEditor-launched browsers only.
- **Outer request** (`eb_inner` absent): strips the form children and injects an `<iframe>` whose
  `src` re-requests the same path with `_wrapper_format` removed and `eb_inner=1` added, so the inner
  page is a full Drupal page shipping all widget assets. Attaches libraries
  `entity_link_data_sender` and `admin_styles`.
- **Inner request** (`eb_inner=1`): attaches `editor/drupal.editor.dialog`, `entity_link_data_sender`,
  `admin_styles`; removes the browser's own `widget.actions`; and injects a custom submit
  (`actions.submit`, label = the stored browser label) with `#ajax.callback =
  ckeditor5_entity_browser_process_selected_content`, plus an `#ckeditor-entity-browser-messages`
  container for AJAX status messages.

`hook_views_pre_render()` → `ckeditor5_entity_browser_views_pre_render()`: on `entity_browser.*` /
`views.ajax` routes, when the request carries `ckeditor5` + `uuid` + `original_path`, it forwards
those into the View's `ajaxViews` drupalSettings so pager/filter AJAX keeps the CKEditor context.
`hook_module_implements_alter()` pushes this module's `views_pre_render` to run last.

## The AJAX selection callback — `ckeditor5_entity_browser_process_selected_content()`

Returns an `AjaxResponse`. Steps:

1. Reads the selection from POST `entity_browser_select` (array of `entity_type:id` strings),
   `array_filter`s it. (Falls back to FormState `selected_entities` for widgets like DropzoneJS that
   populate it via earlier uploads.)
2. For each `type:id`, if `entityTypeManager()->hasDefinition($type)`, loads the entity and collects
   it; syncs the parsed selection back into FormState and the selection-storage entry.
3. Enforces **exactly one** selection (errors "Please select only one item." / "Please select one
   item." rendered into `#ckeditor-entity-browser-messages`).
4. Requires `$entity->hasLinkTemplate('canonical')` (else "This entity does not have a canonical.").
5. Builds `$url = '/' . $entity->toUrl()->getInternalPath()` and returns
   `new SetEntityLinkDataCommand($url)`.
6. Clears just this instance's `selected_entities` (keeps the storage entry so the browser can be
   reopened without a page reload — the UUID is stable in the plugin config).

## Client bridge

- `SetEntityLinkDataCommand::render()` → `{command: 'setEntityLinkData', url}`.
- `js/scripts/eb_sender.js` (`Drupal.AjaxCommands.prototype.setEntityLinkData`): `postMessage`s
  `{type:'ck5-eb-select', url, origin}` to `window.parent` **with `targetOrigin` = own origin**, then
  clicks the hosting dialog's close button.
- `js/scripts/eb_parent_receiver.js` (installed once): listens for `message`, **rejects any event
  whose `data.origin` ≠ `window.location.origin`**, then triggers `editor:dialogsave` with the URL,
  sets the `input[inputmode="url"]` value, and nudges core's entity-link-suggestions autocomplete
  (`instance.menu.focus()/select()`) so the first result resolves without navigating the page.

## Extension point — the alter hook

`hook_ckeditor5_entity_browser_definitions_alter(array &$definitions)`
(`ckeditor5_entity_browser.api.php`): keyed by entity_browser id; replace `label`, `weight`,
`widget_context`, etc. Called inside `getDynamicPluginConfig()` before the UUIDs are generated.

## Libraries (`ckeditor5_entity_browser.libraries.yml`)

- `ckeditor5` — built JS plugin + `eb_parent_receiver.js`; depends on `core/drupal.ajax`.
- `entity_link_data_sender` — `eb_sender.js`; depends on `core/drupal`, `core/drupal.ajax`.
- `admin_styles` — `css/ckeditor5_entity_browser.css`.
