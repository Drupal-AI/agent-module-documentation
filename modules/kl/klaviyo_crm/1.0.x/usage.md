<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Klaviyo CRM integrates Drupal with the Klaviyo marketing/CRM platform (via forms/webforms).

---

Klaviyo CRM **integrates Drupal with the Klaviyo platform** — syncing contacts/events (e.g. from Webform
submissions) to Klaviyo (email/SMS marketing CRM) and providing blocks for Klaviyo forms. It depends on core Block
and the Webform module, and provides its own permissions, in the Email Marketing package.

Use it to feed data into Klaviyo. It is an integration/marketing feature. Security/data handling: it **sends
contact/subscriber data (PII) and events to the Klaviyo API** (external egress — disclose per your privacy policy)
and authenticates with a **Klaviyo API key** (store as a secret — env/Key — over HTTPS; do not commit it). It has
no access-control role beyond its permission. Configure the Klaviyo credentials.

---

- Integrate the Klaviyo platform.
- Sync contacts/events (e.g. from Webform).
- Provide Klaviyo form blocks.
- Depend on core Block + Webform.
- Provide its own permissions.
- Serve marketing integration.
- Send contact PII + events to Klaviyo (egress; disclose).
- Store the Klaviyo API key as a secret (env/Key, HTTPS).
- Not commit the key.
- Have no access-control role beyond permission.
- Configure the Klaviyo credentials.
- Handle Klaviyo.
- Sync contacts.
- Configure the client.
- Send events.
- Handle the integration.
- Feed the CRM.
- Manage marketing.
- Secure the key.
- Provide Klaviyo integration.
