<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Bulk resend action + confirm form

The module's primary feature is a bulk **Action** on the People listing plus a confirm form
that lets the operator choose which account mail to send.

## The Action plugin

`Drupal\resend_register_mail\Plugin\Action\ResendRegisterMail` — declared with the
`#[Action]` attribute:

```php
#[Action(
  id: "resend_register_mail_action",
  label: new TranslatableMarkup("Resend registration / welcome email to selected users"),
  confirm_form_route_name: "resend_register_mail_action.resend_email",
  type: "user"
)]
```

It is enabled by the config entity `system.action.resend_register_mail_action` (shipped in
`config/install/`, label `Resend registration / welcome email`), so the action shows up in the
Action dropdown of `/admin/people` (route `entity.user.collection`) after install.

Runtime flow:
1. `executeMultiple(array $accounts)` saves the selected user entities into the **private
   tempstore** collection `user_user_operations_resend_email`, keyed by the current user's id
   (`$this->currentUser->id()`). `execute($account)` just wraps a single account into `executeMultiple`.
2. Because the plugin sets `confirm_form_route_name`, core redirects to
   `resend_register_mail_action.resend_email` (`/admin/user/resend-email`).
3. `access()` allows the action only if the account has `administer users` **or**
   `resend account emails` (see permissions/permissions.md).

## The confirm form

`Drupal\resend_register_mail\Form\UserMultipleResendEmail` (extends `ConfirmFormBase`,
form id `user_multiple_resend_email`, marked `@internal`).

`buildForm()`:
- Reloads the selected accounts from the current user's tempstore entry. If none, it redirects
  back to `entity.user.collection`.
- Lists the selected account names (themed `item_list`).
- For any selected account **without** an email address it adds a message. If exactly one account
  was selected and it has no email → error message + redirect back; if there were several → a
  warning and it continues (the mail-less accounts are skipped at submit).
- Shows a required `select` (`message_type`) with these options:

| Option value (`message_type`) | Label in the dropdown | Core mail sent (`user.settings.mails.*`) |
| --- | --- | --- |
| `register_admin_created` | Welcome message for user created by the admin | `register_admin_created` |
| `register_no_approval_required` | Welcome message when user self-registers. | `register_no_approval_required` |
| `register_pending_approval` | Welcome message, user pending admin approval. | `register_pending_approval` |
| `password_reset` | Password recovery request. | `password_reset` |

- The default selected option is derived from core's `user.settings.register`:

| `user.settings.register` | default `message_type` |
| --- | --- |
| `admin_only` (`REGISTER_ADMINISTRATORS_ONLY`) | `register_admin_created` |
| `visitors_admin_approval` (`REGISTER_VISITORS_ADMINISTRATIVE_APPROVAL`) | `register_pending_approval` |
| anything else (e.g. `visitors`) | `register_no_approval_required` |

`submitForm()`:
- Deletes the current user's tempstore entry first.
- When `confirm` is set, for every account in the form's `accounts` values it reloads the user
  (`UserStorageInterface::load`) and, if the account still has an email, calls
  `_user_mail_notify($message_type, $account)`.
- Adds the message "Welcome message has been sent to selected users." and redirects to
  `entity.user.collection`.

The confirm/cancel URLs, question ("Select the email type you want to send") and confirm button
("Submit") come from the `ConfirmFormBase` overrides.

## Sending the same mail programmatically

The whole action is a thin wrapper over core. To send one of these mails from code:

```php
// $account is a loaded \Drupal\user\UserInterface with a non-empty mail.
_user_mail_notify('register_no_approval_required', $account);
```

## Config object + schema

- Config entity: `system.action.resend_register_mail_action` (type `user`, plugin
  `resend_register_mail_action`, empty `configuration`). Delete it to remove the action from the
  People screen; re-import config/install to restore it.
- Schema: `config/schema/resend_register_mail.schema.yml` defines
  `action.configuration.resend_register_mail_action` as `action_configuration_default` (no custom
  configuration keys). There is no admin settings form.
