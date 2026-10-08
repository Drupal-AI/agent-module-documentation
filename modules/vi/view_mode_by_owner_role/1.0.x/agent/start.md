<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# View mode by owner role (view_mode_by_owner_role) — agent index

**Alters a node's render view mode based on the node owner's role, via an admin role→view-mode map (Hux attribute hooks).**

- **Version:** 1.0.x — core `^9 || ^10 || ^11`; depends on `node`, `user`, `hux`.
- **Core logic:** `ChangeNodeViewMode` on `#[Alter('entity_view_mode')]` — swaps view mode using config `map_role_view_mode` (bundle → view mode → role → new view mode).
- **Constraint:** `EntityUser` adds `ViewModeByOwnerRoleUserRoleNumber` to the user entity + form validators so a user may hold at most one mapping role.
- **Routes (all `administer site configuration`):** choose-role, view-mode-settings, settings-map-role-view-mode under `/admin/config/system/view_mode_by_owner_role/…`. Permission `administer view_mode_by_owner_role configuration` (restrict access).
- **Security:** display-only — changes which view mode renders an already-accessible node; does **not** alter entity/field access or expose restricted content. Admin config gated. See [configure/mapping.md](configure/mapping.md).
