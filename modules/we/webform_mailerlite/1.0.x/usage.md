<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Webform MailerLite handler provides a MailerLite webform handler and service, sending webform submissions to MailerLite.

---

Webform MailerLite handler provides a Webform handler (and a related service) that sends webform
submissions to MailerLite — the email-marketing platform — so form submissions (e.g. a newsletter signup)
add/update subscribers in MailerLite. It depends on the Webform module.

Use it to connect webform submissions to MailerLite lists. The security/privacy-relevant points: the
MailerLite API credentials should be stored as secrets (not plaintext config), and submission data
(names, emails — personal data) is transmitted to MailerLite — obtain appropriate consent for adding
subscribers and disclose the data sharing (GDPR). It is an integration/email-marketing feature with no
access-control role. Configure the handler on the webform with the MailerLite API key and target list.

---

- Send webform submissions to MailerLite.
- Add/update MailerLite subscribers.
- Connect signups to MailerLite lists.
- Depend on the Webform module.
- Store the MailerLite API key as a secret.
- Send submission data to MailerLite.
- Obtain consent for subscribing.
- Disclose the data sharing (GDPR).
- Have no access-control role.
- Configure the handler on a webform.
- Set the target MailerLite list.
- Handle newsletter signups.
- Transmit personal data to MailerLite.
- Handle credentials securely.
- Add subscribers on submit.
- Integrate email marketing.
- Configure the MailerLite connection.
- Map submission to subscriber.
- Sync signups to MailerLite.
- Send to email marketing.
