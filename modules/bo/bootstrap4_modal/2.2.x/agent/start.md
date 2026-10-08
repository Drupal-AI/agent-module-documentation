<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Bootstrap 4 Modal — agent index

Adds a Drupal AJAX **dialog type `bootstrap4_modal`** (response format
`drupal_bootstrap4_modal`) that renders content in a Bootstrap 4 `.modal`. No admin UI, no
config form, no permissions, no Drush, no config schema of its own. Bootstrap's own CSS/JS
must come from your theme.

- **Open/close modals: the `use-ajax` link attribute, dialog options, and the PHP AJAX command classes** →
  [api/ajax-commands.md](api/ajax-commands.md)
- **Open an Entity Browser in a Bootstrap 4 modal (display plugin + `modal_size`)** →
  [plugins/entity-browser-display.md](plugins/entity-browser-display.md)

Key facts:
- Link usage: `class="use-ajax" data-dialog-type="bootstrap4_modal"` (+ optional
  `data-dialog-options='{...}'`). Modal target element: `#drupal-bootstrap4-modal`.
- PHP commands: `OpenBootstrap4ModalDialogCommand`, `OpenBootstrap4ModalDialogByUrlCommand`,
  `CloseBootstrap4ModalDialogCommand` → JS commands `openBootstrap4Dialog`,
  `openBootstrap4DialogByUrl`, `closeBootstrap4Dialog`.
- Dialog options: `dialogClasses` (e.g. `modal-dialog-centered`, `modal-lg`),
  `dialogShowHeader`, `dialogShowHeaderTitle`, `buttonClass`, `buttonPrimaryClass`,
  `backdrop`, `keyboard`, `focus`, `autoOpen`.
- Libraries `bs4_modal.dialog` + `bs4_modal.dialog.ajax` are auto-attached to every page.
- Entity Browser display plugin id: **`bootstrap4_modal`** (config `modal_size`).
