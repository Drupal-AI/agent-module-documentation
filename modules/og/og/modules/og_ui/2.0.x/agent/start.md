<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Organic Groups UI (og_ui) — agent index

Admin UI for `og`. No entities, no services beyond one form-alter helper, **no permissions of
its own** — every route requires `og`'s `administer organic groups`.
`configure: og_ui.admin_index`.

- **Routes, the bundle-form "Organic groups" tab and the settings form** →
  [configure/admin-screens.md](configure/admin-screens.md)
- **The OG roles & permissions screens and what they write** →
  [permissions/roles-and-permissions.md](permissions/roles-and-permissions.md)

Fast facts:
- `/admin/config/group` (`og_ui.admin_index`) — admin index.
- `/admin/config/group/settings` (`og_ui.settings`) — edits `og.settings`.
- `/admin/config/group/{roles|permissions}` (`og_ui.roles_permissions_overview`).
- `/admin/config/group/permissions/{entity_type_id}/{bundle_id}` — permission matrix.
- `/admin/config/group/permissions/{entity_type_id}/{bundle_id}/{role_name}` — one role.
- Bundle forms gain a details element `og` with
  `og_is_group`, `og_membership_type`, `og_group_content_bundle`, `og_target_type`,
  `og_target_bundles`; `og_ui_entity_insert()/update()` turn them into `Og::` API calls.
- The `OgRole` add/edit/delete **forms** live here, but their **routes** (`entity.og_role.*`)
  are declared in `og.routing.yml`.
- Membership types (`/admin/structure/membership-types`) and the per-group member admin pages
  belong to `og`, not `og_ui`.
