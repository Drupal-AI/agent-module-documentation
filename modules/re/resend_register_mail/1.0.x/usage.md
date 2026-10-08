<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Resend registration / welcome email gives admins two ways to send a user's account mail again: a bulk action on the People screen and a button on each user's edit form. It is the standard fix for "the welcome mail never arrived."

---

Drupal sends the registration mail once, when the account is created. If it bounces, lands in spam, or the account existed before mail was configured, core offers no built-in way to send it again. This module fills that gap. It registers a user Action (`resend_register_mail_action`) so operators can select users on `/admin/people`, choose the action, and land on a confirm form at `/admin/user/resend-email` where they pick the mail type — welcome for admin-created accounts, welcome for self-registration, the pending-approval message, or a password-recovery request — with a sensible default derived from the site's `user.settings.register` mode. It also adds a "Resend welcome message" / "Resend awaiting approval message" button to the user edit form via `hook_form_user_form_alter` for one-off resends. Both paths ultimately call core's `_user_mail_notify()` against the target account and skip accounts that have no email address. The module ships one permission (`resend account emails`), the enabling action config, and a config schema entry; it has no settings page and no Drush commands. Dependencies are core `user` only, and it requires core `^10.2 || ^11`.

---

- Re-send a welcome email that never arrived.
- Bulk re-invite a batch of imported users from the People screen.
- Recover from a period when the site could not send mail.
- Re-send activation mail after fixing SMTP.
- Onboard users migrated from another system.
- Trigger the welcome message for pre-created accounts.
- Send the pending-approval message again to an awaiting-approval account.
- Re-send to a single user via the button on their edit form.
- Choose which account mail type to resend on the confirm form.
- Re-send after correcting a user's email address.
- Re-invite users after a domain or hostname change.
- Reach users whose mail was quarantined.
- Handle onboarding for a cohort of new staff at once.
- Confirm the selected users before mail goes out.
- Delegate resending to a support role via the dedicated permission.
- Send a password-recovery request from the same confirm form.
- Default the mail type to match the site's registration mode.
- Skip accounts with no email automatically during a bulk resend.
- Combine with a mail-logging module to verify delivery.
- Reduce helpdesk tickets about missing invitations.
- Re-send the admin-created welcome mail to a specific account.
- Resend without resorting to a manual password reset.
