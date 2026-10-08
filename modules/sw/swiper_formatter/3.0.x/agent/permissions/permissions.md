<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions

`swiper_formatter.permissions.yml` defines a single permission:

| Permission | Machine name | Gates |
|---|---|---|
| Administer Swiper formatter | `administer swiper_formatter` | managing Swiper template config entities — this is the entity type's `admin_permission`, so it controls create/edit/delete/duplicate at `/admin/config/content/swiper-formatter` and all `entity.swiper_formatter.*` routes. |

Notes:
- The dialog route `swiper_formatter.dialog` uses `_permission: 'access content'`, not this
  permission — front-end modal viewing only needs `access content`.
- Formatter/style code additionally checks `hasPermission('administer swiper')` (a different
  string, **not** defined by this module) to decide whether to expose an in-place admin-access
  affordance; because that permission is undefined, only User 1 / full admins satisfy it. The
  real, grantable permission is `administer swiper_formatter`.
