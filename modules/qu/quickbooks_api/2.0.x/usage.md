<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Quickbooks API connects to QuickBooks Online and makes the QuickBooks SDK classes available to other modules.

---

Quickbooks API connects Drupal to QuickBooks Online — handling the OAuth connection and exposing the
QuickBooks PHP SDK classes so other modules can read/write QuickBooks accounting data (invoices, customers,
payments). It is configured at `quickbooks_api.admin_settings_form`, provides its own permissions, in the
Accounting package.

Use it as the base for QuickBooks Online integrations. Security notes: QuickBooks uses OAuth 2.0 — **store the
client ID/secret and the OAuth refresh/access tokens as secrets** (Key entity / environment / secure token
store), operate over HTTPS, and grant the connected app the **minimum** QuickBooks scopes needed; accounting
data is sensitive (financial/PII), so protect it. It has no access-control role beyond its permission.
Configure the QuickBooks OAuth connection.

---

- Connect Drupal to QuickBooks Online.
- Expose the QuickBooks SDK to modules.
- Read/write accounting data.
- Configure at the admin settings form.
- Provide its own permissions.
- Store OAuth client ID/secret + tokens as secrets.
- Operate over HTTPS.
- Grant the connected app minimum scopes.
- Protect sensitive accounting/financial data.
- Have no access-control role beyond permission.
- Configure the QuickBooks connection.
- Handle QuickBooks OAuth.
- Sync accounting data.
- Configure credentials.
- Handle the SDK.
- Handle credentials securely.
- Integrate QuickBooks.
- Configure OAuth.
- Connect to QuickBooks.
- Handle accounting integration.
