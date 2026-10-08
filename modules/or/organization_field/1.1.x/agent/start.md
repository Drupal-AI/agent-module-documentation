<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Organization Field (organization_field) — agent index

**Field type + ROR-autocomplete widget + formatters for storing research-organization (ROR) data.**

- **Version:** 1.1.x (1.1.0-beta1)
- **Core:** ^10 || ^11
- **Configure:** `/admin/config/content/organization_field` (perm `administer organization_field configuration`)
- **Permissions:** `administer organization_field configuration`, `administer organization_field` (both restrict access).
- **Routes:** `organization_field.autocomplete` `/autocomplete/organization_field` — **`_access: 'TRUE'` (anonymous)**; admin settings + uninstall form are permission-gated.
- **Field plugins:** `OrganizationFieldItem`, `OrganizationFieldWidget`, `OrganizationFieldDefaultFormatter`, `ConfigurableOrganizationFieldFormatter`.

**Autocomplete:** Xss-filters `q` and calls the admin-configured ROR API URL. See [api/autocomplete.md](api/autocomplete.md) and [configure/settings.md](configure/settings.md)
