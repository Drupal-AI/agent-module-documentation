<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Sendinblue API integrates Sendinblue (now Brevo) marketing tools via API v3, syncing contacts and providing signup forms and email/SMS marketing features.

---

Sendinblue API integrates Sendinblue (rebranded Brevo), an email/SMS marketing platform, with
Drupal via its API v3. It lets the site push contacts into Sendinblue lists, embed newsletter signup
forms, and connect Drupal to Sendinblue's transactional and marketing email features. Configuration
(at `sendinblue_api.config`) holds the Sendinblue API key and options; the module then talks to the
Sendinblue REST API to create/update contacts and manage list subscriptions, and can expose a signup
block.

Use it to grow and sync a marketing list from a Drupal site and to send campaigns through Sendinblue
rather than Drupal's own mail system. The API key authenticates all calls and should be stored as a
secret. Note the module's info file has a typo (`depencencies`) so its declared dependencies on
`block` and `rest` may not be enforced by Drupal's dependency resolver — ensure those are enabled if
needed. It provides permissions to administer the Sendinblue configuration. As with any marketing
integration, be mindful that contact data (emails, names) is transmitted to and stored by Sendinblue,
with the attendant consent/GDPR considerations.

---

- Integrate Sendinblue (Brevo) marketing with Drupal.
- Sync Drupal contacts into Sendinblue lists.
- Embed a newsletter signup form/block.
- Send campaigns through Sendinblue.
- Configure the Sendinblue API key.
- Store the API key as a secret.
- Create/update contacts via Sendinblue API v3.
- Manage list subscriptions from Drupal.
- Grow a marketing list from the site.
- Use Sendinblue transactional email.
- Administer Sendinblue settings via permission.
- Expose a signup block to visitors.
- Handle consent/GDPR for transmitted contacts.
- Connect to the Sendinblue REST API.
- Configure options at sendinblue_api.config.
- Note the info.yml 'depencencies' typo.
- Ensure block and rest are enabled if needed.
- Segment contacts into Sendinblue lists.
- Send SMS via Sendinblue where supported.
- Track marketing signups from Drupal.
