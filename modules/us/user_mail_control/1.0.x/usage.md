<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
User Mail Control lets a site allow user accounts without an email address by overriding the core UserMailRequired validation constraint.

---

User Mail Control replaces the core `UserMailRequired` validation constraint with `UserMailRequiredDisabled` (whose validator is a no-op when the value is empty), so user accounts can be created/saved without an email address. Settings in `user_mail_control.settings` (`user_form`, `user_register_form`, `mail_domain`, `automatic`) control whether the mail field is disabled on the account/registration forms and whether a default email is generated automatically (e.g. from a configured domain). It targets sites where users are managed internally and email is not needed or is synthesized. There is no admin route in this build; configuration is via the config object.

---

- Allow user accounts without an email address.
- Override the core email-required constraint.
- Skip validation when the mail field is empty.
- Disable the mail field on the account form.
- Disable the mail field on the registration form.
- Auto-generate a default email for new users.
- Build default emails from a configured domain.
- Manage internally-provisioned user accounts.
- Support headless/SSO users lacking email.
- Store behavior in user_mail_control.settings.
- Avoid patching core user validation.
- Keep email optional for bulk-created users.
- Depend only on the core user module.
- Apply the constraint override site-wide.
- Remove the mail requirement without custom code.
