<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CKEditor 5 widget, select modal, route & token

The authoring half: the toolbar button/widget that writes the embed tag, the modal that picks a
webform, and the route + CSRF-token plumbing that connects them.

## CKEditor 5 plugin declaration — `ck5_webform.ckeditor5.yml`

- Provider key `ck5_webform_insert`.
- `ckeditor5.plugins: [ WebformInsert.WebformInsert ]` (namespace.ClassName in the JS bundle).
- `drupal`: label *Webform Insert*, `library: ck5_webform/webform`, `admin_library: ck5_webform/admin`.
- `toolbar_items.webformInsert.label: Embed Webform`.
- `elements: [ <drupal-webform data-webform-id> ]` — the model→data element it may produce.
- `conditions: { filter: filter_ck5_webform }` — button appears only when the render filter is on.

## JS plugin — `js/webforminsert.js`

IIFE `(Drupal, drupalSettings, CKEditor5, $)`; bails if `CKEditor5.core` is absent.

- **`WebformInsertCommand extends Command`** — `execute({ 'data-webform-id': id })` inserts a
  `drupalWebform` model element and selects it; `refresh()` enables the command unless a non-webform
  element is selected.
- **`WebformInsert extends Plugin`** (`requires: [Widget]`, `pluginName: 'WebformInsert'`):
  - Registers command `webformInsertCommand` and toolbar button `webformInsert` (SVG icon, label
    "Embed Webform").
  - Button `execute` → `_handleOpenModal()`.
  - `ready`: a DOM `dblclick` listener on the editable; double-clicking a
    `.webform-widget-container` re-selects that widget and re-fires the button (edit an existing
    embed).
  - Global bridge: on jQuery event `webform_selected_for_editor.ck5` it runs
    `editor.execute('webformInsertCommand', { 'data-webform-id': id })` and restores scroll.
  - `_defineSchema()`: registers model element `drupalWebform` (`isObject`, `isBlock`,
    `allowWhere: $block`, attr `data-webform-id`).
  - `_defineConverters()`:
    - **upcast** `<drupal-webform data-webform-id>` → model `drupalWebform`.
    - **dataDowncast** (saved output) → `<drupal-webform data-webform-id="ID">` container element
      (attribute set via the writer, not string-built).
    - **editingDowncast** (editor preview only) → a `<section class="webform-widget-container">`
      whose inner label `<div>` is built with `createRawElement` and sets `innerHTML` containing the
      ID; this preview is only shown to the authoring user inside CKEditor, never in the saved data
      or the front-end render.
- `_handleOpenModal()`: reads `drupalSettings.ck5_webform.token`, builds
  `Drupal.url('ck5-webform/insert-modal')?token=<token>` (adds `&current_webform_id=<id>` when a
  widget is selected), and opens it with `Drupal.ajax({ dialogType: 'modal', … })`.
- `$.fn.ck5WebformInsertTrigger = id => $(window).trigger('webform_selected_for_editor.ck5', [id])`
  — the AJAX command target the modal calls on submit.

## Modal form — `WebformSelectForm` (`src/Form/WebformSelectForm.php`)

- `FormBase`, form id `ck5_webform_select_form`; DI `entity_type.manager`, `request_stack`.
- `buildForm()`: reads `current_webform_id` from the query; `loadMultiple()` all webforms and lists
  **only `isOpen()`** ones as `#options` (id ⇒ label) in a required `select`. Title switches to
  *"Edit Webform: …"* when editing an existing, in-list embed.
- Submit is AJAX-only (`ajaxSubmit`): on no errors, closes the modal
  (`CloseModalDialogCommand`) and fires `InvokeCommand(NULL, 'ck5WebformInsertTrigger', [$id])`,
  handing the chosen ID back to the JS plugin. `submitForm()` is a no-op; `ajaxCancel()` just closes.

## Route & token — `ck5_webform.routing.yml` + `ElementTokenAttachment`

- Route `ck5_webform.open_modal`, path `/ck5-webform/insert-modal`, `_form: WebformSelectForm`,
  requirements `_access: 'TRUE'` and `_csrf_token: 'TRUE'`, `options._admin_route: TRUE`.
- `ck5_webform_element_info_alter()` (`ck5_webform.module`) appends the trusted pre-render callback
  `ElementTokenAttachment::attachToken` to the core `text_format` render element.
- `attachToken()` (`src/Render/ElementTokenAttachment.php`): generates the CSRF token for the modal
  route's internal path and puts it in `drupalSettings.ck5_webform.token`; adds cache contexts
  `user.permissions` and `session`. Errors are logged to the `ck5_webform` channel and swallowed.

## Operating notes

- No permission of its own; who can insert embeds is governed by which roles can use the text
  format / CKEditor 5 toolbar. The rendered form's behaviour is Webform's.
- Only open webforms are offered in the modal and only open webforms render (closed ones are
  dropped by the filter), so an embed of a later-closed form disappears from output.
- `css/admin.css` (library `ck5_webform/admin`) styles the modal/help text; no external assets.
