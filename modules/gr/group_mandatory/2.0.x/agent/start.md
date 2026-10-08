<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Group Mandatory (group_mandatory) — agent index

**Marks a Group relationship (content) type as mandatory so its entities can only be created inside a Group, enforced by overriding the entity create-form route.**

- **Version:** 2.0.x · **Core:** ^8.8 || ^9 || ^10 || ^11
- **Depends on:** `group`, `route_override`
- **Setting:** third-party `group_mandatory:mandatory` on a group relationship type (added via `hook_form_alter` + entity builder)
- **Override:** service `group_mandatory.entity_form_controller_override` (tag `route_override`), class `GroupMandatoryRouteOverrideController`
- **Access:** `boolAccess()` grants only if the user has group entity-create access in ≥1 eligible group; cache context `user.group_permissions`
- **Build:** renders per-group create links, else "You must be member of a group to do this."
- **Test submodule:** `group_mandatory_test` (tests only, not documented)

**Security:** Enforcement is a server-side route access/override backed by Group's own access control handlers — non-members cannot reach the standalone create form for a mandatory bundle. No custom permissions or standalone endpoints introduced.

See [configure/mandatory.md](configure/mandatory.md).
