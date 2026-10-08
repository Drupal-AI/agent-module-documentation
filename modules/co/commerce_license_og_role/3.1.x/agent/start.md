<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce License Og Role (commerce_license_og_role) — agent index

**Commerce License type that grants an Organic Groups role/membership for the license's active period.**

- **Version:** 3.1.x (3.1.0)
- **Core:** ^10.1 || ^11
- **Depends:** og, commerce_license, dynamic_entity_reference
- **License type plugin:** `commerce_license_og_role` (`src/Plugin/Commerce/LicenseType/OgRole.php`) — implements ExistingRightsFromConfigurationChecking + GrantedEntityLocking; grants/revokes OG role+membership on activate/expire.
- **Event subscriber:** `OGPermissionsEventSubscriber` registers per-group OG permission `grant group roles with licenses` (default OG administrator, restrict access).
- **Permission (permissions.yml):** `grant group roles with licenses in any group` (restrict access: true).

**Security:** no routes or public endpoints — behaviour runs through the Commerce License lifecycle and OG membership API. Two restricted permissions gate who may configure license-driven role grants: a global `...in any group` (bypasses per-group control, marked restrict access) and a per-group OG permission defaulting to group administrators. Grant the global permission sparingly. No TLS/SQL/anon-endpoint concerns.

See [configure/commerce_license_og_role.md](configure/commerce_license_og_role.md)
