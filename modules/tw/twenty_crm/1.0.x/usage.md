<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Integrate with the Twenty CRM API for customer relationship management.

---

Twenty CRM Integration connects Drupal to the Twenty CRM API for customer relationship management — syncing/querying companies and people (contacts) from a Twenty CRM instance, with autocomplete widgets for selecting them in content.

The autocomplete routes `/twenty-crm/autocomplete/company` and `/twenty-crm/autocomplete/person/{company_uuid}` return live CRM records (company names/locations; person names, emails, job titles). The Twenty CRM API key is handled via a Key entity (`key` dependency, env-backed). Depends on `key`, core `system`, and `tagify`; supports Drupal 9.5+, 10, and 11.

---

- Integrate the Twenty CRM API.
- Sync/query companies and people.
- Provide autocomplete widgets.
- Select CRM records in content.
- Handle the API key via a Key entity.
- Depend on `key`, `system`, `tagify`.
- Support Drupal 9.5+, 10, and 11.
- Store credentials securely.
- Handle Twenty CRM.
- Manage contacts.
- Support Drupal.
- Support Drupal.
- Support Drupal.
