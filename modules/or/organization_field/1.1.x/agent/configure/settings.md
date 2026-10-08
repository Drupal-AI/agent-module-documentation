<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings

`/admin/config/content/organization_field` (perm `administer organization_field configuration`).

- `ror_api` — the ROR REST API base URL used by autocomplete.
- `ror_items_depth` — cap on number of autocomplete results.
- Field type `organization_field` stores name, URLs (comma-separated) and a ROR ID URL; choose the default or configurable formatter on the display.
- Uninstall: use `/admin/modules/uninstall/entity/organization_field` (perm `administer organization_field`) to remove all fields before uninstalling.
