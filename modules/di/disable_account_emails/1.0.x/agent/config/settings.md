<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring and operating Disable Account Emails

## Install / enable
```bash
composer require drupal/disable_account_emails   # no composer.json ships; core ^11, PHP >= 8.1
drush en disable_account_emails -y
```
No dependencies beyond core. Enabling installs `config/install/disable_account_emails.settings.yml` (all nine keys default `false` = nothing suppressed).

## Config object
`disable_account_emails.settings` (schema type `config_object`, defined in `config/schema/disable_account_emails.schema.yml`). Single mapping `disabled_emails` with nine boolean keys — `true` means "do not send this email":

| Config key | Checkbox label / meaning | Core `user` mail key |
|---|---|---|
| `register_admin_created` | Welcome (new user created by admin) | `register_admin_created` |
| `register_pending_approval` | Welcome (awaiting approval) | `register_pending_approval` |
| `register_pending_approval_admin` | Admin notification (user awaiting approval) | `register_pending_approval_admin` |
| `register_no_approval_required` | Welcome (no approval required) | `register_no_approval_required` |
| `register_activate` | Account activation | `register_activate` |
| `status_blocked` | Account blocked | `status_blocked` |
| `cancel_confirm` | Account cancellation confirmation | `cancel_confirm` |
| `status_deleted` | Account deleted | `status_deleted` |
| `password_reset` | Password recovery | `password_reset` |

The config keys are exactly the core `user`-module mail keys, so the lookup in `hook_mail_alter()` is a direct `$disabled_emails[$message['key']]` match.

## UI
There is no dedicated route. The checkboxes are injected by `disable_account_emails_form_user_admin_settings_alter()` into the core **Account settings** form:
- Route: `entity.user.admin_form` — path `/admin/config/people/accounts`.
- A `details` fieldset titled "Disable Account Emails" (`#open => TRUE`, `#weight => 100`) sits below the main Emails settings.
- Each checkbox uses `#parents => ['disable_account_emails', $key]`, so values arrive under one `disable_account_emails` array in form state.
- Access is governed entirely by core's account-settings form (the "Administer account settings" permission); the module adds no access check of its own.

## Save path
The module appends `disable_account_emails_settings_submit()` to the form's `#submit` array. It reads `$form_state->getValue('disable_account_emails')`, normalizes every one of the nine keys to a strict `TRUE`/`FALSE`, and writes them back via `\Drupal::configFactory()->getEditable('disable_account_emails.settings')->set('disabled_emails', ...)->save()`. Missing/absent values default to `FALSE` (email allowed).

## Suppression logic
`disable_account_emails_mail_alter(&$message)`:
1. Returns early unless `$message['module'] === 'user'` (only core user mail is affected; contact/node/contrib mail is untouched).
2. Reads `disabled_emails` from `disable_account_emails.settings`.
3. If `!empty($disabled_emails[$message['key']])`, sets `$message['send'] = FALSE`. Drupal still builds the message but the mail manager does not deliver it.

## Editing config directly / via Drush
```bash
drush config:set disable_account_emails.settings disabled_emails.password_reset true -y
drush config:get disable_account_emails.settings
```
Exports/imports cleanly as configuration for cross-environment deployment.

## Uninstall
`hook_uninstall()` (`disable_account_emails.install`) deletes `disable_account_emails.settings` — no residual config remains.

## Operational notes
- Changes take effect on the next mail send; if emails still go out, clear caches (`drush cr`) and confirm the intended box is checked.
- Only the nine listed keys are recognized; other `user` mail keys (or emails from other modules) are never suppressed.
