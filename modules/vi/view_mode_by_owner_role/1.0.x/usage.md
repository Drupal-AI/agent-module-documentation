<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
View mode by owner role changes which view mode a node is rendered in based on the role held by that node's owner (author), driven by an admin-defined role-to-view-mode map.
---
The module hooks `entity_view_mode` alter (via the Hux attribute-hook library) in `ChangeNodeViewMode`: for `node` entities it looks up the configured `map_role_view_mode` structure keyed by bundle → original view mode → owner role → replacement view mode. It loads the node's owner, intersects the owner's roles with the mapped roles, and if a match exists swaps the requested view mode for the mapped one. Because a mapping is per single role, a companion constraint/validator (`ViewModeByOwnerRoleUserRoleNumber`, added to the user entity and enforced on the user add/edit forms) blocks assigning a user more than one of the "chosen" mapping roles, keeping the lookup unambiguous.

Configuration is a three-step admin flow, all gated by `administer site configuration`: choose which roles participate (`/admin/config/system/view_mode_by_owner_role/view-mode-settings-choose-role`), choose which bundle view modes are eligible to be replaced (`.../view-mode-settings`), then map role → replacement view mode per bundle/view mode (`.../settings-map-role-view-mode`). A `restrict access`-flagged permission `administer view_mode_by_owner_role configuration` is also declared.

This module only alters *presentation* (which display/view mode is used) — it does not grant or revoke access to content or fields, so it cannot expose restricted data; it simply renders an existing, already-accessible node through a different, already-configured display.

---

- Render a node in a different view mode based on its author's role
- Map an owner role to a replacement view mode per bundle
- Show premium-author articles in an enhanced display automatically
- Choose which roles participate in view-mode mapping
- Choose which bundle view modes are eligible for replacement
- Define role → replacement view mode mappings per bundle/view mode
- Enforce that a user holds at most one mapping role via a constraint
- Block assigning two chosen roles on the user add/edit form
- Differentiate node presentation for staff vs external authors
- Swap the teaser or full view mode for owner-role-specific displays
- Keep access unchanged while varying only presentation
- Configure everything from /admin/config/system/view_mode_by_owner_role
- Restrict configuration to the administer site configuration permission
- Apply owner-role display logic only to node entities
- Leave unmapped bundles/view modes rendering normally
- Use Hux attribute hooks to alter the entity view mode at render time
