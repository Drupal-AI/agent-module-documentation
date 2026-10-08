<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Content moderation permissions (content_moderation_permissions) — agent index

**Generates a `use <workflow> transition <transition> for <content_type>` permission for every workflow/transition/node-type combination, enforced by decorating core's transition validator.**

- **Version:** 1.0.x
- **Core:** ^8.8 || ^9 || ^10 || ^11
- **Dependencies:** `content_moderation` (core)
- **Dynamic permissions:** `Permissions::transitionPermissions` (permission_callbacks) iterates `Workflow::loadMultipleByType('content_moderation')` × transitions × node types where the workflow applies → `use {workflow_id} transition {transition_id} for {content_type_id}`.
- **Static permission:** `administer content_moderation_permissions configuration` (`restrict access: true`).
- **Service:** `content_moderation_permissions.state_transition_validation` **decorates** `content_moderation.state_transition_validation` (`StateTransitionValidation`): `getValidTransitions()` merges core + per-type grants; `isTransitionValid()` passes if core OR per-type permission holds.
- **Scope:** per-type logic applies to `node` entities only; others use core behavior.

**Security:** additive-only — it grants extra transitions strictly by explicit per-type permission and never removes core access, so users lacking the new permissions keep exact core behavior. All new permissions are on the standard permissions page (needs `administer permissions`). No routes, endpoints or SQL of its own. See [configure/permissions.md](configure/permissions.md).
