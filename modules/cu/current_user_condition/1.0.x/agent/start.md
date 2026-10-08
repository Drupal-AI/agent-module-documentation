<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Current User Profile Condition (current_user_condition) — agent index

Core Condition plugin that is true when the visitor is on **their own** user profile page (route
`entity.user.canonical`, `user` param == current user). Plugs into block visibility and any
condition-aware component.

- **Dependency:** core `user` only. Core `^9 || ^10 || ^11`. Version 1.0.5.
- **Provides:** one Condition plugin `current_user_condition` (label "Current users profile"),
  class `Drupal\current_user_condition\Plugin\Condition\CurrentUserCondition`.
- **Config schema:** `condition.plugin.current_user_condition` (`status` boolean).
- **No** routes, permissions, services, Drush commands, libraries, or submodules.

## Behavior
- Checkbox "Is the current authenticated users profile page" sets `status`.
- `status = FALSE` (default) → `evaluate()` returns TRUE always (no restriction).
- `status = TRUE` → TRUE only when route is `entity.user.canonical` and the routed `user` id equals
  the current user id. Adds the `user` cache context when active. Supports negation.

## Solution docs
- [Condition plugin](plugins/condition.md) — plugin id, config, evaluate logic, caching, how to use.
