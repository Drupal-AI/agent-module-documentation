<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Zoho CRM Integration — agent index

Integrates Drupal with the **Zoho CRM REST API** (Zoho PHP SDK — push/pull CRM data, e.g. Webform
submissions → leads/contacts). `..._webform_handler` submodule. Config at `zoho_crm_integration.settings`;
provides permissions. Version **8.x-1.0-beta5**. Core `^10.5||^11`.

**Security:** Zoho uses OAuth — store client ID/secret + tokens as **secrets** (Key/env/SDK store), not
exported config; HTTPS; PII sent to Zoho (data-handling). No access role beyond permission.
