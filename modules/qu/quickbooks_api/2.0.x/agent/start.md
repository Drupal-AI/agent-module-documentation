<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Quickbooks API — agent index

Connects to **QuickBooks Online** and exposes the QuickBooks SDK to other modules (invoices/customers/
payments). Config at `quickbooks_api.admin_settings_form`; provides permissions. Version **2.0.0-rc5**. Core
`^10.4||^11`.

**Security:** QuickBooks uses OAuth 2.0 — store client ID/secret + refresh/access **tokens as secrets** (Key/
env/secure store); HTTPS; **minimum** scopes; accounting data is sensitive (financial/PII). No access role
beyond permission.
