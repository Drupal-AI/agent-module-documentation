<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Mailchimp marketing integrates with the Mailchimp email service, syncing audiences/subscribers and enabling email marketing.

---

Mailchimp marketing integrates Drupal with the Mailchimp email-marketing platform — connecting to a
Mailchimp account to manage audiences, sync subscribers, and enable email marketing features (with a
`mailchimp_marketing_subscribe_ct` submodule for content-type-based subscription). It is configured at
`mailchimp_marketing.admin` and provides its own permissions.

Use it to grow and sync marketing audiences from Drupal. The security/privacy-relevant points: store the
Mailchimp API key as a secret (not plaintext config), and subscriber data (emails, names — personal data)
is transmitted to and stored by Mailchimp — obtain appropriate consent for adding subscribers, disclose the
data sharing, and handle it per GDPR. It is an integration/email-marketing feature with no access-control
role. Configure the Mailchimp connection and audiences.

---

- Integrate Mailchimp email marketing.
- Sync subscribers to Mailchimp.
- Manage Mailchimp audiences.
- Use the subscribe content-type submodule.
- Configure at mailchimp_marketing.admin.
- Provide its own permissions.
- Store the Mailchimp API key as a secret.
- Send subscriber data to Mailchimp.
- Obtain consent for subscribing.
- Disclose the data sharing (GDPR).
- Handle personal data appropriately.
- Grow marketing audiences.
- Have no access-control role.
- Sync signups.
- Enable email campaigns.
- Configure the connection.
- Handle credentials securely.
- Transmit PII to Mailchimp.
- Manage audiences.
- Integrate email marketing.
