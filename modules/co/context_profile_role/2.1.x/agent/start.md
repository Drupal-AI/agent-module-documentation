<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Context Profile Role (context_profile_role) — agent index

**A block-visibility condition + context provider that matches on the roles of the user profile currently being viewed.**

- **Version:** 2.1.x (2.1.1)
- **Core:** ^11.3 || ^12
- **Requires:** user
- **Condition plugin:** `user_profile_role` (Drupal\context_profile_role\Plugin\Condition\UserProfileRole)
- **Context provider:** `UserProfileRouteContext` → `user_profile` entity:user context (cache context: route)
- **Config schema:** `condition.plugin.user_profile_role` (roles sequence)

**Security:** Purely a display/visibility condition. It evaluates the roles of the profile owner from the route's `user` parameter — it does not grant, assign, or escalate any role for the current user, and the viewer cannot influence the context to gain privileges. No routes, no permissions, no mutating endpoints.

See [plugins/context_profile_role.md](plugins/context_profile_role.md)