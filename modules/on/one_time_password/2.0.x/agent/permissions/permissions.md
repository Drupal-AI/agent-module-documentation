<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions & access model

Source: `one_time_password.permissions.yml`, `one_time_password.routing.yml`, `src/Form/EntryForm.php`,
`src/UserFieldAttach.php`.

## Declared permission

| Permission | Restricted | Gates |
|---|---|---|
| `administer one time password settings` | `restrict access: true` | The settings form `one_time_password.settings` (`/admin/config/people/one_time_password/settings`) — i.e. toggling `force_otp`. |

This is the **only** module-defined permission.

## Route access summary

| Route | Path | Access |
|---|---|---|
| `one_time_password.setup_form` | `/user/{user}/two-factor-auth` | `_entity_access: user.update` on the target user (self, or admins who can edit that user). |
| `one_time_password.settings` | `/admin/config/people/one_time_password/settings` | `administer one time password settings`. |
| `one_time_password.entry` | `/otp/{uid}/{hash}` | anonymous-only (`_user_is_logged_in: FALSE`) + `EntryForm::checkAccess` custom access. |

## Enrolment authorization

Enabling or disabling one's own 2FA needs no dedicated permission — only `user.update` entity access on
the account. Consequently any role that can edit other users (e.g. *Administer users*) can enable, disable
or reset another account's 2FA; this is the intended admin-reset / lockout-recovery path, since there are
no self-service recovery codes.

## OTP entry access (`EntryForm::checkAccess`)

Reached only from the password-reset one-time-login hand-off. Grants access only when all hold:
private-tempstore `one_time_password:otp-entry-uid` equals the route `uid`; the user exists and has a
secret; and the route `hash` equals `getLoginHash($user)` (private-key HMAC of account state). Uses uids
rather than loaded user objects to avoid enumeration. Any mismatch → `AccessResult::forbidden`.

## Secret-field access

`hook_entity_field_access` forbids all operations on the `one_time_password` field for every account, so
the stored secret is not viewable/editable through the entity or REST APIs regardless of the caller's
permissions.
