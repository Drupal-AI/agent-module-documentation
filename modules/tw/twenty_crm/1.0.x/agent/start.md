<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Twenty CRM Integration — agent index

**Twenty CRM API integration** (companies/contacts + autocomplete). Version **1.0.0**. Core `^9.5||^10||^11`.

Autocomplete routes: `/twenty-crm/autocomplete/company` and `/twenty-crm/autocomplete/person/{company_uuid}` return live CRM records. API key via a Key entity. Depends on `key`/`system`/`tagify`.