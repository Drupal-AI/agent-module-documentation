# Bootstrap 4 Modal — manual setup guide

**Bootstrap 4 Modal** (`bootstrap4_modal`) registers a new Drupal AJAX **dialog
type** that renders content inside a Bootstrap 4 `.modal` instead of the default
jQuery UI dialog. On a Bootstrap-based theme this means links and forms open in a
popup that matches the rest of your design, with no custom JavaScript on your
part.

You opt a link into the Bootstrap modal the same way you would any core AJAX
dialog: add the `use-ajax` class and set `data-dialog-type="bootstrap4_modal"`.
For programmatic use — opening or closing a modal from a controller or form — the
module ships three PHP AJAX command classes that mirror core's own dialog
commands. Appearance (centering, size, whether to show a header, backdrop, ESC
behaviour, and so on) is controlled per popup through dialog options.

This is a **developer- and themer-facing** module: there is no admin UI, no
settings form, no permissions, and nothing to configure. The one thing to know is
that the module only styles the dialog — it does **not** bundle Bootstrap 4's own
CSS and JavaScript, so you must be running a Bootstrap-4-based theme (or add
Bootstrap yourself) for the modals to look right. It also provides an optional
**Entity Browser** display so entity browsers can open in a Bootstrap modal.

This guide is written for a **human** working through the setup. If you want
terse, token-cheap references for an AI coding agent — including the full dialog
option table and the PHP command signatures — read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## How to use it

The module's libraries are attached to every page automatically once it is
enabled, so there is nothing to switch on. To open something in a Bootstrap 4
modal, add a standard AJAX link and name this module's dialog type:

```html
<a href="/node/1"
   class="use-ajax"
   data-dialog-type="bootstrap4_modal"
   data-dialog-options='{"dialogClasses":"modal-dialog-centered","dialogShowHeader":false}'>
  Open in Bootstrap 4 Modal
</a>
```

- `data-dialog-type="bootstrap4_modal"` selects this module's dialog.
- `data-dialog-options` (optional, JSON) tunes the popup. Common choices:
  `dialogClasses` for size/positioning (e.g. `modal-lg`, `modal-sm`,
  `modal-dialog-centered`), `dialogShowHeader` to show or hide the header bar,
  `backdrop`, `keyboard` (close on ESC), and `autoOpen`.

To drive a modal from PHP (for example after a form submission), add one of the
module's AJAX commands to an `AjaxResponse` —
`OpenBootstrap4ModalDialogCommand`, `OpenBootstrap4ModalDialogByUrlCommand`, or
`CloseBootstrap4ModalDialogCommand`. The full attribute reference, option
defaults, and command constructor signatures live in the
[`agent/`](../agent/start.md) docs.

**Remember:** this module supplies only the dialog glue. Bootstrap 4's own CSS/JS
must come from your theme.
