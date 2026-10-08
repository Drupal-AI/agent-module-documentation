<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Dialog Native — library override & architecture

## Install / enable
`drush en dialog_native`. There is nothing to configure — no settings form,
routes, permissions, config objects, or schema. Once enabled, the library swap
applies site-wide to every page that loads a Drupal dialog.

## How the swap works
`dialog_native_library_info_alter(&$libraries, $extension)` in
`dialog_native.module` acts only when `$extension === 'core'` and
`drupal.dialog` exists. It:
1. `unset()`s core `drupal.dialog` and `drupal.dialog.ajax` entirely (the comment
   notes core's version has too many dependencies to patch piecemeal).
2. Recreates `drupal.dialog` with a single dependency `dialog_native/dialogNative`.
3. Recreates `drupal.dialog.ajax` with a single dependency
   `dialog_native/dialogNativeAjax`.

Because the core library *names* are preserved, anything that declares a
dependency on `core/drupal.dialog` transparently loads the native replacement.

## Libraries (`dialog_native.libraries.yml`)
- `dialogNative`: JS `dist/dialogTheme.js`, `dist/dialog.js`; CSS
  `css/dialogNative.css` (component); deps `core/drupal`, `core/drupal.displace`,
  `core/internal.floating-ui`.
- `dialogNativeAjax`: JS `dist/dialogAjax.js`; deps `core/jquery`, `core/drupal`,
  `core/drupalSettings`, `core/drupal.ajax`, `core/drupal.dialog`.

Sources are TypeScript in `src/`, compiled to `dist/` with Vite (`vite.config.js`,
`package.json` scripts `build`/`watch`). Edit `src/*.ts`, not `dist/*.js`.

## Core API surface (from `src/`)

### `Drupal.dialog(element, options)` — `src/dialog.ts`
- Merges `options` over `drupalSettings.dialog` defaults (`autoOpen: true`,
  `buttonClass`, `buttonPrimaryClass`, a `close` handler).
- `element` may be an `HTMLElement` or an HTML string; strings are turned into a
  node by `_createElementFromString()` (sets `innerHTML`, appends first child to
  `document.body`).
- Creates a `<dialog class="drupal-dialog" draggable="true">`, fills it via
  `Drupal.theme('dialog', …)`, appends to `<body>`.
- A `MutationObserver` on the `open` attribute drives `aftercreate`.
- Returns the `<dialog>` element; caller opens it with `showModal()` (modal) or
  `show()`. `autoOpen` opens it immediately based on `settings.modal`.
- `closeOnEscape === false` traps the `cancel` event and Escape `keydown`.
- Sizing options `height|width|maxHeight|maxWidth|minHeight|minWidth|zIndex` are
  written as inline `px` styles (`zIndex` unitless).
- `jqueryDeprecations()` (`src/jqueryDeprecations.ts`) calls
  `Drupal.deprecationError()` for any of `appendTo, classes, draggable, hide,
  position, resizable, show` passed in `settings` — they have no effect.

### Lifecycle events (`DrupalDialogEvent`, bubbling)
`dialog:beforecreate`, `dialog:aftercreate`, `dialog:beforeclose`,
`dialog:afterclose` — dispatched on the content element; each carries `.dialog`
and `.settings`. On close, `Drupal.detachBehaviors()` runs on the content.

### AJAX adapter — `src/dialogAjax.ts`
- `Drupal.behaviors.dialog.attach()` injects a hidden `#drupal-modal` container if
  absent, and wraps the settings `close` callback to also dispatch `dialog-remove`.
- `prepareDialogButtons(dialog)` collects `.form-actions input[type=submit]`,
  `a.button`, `a.action-link`, hides the originals, and returns button configs
  whose `click` re-dispatches the native click on the source control.
- `Drupal.AjaxCommands.prototype.openDialog` — resolves/creates `response.selector`,
  reuses the core `insert` command (`method: 'html'`) to populate content, then
  `Drupal.dialog(dialog, response.dialogOptions)` and `showModal()`/`show()` by
  `response.dialogOptions.modal`. (Note: it contains a leftover
  `console.log('dialog', …)`.)
- `Drupal.AjaxCommands.prototype.closeDialog` — finds `response.selector`, closes
  it, and unless `response.persist` dispatches `dialog-remove` to remove the node.

### Theme functions — `src/dialogTheme.ts`
Overridable via `Drupal.theme`:
- `Drupal.theme.dialog({buttons, closeText, domElement, title})` — builds
  `.drupal-dialog__wrapper` from header + content + buttons sub-themes.
- `Drupal.theme.dialogHeader(title, closeText)` — renders `.drupal-dialog__header`
  with an `<h4 class="drupal-dialog__title">` and a translated `Close` button.
- `Drupal.theme.dialogContent(content)` — wraps the content node in
  `.drupal-dialog__content` (via `appendChild`).
- `Drupal.theme.dialogButtons(buttons)` — builds `.drupal-dialog__buttons` from an
  array of `{text, class, click}` or an object of `{buttonText: clickHandler}`.

## Operating notes
- Nothing to toggle per-request; the override is global once enabled. To revert,
  disable the module — core's original `drupal.dialog` returns automatically.
- CSS hooks for styling: `drupal-dialog`, `drupal-dialog__wrapper`,
  `drupal-dialog__header`, `drupal-dialog__title`, `drupal-dialog__close`,
  `drupal-dialog__content`, `drupal-dialog__buttons`.
- Commented-out `@floating-ui/dom` positioning code remains in `src/dialog.ts`;
  positioning is still WIP. Treat the module as experimental per its own README.
