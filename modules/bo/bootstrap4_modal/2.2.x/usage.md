<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Bootstrap 4 Modal registers a new Drupal AJAX dialog type (`bootstrap4_modal`) that renders content in a Bootstrap 4 `.modal` instead of the default jQuery UI dialog, so links and forms open in a Bootstrap-styled modal on Bootstrap-based themes.

---

The module plugs into Drupal's core AJAX/dialog system rather than adding any admin UI. It registers a **main content renderer** for the response format `drupal_bootstrap4_modal`, which is triggered by the dialog type `bootstrap4_modal` — so any `.use-ajax` link with `data-dialog-type="bootstrap4_modal"` (optionally `data-dialog-options='{…}'`) opens its target in a Bootstrap 4 modal. For programmatic use it ships three AJAX command classes extending core's dialog commands: `OpenBootstrap4ModalDialogCommand($title, $content, $options)`, `OpenBootstrap4ModalDialogByUrlCommand($title, $url, $options)`, and `CloseBootstrap4ModalDialogCommand($selector, $persist)`, which emit the JS commands `openBootstrap4Dialog`, `openBootstrap4DialogByUrl`, and `closeBootstrap4Dialog` handled by the bundled `bs4_modal.dialog` / `bs4_modal.dialog.ajax` libraries (attached automatically to every page via `hook_preprocess_page`). Dialog appearance is controlled per-invocation through `drupalSettings.bs4_modal_dialog` / dialog options: `dialogClasses` (e.g. `modal-dialog-centered`, `modal-lg`), `dialogShowHeader`, `dialogShowHeaderTitle`, `buttonClass`, `buttonPrimaryClass`, `backdrop`, `keyboard`, `focus`, `autoOpen`. It also provides an **Entity Browser display plugin** (`bootstrap4_modal`, with a `modal_size` setting) so entity browsers can open in a Bootstrap 4 modal, plus iframe/message template overrides for that case. It has no configuration form, no permissions, no Drush commands, and no config schema of its own; the modal's default markup target is `#drupal-bootstrap4-modal`. (Bootstrap's own CSS/JS must be supplied by your theme.)

---

- Open an admin or content link in a Bootstrap 4 modal via `data-dialog-type="bootstrap4_modal"`.
- Center a modal with `data-dialog-options='{"dialogClasses":"modal-dialog-centered"}'`.
- Show a large modal using the `modal-lg` dialog class.
- Load a node/edit form into a Bootstrap-styled modal instead of the jQuery UI dialog.
- Hide the modal header on a lightweight popup with `{"dialogShowHeader":false}`.
- Programmatically open a modal from a controller with `OpenBootstrap4ModalDialogCommand`.
- Open a remote URL in a modal via `OpenBootstrap4ModalDialogByUrlCommand`.
- Close the current modal from an AJAX response with `CloseBootstrap4ModalDialogCommand`.
- Style modal buttons using `buttonClass` / `buttonPrimaryClass` options.
- Disable the backdrop or keyboard-escape on a modal via dialog options.
- Configure an Entity Browser to open in a Bootstrap 4 modal (display plugin `bootstrap4_modal`).
- Pick a modal size (e.g. `modal-lg`) for an entity-browser modal via `modal_size`.
- Replace core's default modal styling site-wide on a Bootstrap 4 theme.
- Present confirmation dialogs in a consistent Bootstrap look.
- Show a contact or login form in a modal on a Bootstrap-themed site.
- Open a media/image browser inside a Bootstrap modal.
- Give editors a Bootstrap-styled "Add media" modal experience.
- Trigger a modal automatically on load with `autoOpen: true`.
- Reuse Bootstrap grid classes for modal sizing without writing custom JS.
- Build a "quick view" product modal on a Commerce/Bootstrap theme.
- Keep AJAX dialogs visually consistent with a Bootstrap 4 design system.
- Open Views links or exposed content in a Bootstrap modal.
- Provide a modal-based multi-step entity selection flow with auto-close on submit.
- Standardize popup dialogs across a subtheme by relying on the auto-attached libraries.
