<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Domain Access — agent index

Part of **[domain](../../../../3.0.x/agent/start.md)**. Adds per-domain access control
for content and users.

Key facts:
- Fields (added to `node` and `user`): `field_domain_access` (entity-reference → `domain`,
  cardinality -1, the assigned domains) and `field_domain_all_affiliates` (boolean,
  "publish to all domains"). Constants `DomainAccessManagerInterface::DOMAIN_ACCESS_FIELD`
  and `::DOMAIN_ACCESS_ALL_FIELD`.
- Service `domain_access.manager` (`DomainAccessManagerInterface`):
  `checkEntityAccess()`, `hasDomainPermissions()`, `getContentUrls()`.
- Config `domain_access.settings` at `/admin/config/domain/domain_access`
  (route `domain_access.settings`, perm `administer domains`). Keys:
  `node_advanced_tab` (default true), `node_advanced_tab_open` (false),
  `access_fields_removal` (false), `per_bundle_grants` (false).
- Per-domain editor permissions (not site-wide): `create/edit/delete domain content`,
  `view unpublished domain content`, `publish to any domain`,
  `publish to any assigned domain`, `assign domain editors`,
  `assign editors to any domain`, plus per-bundle `create/update/delete <type> content on
  assigned domains`.
- Enforces node access grants by active domain + the user's assigned domains.
- Ships a `domain_access` condition plugin and "assign/remove to all affiliates" actions.
