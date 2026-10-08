<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# View Unpublished Dynamic Permission (view_unpublished_dynamic_permission) — agent index

**Generates `view any unpublished <entity_type>` (+ per-bundle) permissions and enforces them in `hook_entity_access` for unpublished publishable entities.**

- **Version:** 1.0.x — core `^10.3 || ^11 || ^12`; depends on `user`.
- **Permissions:** dynamic callback `ViewUnpublishedDynamicPermission::generatePermissions()` — one per publishable entity type, plus `:<bundle>` variants for bundleable types.
- **Enforcement:** `ViewUnpublishedDynamicPermissionHooks::entityAccess` — on `view` of an unpublished `EntityPublishedInterface`: allowed if the account has the entity-type or bundle permission, else **forbidden**; neutral otherwise.
- **Setup:** assign permissions at `/admin/people/permissions`. No config forms.
- **Security:** does **not** over-grant — absent the permission it returns `forbidden` (a deny), not neutral. Note `forbidden` is authoritative and may override other modules' allow (e.g. author-owns-own-unpublished); grant the permission to roles that need such access. Cache-per-permissions/per-user.
