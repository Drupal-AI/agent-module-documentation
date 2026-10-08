<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Multiple Email Addresses

## Permissions
- `administer multiple emails` (restricted) — access the settings form.
- `use multiple emails` — use the personal email-management tab.

## Settings
Route `multiple_email.admin.settings` → `/admin/config/people/multiple-email`.
Controls confirmation email templates (subject/body, tokens), code expiry, and whether the
core email field is hidden on the account edit form.

## Routes / flow (entity `multiple_email`)
- Manage: `/user/{user}/edit/email-addresses` (`ManageForm`, access check `_access_multiple_email_personal_tab`).
- Confirm: `/multiple-email/confirm/{multiple_email}` and `/multiple-email/user/{user}/confirm/{multiple_email}/code/{code}`.
- Set primary: `/multiple-email/set-primary/{multiple_email}`.
- Resend: `/multiple-email/resend/{multiple_email}`; Cancel: `/multiple-email/cancel-confirmation/{multiple_email}`; Remove: `/multiple-email/remove/{multiple_email}`.
All are `_entity_access`-gated (`confirm`, `set_primary`, `resend_confirmation`, `cancel`, `remove`).

## Hooks
`hook_multiple_email_register($email)`, `hook_multiple_email_confirm($email)`, `hook_multiple_email_delete($eid)`.

## Confirmation codes
`EmailConfirmer::generateCode()` uses `\Random\Randomizer::getBytesFromString()` (secure engine).
