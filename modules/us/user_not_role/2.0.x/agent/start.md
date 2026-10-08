<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# User not role (user_not_role) — agent index

**Provides one condition plugin, `user_not_role` ("User Not Role"), that passes when the current user does NOT have any of the selected roles — the inverse of core's "User Role" condition.**

- **Version:** 2.0.x (project + machine name `user_not_role`) · package `Condition`
- **Core:** `^11.3 || ^12` · no PHP extension or external library requirements · `require: {}`
- **Provides:** a single Condition plugin. No routes, no permissions, no services beyond hook wiring, no Drush.
- **Config schema:** `condition.plugin.user_not_role` — `roles: sequence of string` (role IDs).

## What it is

Core's "User Role" condition expresses only the positive ("user HAS role X"). This module supplies the negation as a proper condition plugin, usable anywhere a condition is consumed: **block visibility** (its primary use), Layout Builder sections, Page Manager, etc.

## Mechanism (source of truth)

- **Plugin:** `src/Plugin/Condition/UserNotRole.php` — `#[Condition(id: 'user_not_role')]`, context `user` (`entity:user`).
- **`evaluate()`:** returns `empty(array_intersect($this->configuration['roles'], $user->getRoles()))`.
  - Empty intersection → user has none of the selected roles → **TRUE** (condition passes).
  - Non-empty intersection → user has at least one → **FALSE**.
  - Short-circuit: no roles selected and not negated → **TRUE** (no restriction).
  - Missing user context → logs a warning and returns **FALSE** (fails closed).
- **Negation:** handled by core (`ConditionManager::execute()` inverts `evaluate()` when `negate` is set). This module does not invert internally; its summary/short-circuit read `negate`/`isNegated()`.
- **Cache:** `getCacheContexts()` remaps the `user` context to **`user.roles`** so results vary correctly per role set (no cross-user leak).
- **Form:** `buildConfigurationForm()` renders a `checkboxes` of all roles (labels escaped via `Html::escape`). Block config is gated by core's `administer blocks`.
- **Hook:** `src/Hook/UserNotRoleHooks.php` — `hook_help()` only (attribute-based, autowired via `user_not_role.services.yml`).

## Solution docs

- [configure/user_not_role.md](configure/user_not_role.md) — add and configure the condition on a block; the "User Role + User Not Role" combination pattern.
- [plugins/user_not_role.md](plugins/user_not_role.md) — the condition plugin for developers: id, context, config, evaluation and cache semantics.
