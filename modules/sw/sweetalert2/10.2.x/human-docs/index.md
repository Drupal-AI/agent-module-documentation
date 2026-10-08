# SweetAlert2 — manual setup guide

**SweetAlert2** (`sweetalert2`) makes the
[SweetAlert2](https://sweetalert2.github.io) JavaScript library available to
Drupal as an attachable asset library, so a theme or module can replace the
browser's stock `alert()` and `confirm()` dialogs with beautiful, themed modals.

This is a library‑wrapper module of the simplest kind. It declares the library,
checks that the library files are present, and handles attaching it — nothing
more. There is no configuration form, no permission, no block, and no route.
Enabling it on its own **changes nothing visible**: a theme or custom module has
to attach `sweetalert2/sweetalert2` and call `Swal.fire()` in its own JavaScript.
The module exists so that several modules (or a theme) can depend on **one shared
copy** of the library instead of each bundling its own.

One important detail: the library itself is **not** bundled with the module — you
install it separately under `libraries/`, which is exactly what the module's
install check verifies. So the classic "I enabled the module but my dialogs still
look like plain browser alerts" report almost always means the library is missing,
not that anything is broken in code. Also note the module's version number tracks
the wrapper, not the underlying library version — confirm which SweetAlert2
version you actually installed before relying on a specific library API. This
project is **not covered by Drupal's security advisory policy**. It has no module
dependencies and supports a wide core range (Drupal 8 through 11).

This guide is written for a **human** setting the module up. If you want terse,
token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the SweetAlert2 library and
   the module, then enable it.

## How to use it

There is no admin page. From a theme or module, attach the library and call the
SweetAlert2 API in your own JavaScript, for example:

```javascript
Swal.fire({
  icon: 'error',
  title: 'Oops...',
  text: 'Something went wrong!',
  footer: 'Why do I have this issue?'
});
```

See the [SweetAlert2 examples](https://sweetalert2.github.io) for the full API.
(If you want a ready‑made way to fire alerts from server‑side Drupal AJAX
responses rather than writing your own JavaScript, the separate
[SweetAlert](https://www.drupal.org/project/sweetalert) module provides an AJAX
command built on this same library.)
