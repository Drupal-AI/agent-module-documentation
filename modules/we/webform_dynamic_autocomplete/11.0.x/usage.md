<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Webform Dynamic Autocomplete lets a Webform autocomplete field pull its suggestions live from an external JSON API instead of a fixed list: you set one endpoint URL and one query-parameter name in the module's settings, then attach the shipped "Dynamic Autocomplete" custom options to any autocomplete element, and each keystroke fetches matching options from that API.

---

Webform's autocomplete elements normally draw from a static, admin-defined option list. This module adds a webform_options entity, `autocomplete_dynamic` (label "Dynamic Autocomplete options", category "Dynamic Autocomplete"), that you pick under an autocomplete element's Custom options / "Select options" setting. When the element resolves its options, an implementation of `hook_webform_options_autocomplete_dynamic_alter()` reads the search term Webform passes as the `q` query argument, appends it to a site-wide endpoint URL under a configurable parameter name, does a `GET` with `file_get_contents()`, and returns the decoded JSON as the option list. Both the endpoint URL and the parameter name are set once for the whole site on the settings form at `/admin/config/webform_dynamic_autocomplete/settings` (permission `administer site configuration`; config object `webform_dynamic_autocomplete.settings`, keys `webform_dynamic_endpoint_url` and `webform_dynamic_query_parameter`). The API must return a JSON object of key/value (value/label) pairs; anything that is not a JSON array/object, or an unreachable endpoint, yields an empty option list. There is no element plugin, no config schema, no permissions, and no Drush — the whole module is one settings form, one options entity, and one alter hook.

---

- Populate a Webform autocomplete field from an external REST/JSON API.
- Show live suggestions from a product/SKU catalog as the user types.
- Look up customers or accounts from a CRM endpoint inside a form.
- Suggest cities, ZIP codes, or regions from a geo API.
- Autocomplete against a large dataset too big to store as static webform options.
- Drive suggestions from another application's search endpoint.
- Reuse one microservice's typeahead API across many webforms.
- Let suggestions change without editing the webform when the backend data changes.
- Point a form at a staging vs. production API by changing one setting.
- Autocomplete university/course/department names from an institutional API.
- Suggest support ticket categories fetched from a helpdesk service.
- Provide member or ID lookups from an internal directory service.
- Autocomplete tags or keywords from a taxonomy service outside Drupal.
- Populate options from a headless commerce backend.
- Suggest airport, station, or location codes from a travel API.
- Feed autocomplete from a search index (e.g. an external Solr/Elasticsearch HTTP endpoint that returns JSON).
- Keep a single source of truth for option data in an external system.
- Add typeahead to a webform without writing a custom element plugin.
- Swap the option source for every dynamic field by editing the endpoint URL once.
- Prototype a data-backed form quickly against a JSON test endpoint.
- Localize or filter suggestions server-side by having the API interpret the search term.
