<!-- SPDX-License-Identifier: LicenseRef-DXPR-Commercial -->
# Permissions (`dxpr_builder.permissions.yml`)

| Permission | Gates | restrict access |
|---|---|---|
| `edit with dxpr builder` | Lets a user build layouts / edit content with the DXPR Builder front-end editor. This is the per-editor permission; also relevant to license "billable user" counting. | TRUE |
| `administer dxpr builder configuration` | The DXPR Studio admin: settings form, AI settings, licensed-content and user-license pages, page-template creation, avow/disavow confirms. | TRUE |
| `administer dxpr_builder_profile` | Create/edit/delete `dxpr_builder_profile` config entities (the per-role allow-lists). Also the entity's `admin_permission`. | (not restricted) |

Notes:
- `edit with dxpr builder` grants front-end editing capability but does **not** grant the admin
  screens — those need `administer dxpr builder configuration`.
- The page-template and user-template collection/add/edit/delete routes require the core
  `administer site configuration` permission (see `dxpr_builder.routing.yml`), not a DXPR-specific one.
- Editor AJAX routes (`/dxpr_builder/ajax*`) are additionally gated by the
  `_dxpr_builder_billable_user` access check (valid license + billable user), on top of permissions.
