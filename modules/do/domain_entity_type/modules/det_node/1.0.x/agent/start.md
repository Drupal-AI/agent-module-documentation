<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Domain Content Type Access (det_node) — agent index

Default-enabled submodule of **domain_entity_type**. Adds per-domain restriction of **content types** (the `node_type` config entity) for the **Domain** (drupal/domain) module. Package `domain`. Version **1.0.0-rc2** (version dir `1.0.x`). Core `^9 || ^10 || ^11`. License GPL-2.0-or-later. Part of the `domain_entity_type` project (no separate composer package).

## Dependencies
- **domain:domain** and **domain_entity_type:domain_entity_type** (`det_node.info.yml`).
- Auto-enabled by `domain_entity_type_install()`; can also be enabled directly (`drush en det_node -y`).

## Data model
- Per-content-type domain assignment is stored as the **`det_node` / `domains`** third-party
  setting on each `node_type` config entity (an array of domain machine ids). Empty = all domains.
- No config schema is shipped (`provides_config_schema=false`).

## What it provides
- **Form**: `det_node_form_alter()` + `det_node_content_type_builder()` (`det_node.module`) add a
  *Domain access* checkboxes group to `node_type_add_form` / `node_type_edit_form` and save the
  selection. → [config/domain-assignment.md](config/domain-assignment.md)
- **Enforcement** (four layers) — `det_node_entity_type_build()` swaps the `node_type` access +
  list-builder classes; a route subscriber rewrites node/node_type routes:
  - `NodeTypeAccessOverride` (access handler for `node_type`)
  - `NodeTypeListBuilderOverride` (`buildRow`)
  - `NodeControllerOverride::addPage` (Add-content page)
  - `NodeTypeDomainAccessCheck` (route access check `_det_node_access_check`)
  - `NodeRouteSubscriber` (wires the above onto core routes)
  → [access/enforcement.md](access/enforcement.md)
- **Permission**: `bypass content type domain access check` (`det_node.permissions.yml`).
- **Services**: `det_node.route_subscriber` (event_subscriber) and `det_node.route_access_check`
  (access_check, `applies_to: _det_node_access_check`) — `det_node.services.yml`.

## Scope
Governs **content-type administration** and node **add/edit/delete** routes by domain. It does
**not** alter node canonical/view routes, so viewing published nodes is not domain-restricted by
this module (per the project README — content access is a separate concern; see drupal/domain_entity).

## Solution docs
- **Assign a content type to domains (form + third-party setting)** → [config/domain-assignment.md](config/domain-assignment.md)
- **How the four enforcement layers, routes, and permission work** → [access/enforcement.md](access/enforcement.md)
