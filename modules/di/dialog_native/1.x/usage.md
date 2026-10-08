Dialog Native replaces Drupal core's jQuery UI–based dialog.js with a drop-in library built on the native HTML `<dialog>` element.

---

Dialog Native is a developer/front-end module that swaps out Drupal core's `drupal.dialog` and `drupal.dialog.ajax` JavaScript libraries for reimplementations that use the browser's native `<dialog>` element instead of jQuery UI Dialog. It works transparently: `hook_library_info_alter()` unsets the core `drupal.dialog` / `drupal.dialog.ajax` libraries and re-points them at the module's own `dialogNative` and `dialogNativeAjax` libraries, so existing `Drupal.dialog()` calls and AJAX `openDialog` / `closeDialog` commands keep working without code changes. The module ships a compatibility adapter that emits `Drupal.deprecationError()` warnings for jQuery UI dialog options that no longer apply (`appendTo`, `classes`, `draggable`, `hide`, `position`, `resizable`, `show`), and uses `@floating-ui/dom` plus `core/drupal.displace` for positioning. The stated goal is to remove the jQuery UI Dialog dependency from Drupal and eventually merge this into core (issue #2158943). It is explicitly labelled heavy work-in-progress and not production ready. There is no admin UI, no configuration, no routes, no permissions, and no PHP services — just a single `hook_library_info_alter()` and compiled front-end assets.

---

- Remove the jQuery UI Dialog dependency from a Drupal 10 or 11 site's front end.
- Render Drupal modal and non-modal dialogs using the native HTML `<dialog>` element.
- Keep existing `Drupal.dialog(element, options)` calls working unchanged while switching to native dialogs.
- Keep existing AJAX dialog links (`use-ajax` with `data-dialog-type="modal"` / `dialog`) working with native dialogs.
- Support Drupal's AJAX `openDialog` command against the native implementation.
- Support Drupal's AJAX `closeDialog` command (including the `persist` option) against the native implementation.
- Fire the standard Drupal dialog lifecycle events: `dialog:beforecreate`, `dialog:aftercreate`, `dialog:beforeclose`, `dialog:afterclose`.
- Preserve modal vs. non-modal behaviour via the `modal` option (`showModal()` vs. `show()`).
- Honour the `autoOpen` option to open a dialog immediately on creation.
- Honour the `closeOnEscape: false` option to trap the Escape key and the native `cancel` event.
- Apply sizing options (`height`, `width`, `maxHeight`, `maxWidth`, `minHeight`, `minWidth`, `zIndex`) as inline styles on the dialog.
- Provide themeable dialog markup via overridable `Drupal.theme.dialog`, `dialogHeader`, `dialogContent`, and `dialogButtons` functions.
- Render a dialog close button using the translated `closeText` option (default "Close").
- Auto-collect form action buttons (`.form-actions` submit/button/action-link) into dialog buttons via `prepareDialogButtons`.
- Warn developers, via deprecation errors, when they pass jQuery UI dialog options that native dialogs ignore.
- Reattach and detach Drupal behaviours on dialog content when dialogs open and close.
- Evaluate the accessibility and styling differences between native `<dialog>` and jQuery UI dialogs on a theme.
- Prototype and test the front-end library slated for Drupal core issue #2158943.
- Style dialogs with plain CSS (`css/dialogNative.css`) and the `drupal-dialog`, `drupal-dialog__wrapper`, `drupal-dialog__header`, `drupal-dialog__content`, `drupal-dialog__buttons` classes instead of jQuery UI theming.
- Reduce front-end JavaScript weight by dropping jQuery UI Dialog and its dependencies.
- Contribute to the community effort to modernise Drupal's dialog/modal API.
