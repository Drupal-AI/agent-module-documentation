<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
The DonorPerfect base module connects Drupal to the DonorPerfect nonprofit CRM over its XML API, exposing DonorPerfect records as read/write Drupal entities and providing a query client plus reusable Name/Address/Email/Phone form elements.

---

DonorPerfect is a hosted fundraising CRM. This base module is the foundation of a five-module set (base + Donor, Gift, Contact and Other Info submodules). It talks to the DonorPerfect XML API endpoint (`https://www.donorperfect.net/prod/xmlrequest.asp`) using either an API key or a DonorPerfect username/password entered on the settings form. Rather than copying donor data into Drupal, records stay in DonorPerfect and are fetched on demand; only a *metadata* cache (field, code and multi-value definitions from DonorPerfect Screen Designer / Code Maintenance) is stored locally in Drupal config so that entity base fields, Views data and select-list options can be built. The module supplies a fluent `DPQuery` service that builds SELECT / INSERT / UPDATE / passthrough SQL and DonorPerfect predefined procedures (donorsearch, gifts, savedonor, savegift, savecontact, saveotherinfo, saveflag, delflags, saveudf), custom entity storage that routes entity queries through that client, a Views query backend, and Name/Address/Email/Phone render elements (the Name element AJAX-searches DonorPerfect and can auto-fill the others). It defines two permissions and a set of `hook_donorperfect_api_credentials_*_alter()` hooks so another module can override how credentials are loaded, validated and saved.

---

- Integrate a Drupal site with an existing DonorPerfect CRM account (XML API access required).
- Enter DonorPerfect XML API credentials (API key, or username + password) at `/admin/donorperfect/settings`.
- Build a local metadata cache of DonorPerfect fields, codes and multi-value fields via the "Refresh DonorPerfect cache" action.
- Choose exactly which DonorPerfect fields become Drupal entity base fields, per entity type, from the settings form.
- Expose donors, gifts, contacts and "other info" records as Drupal content entities without duplicating the data into Drupal's database.
- Display DonorPerfect data through Views (a custom Views query backend routes queries to the DonorPerfect API).
- Query DonorPerfect from custom code with the `donorperfect.dpquery` service using chained `create()->addField()->addCondition()->addOrder()->execute()` calls.
- Run DonorPerfect predefined procedures (e.g. `savedonor`, `savegift`, `savecontact`, `saveotherinfo`, `donorsearch`, `saveflag`) from custom modules.
- Execute custom passthrough SQL against the DonorPerfect database for reporting or bulk reads.
- Create or update DonorPerfect donor/gift/contact/other records from Drupal, tagging the change with the current Drupal user.
- Add a DonorPerfect donor-search field to a custom form using the `donorperfect_name` element, with AJAX match lookup.
- Auto-populate Address, Email and Phone elements when a user picks a matched donor.
- Reuse `donorperfect_address`, `donorperfect_email` and `donorperfect_phone` render elements with built-in DonorPerfect-style validation/formatting.
- Apply DonorPerfect field validation/filters (alpha-dash, email, phone, money, decimal, digit) to any form element via `#dp_validate` / `#dp_filter` keys.
- Configure "first name variations" so a search for "Bill" also matches "William", "Billy", etc.
- Restrict who can use the integration with the "Use DonorPerfect integration functionality" permission.
- Restrict who can change API credentials and entity field selection with the "Administer DonorPerfect integration" permission.
- Override credential storage (for example to source them from another module) via `hook_donorperfect_api_credentials_load_alter()`.
- Adjust default field values sent to DonorPerfect via `hook_donorperfect_field_defaults_alter()`.
- Look up DonorPerfect code descriptions and field option lists in custom code through the `donorperfect.dputility` service.
