<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Mail Debugger sends a test email from the site so a developer can confirm that mail actually leaves — the fastest way to tell a broken transport configuration apart from a broken template.

---

"The site isn't sending email" has several possible causes — transport misconfiguration, a mail module intercepting messages, DNS or SPF problems, a template throwing — and separating them means sending something minimal and watching what happens. This module provides exactly that. A form at `/admin/config/development/mail_debugger` takes a recipient, subject and body and sends it, and a second at `.../mail_debugger/user` re-sends a core account-notification mail (password reset, account activation, cancellation, and so on) to a chosen site user, exercising the real user-mail path. Both go through Drupal's mail manager, so whatever transport and mail-altering modules the site has configured are in play — which is the point. The custom form remembers the last message between visits (stored in a key-value collection), and the user form remembers the last user and operation per person (private tempstore). There are no dependencies beyond core, the module is packaged as a development tool, and the core range is a wide `^8 || ^9 || ^10 || ^11`.

---

- Check whether the site can send email at all.
- Test a transport (SMTP) configuration after changing it.
- Separate a transport problem from a template problem.
- Send a test message to a specific address.
- Exercise the account-mail path for a chosen user.
- Re-send a password-reset mail to a test user to check its formatting.
- Verify mail after a server migration.
- Confirm a mail-catching tool (Mailpit, MailHog) is receiving.
- Check SPF or DKIM alignment with a real send.
- Test mail from a staging environment.
- Reproduce a delivery failure.
- Confirm a mail-altering module is intercepting correctly.
- Check formatting of a mail template.
- Verify mail works before enabling notifications.
- Diagnose a bounced message.
- Test mail from a container without shell access.
- Confirm a queue-based mailer is draining.
- Check mail after a DNS change.
- Validate a mail-provider integration.
- Preview which core account-notification templates are configured (the operation list is built from `user.mail`).
