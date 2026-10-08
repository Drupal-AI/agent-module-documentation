<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Cancel Account Separate Form

## What it is / when to use

- Exposes account cancellation as a dedicated, embeddable form separate from the core user edit page.
- Use when you want a self-service "delete my account" form with password confirmation.
- Enforces the standard Drupal account cancellation methods.

---

## Install & configure

- Enable the module; it provides `CancelAccountForm` (form id `cancel_account_form`).
- Grant the core `cancel account` permission to roles that may self-cancel.
- Optionally grant `select account cancellation method` to let users choose the cancellation method; otherwise the site default (`user.settings:cancel_method`) is used.
- The form is embedded (e.g. via block/hook); it takes an optional account id argument.

---

## Usage & API notes

- `buildForm` only renders cancellation fields when the current user equals the target account AND is not anonymous.
- User 1 (superadmin) is explicitly excluded from the form.
- A current-password field is required and validated against the logged-in user's stored hash via the `password` service.
- `submitForm` always calls `user_cancel()` on `currentUser()->id()` — a user can only cancel THEIR OWN account, never another.
- The cancellation method is taken from the user's selection only if they hold `select account cancellation method`, else from site config.
- Being a Drupal `FormBase`, submissions are CSRF-protected by the form token.
- A confirmation checkbox plus filled password are required to enable the submit button.
- Notification-on-cancel follows `user.settings:notify.status_canceled`.
- After cancellation the user is redirected to the front page.
- No custom routes are declared in this module (the form is embedded by host code/block).
- No anonymous access: anonymous users get an empty form.
- Password verification uses `hash`-based `PasswordInterface::check()` (timing-safe).
- The optional `$extra` account-id argument only affects display gating, never the account actually cancelled.
- Suitable for GDPR "right to erasure" self-service flows.
- Combine with a page/block placement to expose the form to end users.
- Uninstall removes only the module; no config entities are created.
