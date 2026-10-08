<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Disable Account Emails (disable_account_emails) — agent index

Small utility that lets admins suppress specific automated **user-account** emails from Drupal core's `user` module. No routes, permissions, services, or plugins of its own.

- **Requires:** Drupal core `^11`, PHP `>= 8.1`. No composer dependencies, no dependent modules, no libraries.
- **Package:** Mail. **Config schema:** yes. **Permissions/Drush/Plugins:** none.

## How it works (files)
- `disable_account_emails.module`
  - `hook_form_FORM_ID_alter()` on `user_admin_settings` — adds a "Disable Account Emails" `details` fieldset (weight 100) with one checkbox per email type, plus a custom submit handler `disable_account_emails_settings_submit()`.
  - `hook_mail_alter()` — for messages where `$message['module'] === 'user'`, if `disabled_emails[$key]` is truthy in config, sets `$message['send'] = FALSE`.
  - `_disable_account_emails_get_email_types()` — the canonical list of nine supported `user` mail keys.
  - `hook_help()` for `help.page.disable_account_emails`.
- `disable_account_emails.install` — `hook_uninstall()` deletes the settings config.
- `config/install/disable_account_emails.settings.yml` + `config/schema/disable_account_emails.schema.yml` — the `disable_account_emails.settings` config object (all keys default `false`).

## Where it lives in the UI
The checkboxes render on the **core** Account settings form (`/admin/config/people/accounts`, route `entity.user.admin_form`); there is no dedicated settings route. Access is whatever core grants that form ("Administer account settings" permission).

## Solution docs
- Configuration & operation: [`agent/config/settings.md`](config/settings.md)
