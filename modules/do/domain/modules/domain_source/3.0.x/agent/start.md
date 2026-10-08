<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Domain Source — agent index

Part of **[domain](../../../../3.0.x/agent/start.md)**. Rewrites a content item's outbound
URLs to its canonical **source domain** instead of the active domain.

Key facts:
- Field (added to `node`): `field_domain_source` (entity-reference → `domain`,
  cardinality 1). Constant `DomainSourceElementManagerInterface::DOMAIN_SOURCE_FIELD`.
- An outbound `path_processor` rewrites links for content with a source domain; integrates
  with `path_alias`.
- Service `domain_source.helper` (`DomainSourceHelperInterface`):
  `getSourceDomain($entity)`, `getSourceDomainId($entity)`, `confirmFields($type, $bundle)`.
- Config `domain_source.settings` at `/admin/config/domain/domain_source`
  (route `domain_source.settings`, perm `administer domains`); key `exclude_routes`
  (default empty) skips URL rewriting for named routes.
- Alter hooks: `hook_domain_source_alter`, `hook_domain_source_path_alter`,
  `hook_domain_source_excluded_paths_alter`, `hook_domain_source_excluded_route_names_alter`,
  `hook_domain_source_exclude_routes_options_alter`.
- Typically paired with `domain_access`: content shared to many domains, one canonical URL.
