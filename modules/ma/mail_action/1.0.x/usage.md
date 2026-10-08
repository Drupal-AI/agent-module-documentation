<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Mail Action provides action plugins for sending mails with formatted text.

---

Mail Action provides **action plugins for sending emails with formatted text** — reusable actions (usable
from Views Bulk Operations, ECA, rules-style flows) that send a formatted email, e.g. to notify users in bulk.
It is in the Mail package.

Use it to send emails as an action in bulk/automated flows. It is an automation/mail feature. **Security
caveat:** an action that **sends email to users** is a powerful capability — if exposed via Views Bulk
Operations it can mass-email recipients, so **gate the action/VBO to trusted roles** (an untrusted user with
the action could spam users or use the site as a mail relay), and keep the email content trusted (formatted
text is admin-authored). It has no access-control role of its own. Configure and restrict the mail action.

---

- Send emails via an action plugin.
- Send formatted-text mail.
- Work with VBO/ECA/bulk flows.
- Notify users in bulk.
- Serve automation/mail.
- Send templated email.
- GATE the action to trusted roles.
- Avoid mass-email/relay abuse.
- Keep email content trusted.
- Have no access-control role of its own.
- Configure and restrict the action.
- Handle mail actions.
- Send emails.
- Configure the action.
- Mail users.
- Handle the action.
- Send notifications.
- Bulk-email users.
- Restrict the action.
- Provide mail actions.
