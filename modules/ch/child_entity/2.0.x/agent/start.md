<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Child Entity (child_entity) — agent index
**Developer trait + route/access/permission scaffolding for content entities owned by a parent entity.**

- **Version:** 2.0.x
- **Core:** ^8.8 || ^9 || ^10 || ^11
- **Depends:** entity:entity
- **Key classes:** `ChildEntityTrait`, `ChildEntityInterface`, `ChildEntityAccessControlHandler`, `ChildContentEntityHtmlRouteProvider`, `ChildEntityController`, `ChildEntityPermissions`, `ChildEntityRouteContext` (context provider `child_entity.child_entity_route_context`).
- **Permissions:** dynamic per-type / per-bundle create/edit/delete (+revision) via `permission_callbacks`.
- Developer library: no shipped entity types, routes, or admin UI of its own.

**Security:** Child access AND-combines with parent access (inheritance). Two things to verify per site: (1) `ChildEntityAccessControlHandler::checkCreateAccess()` returns `AccessResult::allowed()` for any HTML request, bypassing the module's own create permission and parent access; (2) `checkAccess()` gates edit/delete solely on parent access + published status — the generated per-bundle create/edit/delete permissions are not enforced there. See [api/model.md](api/model.md).
