<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Group permissions lets an individual group override the permissions its group type defines, so two groups of the same type can grant their roles different rights — without creating a new group type for every variation.

---

In the Group module, permissions belong to the *group type*: every group of type "Team" gives its Member role the same set of rights. That is a clean model until the twentieth team needs one extra permission, at which point the usual workaround is a proliferation of near-identical group types. This module adds a revisionable `group_permission` content entity that stores one per-group override set (`[role_id => [permissions]]`), edited on a permission-matrix form at `/group/{group}/permissions`. Overriding is a two-step opt-in: a checkbox on the group type form enables the feature for a type (stored as the `group_permissions.enabled` third-party setting), and only then does the per-group form appear. The rest of the module makes those overrides authoritative through Group's normal permission pipeline: a `GroupPermissionsManager` service, two `flexible_permissions` calculators (individual and synchronized scopes), a decorator of `group_permission.checker`, and a `QueryAccess` namespace plus query-alter hooks so entity listings and Views respect the overrides. Only a published override entity is applied, admin roles are never overridden, and each override is keyed to its own group. The current release on the 2.0.x branch is 2.0.0-alpha13.

---

- Give one group extra permissions without a new group type.
- Let a group's owner tune what members may do.
- Model per-department variations of one group type.
- Delegate permission management into a group.
- Avoid group-type proliferation on a large site.
- Grant one project group publishing rights temporarily.
- Restrict a single group more tightly than its type.
- Keep overrides auditable as revisioned entities.
- Apply overrides consistently to listings and Views queries.
- Enable overriding only for selected group types.
- Support a franchise model with per-site rules.
- Let a community moderator adjust their own group's roles.
- Revert a group to its type's defaults by deleting or unpublishing the override.
- Track who changed a group's permissions and when.
- Scale group configuration across hundreds of groups.
- Trial a permission change in one group first.
- Support tiered membership within one group type.
- Combine group overrides with site-wide roles.
- Roll back a bad change via the revision history.
- Read or set a group's overrides programmatically through the manager service.
