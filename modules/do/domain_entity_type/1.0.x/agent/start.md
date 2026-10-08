<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Domain Access Entity Type (domain_entity_type) — agent index

Framework for the **Domain** (drupal/domain) module that scopes entity-type administration/use per domain. The base module is thin: one service + one permission. The real behavior ships in the **det_node** submodule (auto-installed), which restricts content types per domain. Package `domain`. Version **1.0.0-rc2** (version dir `1.0.x`). Core `^9 || ^10 || ^11`. License GPL-2.0-or-later. No composer.json (drupal.org project only).

## Dependencies
- **domain:domain** — required (`.info.yml`). Uses `domain.negotiator` and the `domain` config entity storage.
- Auto-installs **det_node** on install (`domain_entity_type_install()` in `domain_entity_type.install`).

## What the base module actually provides
- **Service `domain_entity_type.manager`** → `Drupal\domain_entity_type\Services\DomainEntityTypeManager` (implements `DomainEntityTypeManagerInterface`), arg `@current_user`. Its only method `bypassAccessCheck($entity_type = '')` returns TRUE when the user holds `bypass all entity types domain access check`, or (for `$entity_type === 'node_type'`) `bypass content type domain access check`; otherwise FALSE. See [api/manager.md](api/manager.md).
- **Permission** `bypass all entity types domain access check` (`domain_entity_type.permissions.yml`).
- **No routes, no config schema, no config/install, no plugins, no Drush, no hooks** in the base module. `provides_config_schema=false`.

## Submodule (documented separately)
- **det_node** — *Domain Content Type Access*. Adds the per-content-type domain assignment UI + all node/node_type route and access-handler restrictions. Documented in its own tree: `modules/do/domain_entity_type/modules/det_node/1.0.x/`.

## Solution docs
- **Install, the manager service, the permission, extending the framework** → [api/manager.md](api/manager.md)
