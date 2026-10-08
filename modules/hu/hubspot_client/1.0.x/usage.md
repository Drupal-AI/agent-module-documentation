<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
HubSpot Client provides a HubSpot integration client.

---

HubSpot Client provides a **HubSpot integration client** — connecting Drupal to the HubSpot CRM to sync
contacts/data (with `commerce` and `sync` submodules for e-commerce and content syncing). It depends on the
HubSpot API module, in the Hubspot package.

Use it to integrate with HubSpot CRM. It is an integration/CRM feature. Security/data handling: it **sends data
(contacts, form submissions, orders — PII) to HubSpot** (external egress — disclose per privacy policy) and
authenticates with a **HubSpot API token/key** — store it as a **secret** (env/Key) over HTTPS. It has no
access-control role. Configure the HubSpot credentials and sync.

---

- Integrate with HubSpot CRM.
- Sync contacts/data to HubSpot.
- Provide commerce/sync submodules.
- Depend on the HubSpot API module.
- Serve CRM integration.
- Connect to HubSpot.
- Send PII (contacts/orders) to HubSpot (egress).
- Disclose it per privacy policy.
- Store the HubSpot token as a secret.
- Use HTTPS.
- Have no access-control role.
- Configure the credentials and sync.
- Handle HubSpot.
- Sync data.
- Configure the client.
- Send contacts.
- Handle the integration.
- Sync CRM.
- Secure the token.
- Provide HubSpot integration.
