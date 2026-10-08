<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Site Verification — agent index

Manages **`site_verification`** config entities so a site can prove domain ownership to
search engines, either via a **meta tag** injected on the front page only, or a **file**
served (dynamically, no real file needed) at a path matching the verification's name. Admin
UI at `/admin/config/search/verifications` (`configure` route
`entity.site_verification.collection`). No plugins, no Drush commands.

- **Add/edit/enable/disable verifications, understand `type: meta` vs `type: file`, routes,
  and the config entity's exported fields** → [configure/verifications.md](configure/verifications.md)
- **Permission gating (`administer site verify` vs `manage file based site verifications`)** →
  [permissions/permissions.md](permissions/permissions.md)
- **Entity API methods, route rebuilding on save/delete, dynamic file route generation, the
  front-page meta-tag hook, and the unique-filename validation constraint** →
  [api/entity-api.md](api/entity-api.md)

Key facts:
- Entity type id `site_verification`; config prefix `site_verification`, so instances export
  as `site_verify.site_verification.<id>.yml`.
- `type` is the PHP enum `SiteVerificationType` (`meta` | `file`) — not a separate config
  entity or plugin type.
- Only `status: true` verifications are attached/served; meta tags render only on the front
  page; file routes are rebuilt automatically on entity save/delete.
