<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Sends core contact-form submissions to ActiveCampaign with field mapping.

---

Contact ActiveCampaign allows a user to send form submissions created by the core Contact module to ActiveCampaign — fields added to the contact form can be manually mapped to fields created in ActiveCampaign, so contact submissions become ActiveCampaign contacts/records for marketing automation.

The ActiveCampaign account URL and API token are configured in the separate `activecampaign_api` module (on its ActiveCampaign API account form); this module only selects one of those accounts. Depends on core `contact` and `activecampaign_api`; supports Drupal 11. Submissions are sent asynchronously on cron.

---

- Send contact submissions to ActiveCampaign.
- Use the core Contact module.
- Map contact-form fields to ActiveCampaign fields.
- Create or update ActiveCampaign contacts.
- Manage ActiveCampaign list subscriptions and tags.
- Support marketing automation.
- Send data asynchronously via a cron queue.
- Depend on core `contact` and `activecampaign_api`.
- Support Drupal 11.
- Configure field mapping per contact form and per account.
- Sync submissions.
- Aid marketing.
- Integrate ActiveCampaign
- Handle contact forms
- Support Drupal.
