<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Access Policy decides who may view, edit, or delete an entity by combining reusable **access rules** into named **access policy** config entities that are then assigned to entities — either manually from an **Access** tab or dynamically from selection rules. It moves narrow, per-item access requirements out of site-wide role permissions and into configuration an editor can apply, with no custom code.

---

Drupal's permission system is role-based and site-wide: a role either may edit articles or may not. Real editorial requirements are frequently narrower — this document belongs to one department, that page is embargoed until launch, this record is private to its author — and the usual answers are Group (heavy, membership-based) or a fixed-semantics node-access module. Access Policy adds an Attribute-Based Access Control (ABAC) layer on top of RBAC: an administrator builds `access_policy` config entities out of access rules that compare entity fields (and contextual values such as the current user's fields, roles, or the day of week), assembles them with AND/OR operators, and chooses per operation (view, view-unpublished, revisions, update, delete, manage-access) whether that operation is gated by a per-policy permission, by the access rules, or both. Policies are attached to entities under one of two selection strategies — `dynamic` (auto-assigned by selection rules on save) or `manual` (an author picks the policy from the Access tab). Enforcement runs through `hook_entity_access` (`AccessPolicyEntityAccessControlHandler` → `AccessPolicyValidator`), and listings, entity-reference selects, and Views are filtered by `AccessPolicyQueryAlter`. The engine is fully pluggable — eight plugin types (access rule, selection rule, selection strategy, operation, query, rule argument, rule widget, 403 response) plus `hook_access_policy_data` for registering fields — and the admin UI ships in the `access_policy_ui` submodule. Requires Drupal `^10.3 || ^11` and no other modules; the documented release is 2.0.0-rc1.

---

- Restrict a document to one department by matching a taxonomy field on content and user.
- Let authors apply a named access policy to content from an Access tab.
- Combine several reusable rules into one policy with AND/OR logic.
- Embargo a page until its launch date using a date access rule.
- Give finance-only visibility to selected content.
- Avoid creating a bespoke role for every access requirement.
- Delegate specific access decisions to editors via per-policy assign permissions.
- Control precisely which policies an author may assign.
- Apply the same access model across nodes, media, and other content entity types.
- Show a tailored access-denied message per policy.
- Model access requirements as exportable configuration.
- Replace custom node-access code with configured rules.
- Restrict content by a priority/classification field (public, confidential, secret).
- Make content private to its author ("Me only") with the is_own rule.
- Grant view access to specific individually-assigned users.
- Auto-assign a policy whenever an entity's classifying field changes (dynamic strategy).
- Allow authors to edit content only during business hours (weekday range rule).
- Grant access to users whose email is in a given domain.
- Soft-delete content with an "add to trash" style rule.
- Filter listing pages and entity-reference autocompletes to only readable entities.
- Diagnose why a given user can or cannot access an entity with `drush apca`.
- Extend the engine with a custom access rule plugin.
- Register an existing field as a selectable access rule via hook_access_policy_data.
- Offer a lighter alternative to the Group module for per-item access.
- Vary access by moderation state alongside Content Moderation.
