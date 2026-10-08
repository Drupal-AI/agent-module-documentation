<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Zoho CRM Integration uses the Zoho PHP SDK to provide integration with the Zoho CRM REST API.

---

Zoho CRM Integration connects Drupal to the Zoho CRM REST API — using the Zoho PHP SDK to push/pull CRM
data (e.g. sending Webform submissions as leads/contacts to Zoho CRM). It ships a
`zoho_crm_integration_webform_handler` submodule (Webform handler), is configured at
`zoho_crm_integration.settings`, and provides its own permissions, in the Third-party Integration package.

Use it to integrate Drupal data with Zoho CRM. Security notes: Zoho uses OAuth — **store the OAuth
client ID/secret and refresh/access tokens as secrets** (Key entity / environment variable / the SDK's
secure token store), not in exported config; operate over HTTPS; and be mindful that data sent to Zoho
(lead/contact PII from forms) is a privacy/data-handling consideration. It has no access-control role beyond
its permission. Configure the Zoho OAuth credentials and mappings.

---

- Integrate with the Zoho CRM REST API.
- Use the Zoho PHP SDK.
- Push Webform submissions to Zoho.
- Send leads/contacts to Zoho CRM.
- Ship a Webform handler submodule.
- Provide its own permissions.
- Store Zoho OAuth credentials/tokens as secrets.
- Avoid credentials in exported config.
- Operate over HTTPS.
- Mind PII sent to Zoho.
- Have no access-control role beyond permission.
- Configure at zoho_crm_integration.settings.
- Map Drupal data to Zoho.
- Handle OAuth securely.
- Configure the Zoho connection.
- Sync CRM data.
- Integrate Zoho CRM.
- Send form data to CRM.
- Configure the mappings.
- Connect to Zoho.
