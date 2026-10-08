<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
**SweetAlert** wires the [SweetAlert2](https://sweetalert2.github.io) JavaScript library into Drupal as a custom AJAX command, so server-side code can pop an accessible, styled alert dialog in response to an AJAX request. It ships an admin *Sandbox* form for trying alerts and expects the SweetAlert2 library at `/libraries/sweetalert2`.

---

The module defines a `SweetAlertCommand` (implements `CommandInterface` + `CommandWithAttachedAssetsInterface`) whose `render()` returns `{command: 'sweetalert', settings: {options: ...}}` and which attaches the `sweetalert/command` library (`/libraries/sweetalert2/sweetalert2.all.min.js` + `js/command.js`, dependency `core/drupal.ajax`). Any form/controller returning an `AjaxResponse` can `addCommand(new SweetAlertCommand([...]))` with SweetAlert2 options (title, text, icon, backdrop, etc.); `js/command.js` calls `Swal.fire()` with those options. A demo `SandboxForm` at `/admin/config/user-interface/sweetalert/sandbox` (route `sweetalert.sandbox`, permission *administer site configuration*) lets an admin enter a title/message and backdrop toggle and fires the alert via an AJAX submit. The module has no other routes, no permissions of its own and no persisted config; it is a developer-facing building block. The SweetAlert2 library must be installed under the site `libraries/` directory (checked at install).

---

- Show a styled success alert after an AJAX form submit.
- Replace default JS `alert()`/`confirm()` popups with SweetAlert2.
- Pop an accessible (WAI-ARIA) dialog from a Drupal AJAX response.
- Add a `SweetAlertCommand` to any `AjaxResponse` in custom code.
- Configure alert title, text, icon and backdrop via options.
- Try alerts interactively in the admin sandbox form.
- Confirm a destructive action with a modal before proceeding.
- Display validation feedback as a popup rather than inline.
- Toast-style notify users of background operation results.
- Attach the SweetAlert2 assets only when the command is used.
- Build custom confirmation flows in contributed modules.
- Reuse a single alert style across the whole site.
- Show a themed error dialog on a failed AJAX call.
- Provide editors immediate visual feedback on actions.
- Integrate SweetAlert2 without writing library-loading boilerplate.
- Trigger alerts from Form API `#ajax` callbacks.
- Standardize modal messaging UX site-wide.
