<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Organization Field stores information associated with an organization as found in the Research Organization Registry (ROR).

---

It provides a field type (`OrganizationFieldItem`) holding an organization name, one or more URLs and a ROR ID URL, an autocomplete widget (`OrganizationFieldWidget`) and two display formatters (a simple default and a configurable one). As the author types, the widget calls the module's own autocomplete controller (`/autocomplete/organization_field`), which queries the ROR REST API (URL set at `/admin/config/content/organization_field`) and returns matching organization names; when a name is not in ROR the user can enter details manually. An uninstall validator and a dedicated field-deletion form ensure fields are cleaned up before the module is removed.

The autocomplete route (`JsonApiController::handleAutocomplete`, `src/Controller/JsonApiController.php`) is declared with `_access: 'TRUE'`. It XSS-filters the `q` parameter and issues a server-side GET to the ROR API URL taken from module config. Admin settings and the uninstall form are protected by `administer organization_field configuration` / `administer organization_field` (both `restrict access: true`). Typical setup: add the field to a content type, set the ROR API endpoint and result depth, and choose a formatter.

---
- Add an organization/affiliation field to content
- Autocomplete organization names from the ROR registry
- Store a ROR identifier URL for an organization
- Record multiple organization URLs (comma-separated)
- Enter organization data manually when not in ROR
- Configure the ROR API endpoint used for lookups
- Limit the number of autocomplete results shown
- Display an organization with a link to its site
- Display a link to the organization's ROR record
- Choose between default and configurable formatters
- Customize labels (name, links, identifier) in the formatter
- Control how many URLs are shown and how they open
- Tag research outputs with their affiliated institutions
- Build an author-affiliation field for a journal site
- Clean up all organization fields before uninstalling
- Restrict who can configure the module via dedicated permissions
