<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Context Profile Role — plugins

## Context provider: `UserProfileRouteContext`
Tagged `context_provider`, autowired. `getRuntimeContexts()` inspects the current route object's `parameters` option; if a `user` parameter is defined and resolvable it becomes the value of a `user_profile` context (`entity:user`, not required). Cacheable metadata sets the `route` cache context. `getAvailableContexts()` advertises the `user_profile` context ("User profile from URL") so it is selectable in the Block layout / Context UI.

## Condition plugin: `user_profile_role`
`ConditionPluginBase` with a required `user_profile` (`entity:user`) context definition.
- **Config form:** a `roles` checkboxes element listing every `user_role` entity.
- **evaluate():** loads `getContextValue('user_profile')`; returns TRUE if that profile user has any of the configured roles. Empty `roles` + not negated → TRUE (always applies). Honours negation via the standard condition base.
- **summary():** human-readable "The user role is X or Y".
- **Config schema:** `roles` is a sequence of role-ID strings.

## Usage
Place a block, add the "User Profile Role" visibility condition, tick the roles, and (optionally) negate it. The block then shows only on `/user/{uid}` (and other user-parameter routes) where the *viewed* account has one of those roles.

## Security note
The role tested is the **viewed profile owner's**, derived from the URL — this is not an authorization mechanism and cannot be used by a visitor to grant themselves a role.
