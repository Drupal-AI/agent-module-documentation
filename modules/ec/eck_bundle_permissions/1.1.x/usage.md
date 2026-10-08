<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
ECK Bundle Permissions gives Entity Construction Kit entities **per-bundle** create, edit, delete and view permissions, so a role can be allowed to work with one ECK bundle without being allowed to work with them all.

---

Entity Construction Kit (ECK) lets a site define custom content entity types without code, but its built-in permissions are per entity **type**: "edit any Event entity" covers every bundle of the Event type. On a site that models several unrelated things as bundles of one ECK type — say events, sponsors and resources all as bundles of one entity type — that is too coarse, and the usual workaround (a separate entity type per bundle) defeats the point of bundles. This module supplies the missing granularity. `EckBundlePermissionsGenerator::entityPermissions()` generates, at runtime through a `permission_callbacks` entry, a `create`, `edit any`, `delete any` and `view any` permission for each (entity type × bundle) pair — plus `edit own`, `delete own` and `view own` variants for ECK types that have an author field. `EckBundleAccessControlHandler` (installed on every ECK entity type by `hook_entity_type_alter`) enforces them by OR-ing the per-bundle permission onto eck's per-type access result, so the per-bundle grants only ever add access, never remove it. On Drupal 10.3+ the module also gives each bundle its own permissions tab. It is five files with `eck` as its only dependency and a wide core range of `^8 || ^9 || ^10 || ^11`; there are no routes, forms or configuration — enabling it makes the finer permissions appear, and because the permissions are generated rather than declared they cannot be found by grepping a YAML file. Adding a new ECK bundle adds permissions that no role holds until they are granted, so a new bundle is closed by default.

---

- Let a role edit one ECK bundle only, not the whole entity type.
- Give separate edit rights for the events bundle and the sponsors bundle.
- Avoid splitting one ECK type into one entity type per bundle.
- Delegate a single bundle to a specific team or role.
- Grant create rights on just one bundle of an ECK type.
- Grant view-only access to one bundle for a reviewer role.
- Let authors edit only their own entities in a given bundle.
- Let authors delete only their own entities in a given bundle.
- Keep several ECK bundles independently governed.
- Restrict deletion of a bundle to specific roles.
- Model many unrelated things inside one ECK entity type.
- Give editors narrower, bundle-scoped ECK access.
- Audit which roles can act on which ECK bundle.
- Support a multi-team content model on shared ECK types.
- Close a newly added ECK bundle by default until permissions are granted.
- Reduce over-granting caused by ECK's coarse per-type permissions.
- Match ECK permissions to node-style per-bundle granularity.
- Add a per-bundle "Permissions" tab for each ECK bundle (Drupal 10.3+).
- Grant per-bundle permissions programmatically with `user_role_grant_permissions()`.
- Delegate a resource-library bundle to librarians while keeping other bundles locked.
- Keep ECK usable and safe as the number of bundles grows.
- Layer per-bundle grants on top of existing per-type permissions without conflict.
