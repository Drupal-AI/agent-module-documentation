<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Teamleader integrates Teamleader with Drupal.

---

Teamleader integrates **Teamleader** — a CRM/business-management platform — with Drupal via its API, with a
`teamleader_contact` submodule (contact sync). It provides its own permissions, in the Teamleader package.

Use it to connect Drupal with Teamleader (e.g. push contacts/leads). It is an integration/CRM feature. Security/
data handling: it authenticates to the **Teamleader API** (OAuth2) — store the **client credentials/tokens** as
**secrets** (env/Key), use HTTPS — and it sends **contact/customer data (PII)** to Teamleader (a data-egress/
privacy consideration; handle per your privacy policy). It has no access-control role beyond its permission.
Configure the Teamleader credentials.

---

- Integrate Teamleader CRM.
- Sync contacts/leads via the API.
- Provide a contact submodule.
- Authenticate via OAuth2.
- Store client credentials/tokens as secrets.
- Use HTTPS.
- Send contact/customer PII to Teamleader (egress/privacy).
- Handle data per privacy policy.
- Provide its own permissions.
- Have no access-control role beyond permission.
- Configure the Teamleader credentials.
- Handle Teamleader.
- Sync contacts.
- Configure the integration.
- Push leads.
- Handle the CRM.
- Connect to Teamleader.
- Secure the credentials.
- Configure credentials.
- Provide Teamleader integration.
