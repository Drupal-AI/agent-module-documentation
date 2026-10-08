<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Ajax Login and Register Modal renders core's login, registration and password-reset forms inside an AJAX modal / off-canvas dialog and provides a block of dialog-opening links for anonymous visitors.

---

The module alters the three core user forms — `user_login_form`, `user_register_form` and `user_pass` — via `hook_form_alter`. It wraps each in a div, adds an inline `status_messages` region, and attaches an `#ajax` submit callback (`ajax_login_register_modal_validate`). When the submitted form has validation errors the wrapper is replaced in place (errors shown without a page reload); when it succeeds, an admin-configured success dialog is opened and the client is redirected to a default route, a custom URL, or reloaded, depending on per-form settings. A block plugin (`ajax_login_register_modal_block`) outputs `use-ajax` links that open those same forms in a dialog, and is shown only to anonymous users. Authentication, validation, flood/brute-force control and CSRF protection remain entirely core's — this is a presentation/UX layer, not custom auth. Four admin config forms (under `/admin/config/*/settings`, all requiring *administer site configuration*) write a single `ajax_login_register_modal.settings` config object controlling dialog type, titles, sizes, button text, success messages, in-modal links and redirect behaviour. Supports Drupal 8.8 through 11; no external dependencies.

---

- Let anonymous visitors log in without leaving the current page.
- Open the registration form in a modal dialog.
- Show the password-reset (forgot password) form in a modal.
- Present auth forms as off-canvas (side panel) dialogs instead of modals.
- Present auth forms as non-modal dialogs.
- Place a block of login / register / reset links in a header, sidebar or footer.
- Show the login/register links block to anonymous users only.
- Customise the modal title per form (login, register, reset).
- Set modal width and height per form.
- Hide the dialog title bar for a cleaner popup.
- Rename the submit/action button on each form (e.g. "Log In", "Create New Account").
- Show a custom success title and message after login/registration/reset.
- Add a "register" or "forgot password" link inside the login modal.
- Add a "login" link inside the register or reset modal.
- Redirect to the default destination after a successful submit.
- Redirect to a custom internal or external URL after submit.
- Reload the current page after a successful submit (e.g. to refresh a menu/block).
- Customise the AJAX throbber "progress" message shown while submitting.
- Keep validation errors inline in the dialog without a full page navigation.
- Improve login/registration conversion by reducing page loads.
- Reuse core's user forms unchanged (no template overrides required).
