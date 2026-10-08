<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Resend button on the user edit form (hook_form_user_form_alter)

The module adds a per-user resend button to the user edit form
(`entity.user.edit_form`, base form id `user_form`).

## Wiring

- `resend_register_mail.module` declares `resend_register_mail_form_user_form_alter()` with
  `#[LegacyHook]`; it delegates to the OOP hook service.
- `Drupal\resend_register_mail\Hook\FormHooks::resendRegisterMailFormAlter()` carries the real
  logic and is registered with `#[Hook('form_user_form_alter')]`. The class is an autowired
  service (`resend_register_mail.services.yml`, parameter `resend_register_mail.hooks_converted: true`),
  constructed with `config.factory`, `current_user`, `messenger`, and `logger.factory`.

## What the alter does

Runs only when the form object is an `EntityFormInterface` whose entity is a `UserInterface`.

- Reads `user.settings.register`. It computes `send_awaiting_approval = TRUE` only for
  `REGISTER_VISITORS_ADMINISTRATIVE_APPROVAL`, else `FALSE`.
- **Early return (no button)** when `!send_awaiting_approval && !$entity->isActive()` — i.e. an
  inactive account on a site that is not using admin-approval registration gets no button.
- Otherwise it adds `$form['actions']['resend_register_mail']`, a `submit` button whose
  `#value` is `Resend welcome message` for an active account or `Resend awaiting approval message`
  for an inactive one.
- The button's own submit handler is `[$this, 'submitForm']` (see below).
- `#access` = the account has an email **and** the current user has `administer users` **or**
  `resend account emails`.

Because the button defines its own `#submit`, clicking it runs only that handler — it sends the
mail and re-renders the form; it does **not** run the user form's default `::save` handler, so
edits typed into the form are not persisted by this button.

## Submit handler `FormHooks::submitForm()`

For the account being edited it picks the op:

| Account / config state | op passed to `_user_mail_notify()` |
| --- | --- |
| account is **inactive** | `register_pending_approval` |
| active + `user.settings.register` == `admin_only` (`REGISTER_ADMINISTRATORS_ONLY`) | `register_admin_created` |
| active, any other register mode | `register_no_approval_required` |

It then calls `_user_mail_notify($op, $account)`. On a truthy return it logs a `notice` to the
`resend_register_mail` logger channel and shows a success message
("Welcome message has been sent to %name at %email"); on a falsy return it logs and shows an
error message. Messages/log lines interpolate `$account->getAccountName()` and `getEmail()`.

Note this single-user button path does **not** offer the `password_reset` option — only the bulk
confirm form (configure/resend_action.md) does.
