<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# How det_node enforces per-domain content-type access

Every layer applies the same rule: load the content type's `det_node`/`domains` third-party
setting; if it is empty, or the user may bypass, do nothing extra; otherwise require the active
domain (`domain.negotiator->getActiveId()`) to be in that list, else deny/hide.

Bypass is `domain_entity_type.manager` → `bypassAccessCheck('node_type')`, i.e. the user holds
`bypass content type domain access check` (det_node) **or** `bypass all entity types domain access
check` (parent).

## Wiring: `det_node_entity_type_build()` + route subscriber

`det_node_entity_type_build(&$entity_types)` (`det_node.module`) replaces two handlers on the
`node_type` entity type:
- access handler → `Drupal\det_node\NodeTypeAccessOverride`
- list builder → `Drupal\det_node\NodeTypeListBuilderOverride`

`NodeRouteSubscriber::alterRoutes()` (`src/Routing/NodeRouteSubscriber.php`, service
`det_node.route_subscriber`):
- `node.add_page` → controller set to `NodeControllerOverride::addPage`.
- adds requirement `_det_node_access_check: 'TRUE'` to: `entity.node_type.delete_form`,
  `node.add`, `entity.node.edit_form`, `entity.node.delete_form`, `entity.node_type.edit_form`,
  `entity.node_type.entity_permissions_form`.

## Layer 1 — route access check (`NodeTypeDomainAccessCheck`)

Service `det_node.route_access_check` (`applies_to: _det_node_access_check`), args
`@domain.negotiator`, `@domain_entity_type.manager`, `@entity_type.manager`. `access()`:
1. bypass → `AccessResult::allowed()`.
2. If the route has a `node_type` param (a `NodeTypeInterface`): if its `domains` is non-empty and
   the active domain is not in it → `AccessResult::forbidden(...)`.
3. If the route has a `node` param (a `NodeInterface`): load its bundle's `node_type`, and apply
   the same check.
4. Otherwise → `AccessResult::allowed()`.

Because Drupal ANDs all route requirements, this check can only **further restrict** — it never
overrides the route's core `_entity_access` / `_permission` requirement.

## Layer 2 — access handler (`NodeTypeAccessOverride`)

Extends core `NodeTypeAccessControlHandler`. `checkAccess($entity, $operation, $account)`:
if `domains` empty **or** bypass → `parent::checkAccess()` (core decides); else if active domain
not in `domains` → `AccessResult::forbidden(...)`; else `parent::checkAccess()`. Purely additive
over core node_type access — it adds a domain constraint, it does not grant anything core denies.

## Layer 3 — content-types list (`NodeTypeListBuilderOverride`)

Extends core `NodeTypeListBuilder`. `buildRow($entity)` returns `[]` (an empty row) when the type
has non-empty `domains`, the active domain is not in them, and the user cannot bypass; otherwise
`parent::buildRow()`. Hides non-applicable content types from `/admin/structure/types`.

## Layer 4 — Add-content page (`NodeControllerOverride::addPage`)

Extends core `NodeController`; injects `domain.negotiator` and `domain_entity_type.manager` in
`create()`. `addPage()` calls `parent::addPage()`, then (unless empty or bypass) unsets each
`$build['#content']` node type whose non-empty `domains` does not include the active domain.
Removes non-applicable cards from `/node/add`.

## Permission

`det_node.permissions.yml` → `bypass content type domain access check` (title *"Bypass content
type domain access check"*). Grant only to trusted roles; not granted by default. Consumed by
`DomainEntityTypeManager::bypassAccessCheck('node_type')`.

## Scope / limits (design)

Enforcement covers content-type administration and node **add/edit/delete** routes only. The
route subscriber does **not** touch `entity.node.canonical` or REST/JSON:API resource routes, so
**viewing** published nodes (and API operations) of a restricted content type is not blocked by
det_node — the project README states the module does not manage content access; pair it with
Domain Access node grants or drupal/domain_entity for per-item content restriction.
