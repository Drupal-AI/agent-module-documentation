<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Route overrides, preview forms & the JS behavior

This module adds **no routes of its own**. It takes over three core Layout Builder routes and adds
a preview lifecycle. All access control stays with core (see "Access" below).

## 1. The route subscriber

`src/Routing/RouteSubscriber.php` — `RouteSubscriber extends RouteSubscriberBase`, registered as
service `layout_builder_instant_preview.route_subscriber` (tagged `event_subscriber` in
`layout_builder_instant_preview.services.yml`). In `alterRoutes(RouteCollection $collection)`:

| Core route | Change | Result |
|---|---|---|
| `layout_builder.add_block` | `setDefaults(['_controller' => …AddBlockController::addBlock, '_title' => <original>])` | Adding a block opens **this module's** update form. |
| `layout_builder.update_block` | `setDefault('_form', …LayoutBuilderUpdateBlockForm)` | Editing a block uses the preview-enabled form. |
| `layout_builder.configure_section` | `setDefault('_form', …LayoutBuilderConfigureSectionForm)` | Configuring a section uses the preview-enabled form. |

Only **defaults** are touched; route `requirements` (the Layout Builder access checks) are left
untouched, so who may reach these routes is unchanged from core.

## 2. The add-block controller

`src/Controller/LayoutBuilderAddBlockController.php` — `LayoutBuilderAddBlockController extends
ControllerBase`, DI: `form_builder`, `uuid`, `context.handler`, `plugin.manager.block`.
`addBlock(SectionStorageInterface $section_storage, $delta, $region, $plugin_id)` mirrors core:
creates the block plugin, maps required contexts via `ContextHandlerInterface::getMatchingContexts`
(first matching context per required slot), appends a `SectionComponent` (new UUID) to the section,
calls `rebuildLayout()`, then renders **this module's** `LayoutBuilderUpdateBlockForm` into
`#drupal-off-canvas` with an `HtmlCommand`. The only substantive difference from core is that it
opens the module's own update form so the new block gets the preview UI immediately.

## 3. The two preview forms

Both extend their core counterpart and add the same three action elements when `isAjax()`:

`src/Form/LayoutBuilderUpdateBlockForm.php` (`extends UpdateBlockForm`) — adds the UI **only when
the block plugin base id is not `block_content`** (`[$plugin_base_id] = explode(':', $plugin_id)`);
reusable content blocks are skipped because core already previews them.

`src/Form/LayoutBuilderConfigureSectionForm.php` (`extends ConfigureSectionForm`) — adds the UI
**only when `$this->isUpdate`** (configuring an existing section). Add-section has no custom
controller yet, so new sections get no preview.

Added elements (both forms):

- `actions.preview` — submit, `#value` "Preview", class `layout-builder-instant-preview`,
  `#ajax.callback = ::ajaxSubmit`, `disable-refocus = TRUE`.
- `actions.cancel` — submit, `#value` "Cancel", `#ajax.callback = ::ajaxSubmit`.
- `actions.enable_preview` — checkbox "Automatic preview", class `toggle-instant-preview`,
  `#access = ($show_checkbox === NULL || $show_checkbox)` from config key
  `show_enable_preview_checkbox` (see [../config/settings.md](../config/settings.md)).
- `#attached.library[] = 'layout_builder_instant_preview/preview'`.

Both also override `submitLabel()` to return "Save".

### Preview / cancel lifecycle (the core trick)

`validateForm()` — when the triggering element's last `#parents` name is `preview` or `cancel`, it
calls `$form_state->setLimitValidationErrors([])` and `$form_state->clearErrors()` before
`parent::validateForm()`. This lets a **partially filled** block preview (and lets Cancel dismiss a
form that has validation errors) without the errors blocking anything.

`submitForm()`:
- **Preview** (`op == 'Preview'`): builds a `SubformState` for the plugin subform, calls the block
  plugin's `submitConfigurationForm()`, merges the new settings into the component/section
  configuration in memory (`setConfiguration()` / `setLayoutSettings()`), then **returns early** —
  it never writes to the Layout Builder tempstore, so the preview is discarded.
- **Cancel** (`op == 'Cancel'`): replaces `$this->sectionStorage` with
  `getUnchangedSectionStorage()` and returns.
- Otherwise falls through to `parent::submitForm()` (the real Save).

`successfulAjaxSubmit()` — in preview mode returns `rebuildLayout($this->sectionStorage)` (the
re-rendered layout markup); otherwise defers to core.

`getUnchangedSectionStorage()` — bypasses core's static `LayoutTempstoreRepository` cache (added in
D10.3) by reading `tempstore.shared` directly: collection
`'layout_builder.section_storage.' . getStorageType()`, key `getTempstoreKey()`, returning
`['section_storage']` if present. This restores the last **saved** state when a preview is
cancelled.

## 4. The JS behavior

`js/layout-builder-instant-preview.js` — library `layout_builder_instant_preview/preview` (deps:
`core/drupal`, `core/drupal.debounce`, `core/jquery`, `core/once`, `editor/drupal.editor`).
`Drupal.behaviors.layoutBuilderInstantPreview` binds to
`form#layout-builder-update-block, form#layout-builder-configure-section`:

- On core's `formUpdated` event it calls the Preview button's `.mousedown()` (via a 200ms debounce
  on top of core's 300ms `formUpdated` debounce), **only if** the `.toggle-instant-preview`
  checkbox is checked. It filters out: the `op` submit buttons (avoids an infinite loop), the form
  element itself, Media Library add/remove noise (but allows drag reorder), link `[uri]` fields,
  and CKEditor 5 (handled separately).
- **CKEditor 5**: polls `Drupal.CKEditor5Instances` until the editor exists, then listens to
  `editor.model.document` `change:data` on a 500ms debounce (works around D10.2.5 firing
  `formUpdated` immediately and dropping the last keystrokes).
- **Media Library**: re-submits when the widget reloads after add/remove/edit.
- **CKEditor 4**: skips preview while maximized; re-previews on un-maximize.
- Wires the off-canvas tray **close (X) button and Esc key** to trigger the Cancel button so the
  layout is always reverted correctly.
- Monkey-patches `Drupal.behaviors.dialog.attach` with a `preventDialogStealingFocus` kill switch
  so a preview re-render does not steal focus from the field being edited.
- Persists the per-user toggle in `localStorage` (`enable_instant_preview`, default on) and
  re-applies the active-block highlight after each re-render.

## Access

Because the subscriber never alters route `requirements`, reaching add-block / update-block /
configure-section still requires core Layout Builder's access checks (a user permitted to
configure that layout). Preview re-renders the block/section through its normal render pipeline for
that same already-authorized user and, critically, **discards** the config (never persisted unless
Save is clicked). There are no new endpoints, no external calls, no request-supplied URLs, and no
raw markup assembly beyond core's render system.
