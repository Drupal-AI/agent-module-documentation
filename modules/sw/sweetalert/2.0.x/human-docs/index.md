# SweetAlert — manual setup guide

**SweetAlert** (`sweetalert`) wires the
[SweetAlert2](https://sweetalert2.github.io) JavaScript library into Drupal as a
custom **AJAX command**, so your server‑side code can pop an accessible, styled
alert dialog in response to an AJAX request. It is a modern replacement for the
browser's plain `alert()` and `confirm()` — capable of simple alerts,
confirmation dialogs, and toast‑style notifications.

The problem it solves is a developer one. Normally, showing a nice modal after a
form submit or AJAX callback means loading a JavaScript library and writing the
glue code yourself. This module packages that up: any form or controller that
returns an `AjaxResponse` can add a `SweetAlertCommand` with SweetAlert2 options
(title, text, icon, backdrop, and so on), and the module attaches the library and
fires `Swal.fire()` for you.

This is a **developer‑facing building block** — there is no site‑wide settings
form and no configuration you need to fill in. It does ship a small admin
**Sandbox** page where you can try out alert options interactively and see what
they look like. It has no module dependencies, but it does require the SweetAlert2
JavaScript library to be installed at `/libraries/sweetalert2` (the module checks
for this at install time). Supports Drupal 9 and 10. There are no submodules.

This guide is written for a **human** setting the module up. If you want terse,
token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the SweetAlert2 library and
   the module, then enable it.

## Where it lives in the admin menu

Once enabled, there is a demo **Sandbox** at
**Configuration → User interface → SweetAlert → Sandbox**
(`/admin/config/user-interface/sweetalert/sandbox`, gated by the *administer site
configuration* permission). Enter a title, message, and backdrop toggle and it
fires the alert via an AJAX submit so you can preview the result.

## How to use it

In custom code, add the command to any AJAX response:

```php
$response = new AjaxResponse();
$response->addCommand(new SweetAlertCommand([
  'title' => $title,
  'text' => $message,
]));
return $response;
```

The module attaches the SweetAlert2 assets only when the command is used and calls
`Swal.fire()` with the options you pass. You can trigger this from Form API
`#ajax` callbacks, controllers, or contributed modules to standardise modal
messaging across your site. If you are upgrading from the 1.x branch, note that
some SweetAlert2 option names changed between library versions 1 and 2 — check the
[SweetAlert2 upgrade docs](https://sweetalert2.github.io/#download) for any option
names your code needs to update.
