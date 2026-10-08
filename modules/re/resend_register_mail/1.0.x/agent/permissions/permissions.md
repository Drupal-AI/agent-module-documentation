<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions & access model

## Defined permission

| Permission (machine name) | Title | Notes |
| --- | --- | --- |
| `resend account emails` | Resend account emails | Defined with `restrict access: true`, so Drupal flags it on the Permissions form. Description: "Users with this permission can resend account emails, such as the registration / welcome email." |

`resend_register_mail.permissions.yml` defines only this one permission. Core's
`administer users` (also a core permission) is accepted as an alternative everywhere below.

## Where access is enforced

All three surfaces gate on `administer users` **OR** `resend account emails`:

1. **Confirm-form route** `resend_register_mail_action.resend_email`
   (`/admin/user/resend-email`) — requirement `_permission: 'administer users+resend account emails'`.
   The `+` separator is Drupal's OR (a `,` would mean AND), so holding *either* permission passes.

2. **Action plugin** `ResendRegisterMail::access()` returns
   `AccessResult::allowedIf($account->hasPermission('administer users') || $account->hasPermission('resend account emails'))`.
   This controls whether the action appears/executes on the `/admin/people` bulk-operations form.

3. **User-edit-form button** `#access`
   (`FormHooks::resendRegisterMailFormAlter`) = the target account has an email **and**
   `hasPermission('administer users') || hasPermission('resend account emails')`.

## Effect

- Granting only `resend account emails` (without `administer users`) is enough to use both the
  bulk action and the per-user button, and nothing else on the People screen.
- The mail is always sent to the **target account's** own address (`$account->getEmail()`);
  accounts with no email are skipped (bulk) or get no button (single-user).
