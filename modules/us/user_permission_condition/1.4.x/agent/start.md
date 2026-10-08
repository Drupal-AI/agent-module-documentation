<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# User Permission Condition (user_permission_condition) — agent index

Adds one **Condition plugin** (`id: user_permission`) that evaluates whether the contextual
**user** holds a selected **permission** — the permission-based counterpart to core's role
condition. Because it is an ordinary condition plugin it appears automatically in **block
visibility settings** and anywhere else condition plugins are consumed (Context, Page Manager,
custom code via `plugin.manager.condition`). No admin UI of its own, no configure route, no
permissions defined, no services. Depends on core `user`. Core: `^9.5 || ^10 || ^11`.

Standing cautions for any visibility condition (both apply here):
- It decides what is **shown**, not what a user may **access** — it is *not* an access control.
  Anything behind it must still enforce its own access.
- A response that varies on it needs the **`user.permissions`** cache context, or the page cache
  can serve one visitor's variant to another. Core's block system adds this automatically for
  block visibility; custom consumers must add it themselves.

## What you'd do → where

- **Apply the condition to a block / Context, its config schema, and setting it via drush/config** →
  [configure/user_permission_condition.md](configure/user_permission_condition.md)
- **The Condition plugin internals — config form, `evaluate()` / `summary()` / negation semantics,
  and consuming or implementing it in code** → [plugins/user_permission_condition.md](plugins/user_permission_condition.md)

## Key facts (real machine names)

- Plugin: `Drupal\user_permission_condition\Plugin\Condition\PermissionCondition`, `@Condition` id
  **`user_permission`**, label "User Permission". Extends `ConditionPluginBase`, implements
  `ContainerFactoryPluginInterface`.
- Context: one **required** context definition `user` → `@ContextDefinition("entity:user")`. The
  consumer must supply a user (block visibility maps the current user automatically).
- Config: single key **`permission`** (string, machine name of a permission; default `''`).
  Config schema `condition.plugin.user_permission` (extends `condition.plugin`).
- Services injected: `user.permissions` (`PermissionHandlerInterface`) and `extension.list.module`
  (`ModuleExtensionList`) — used only to build the permission select options / summary labels.
- Empty permission (`''`) → `evaluate()` is a no-op pass: returns `TRUE` (or `FALSE` if negated).
- Compare `vocabulary_condition` and `request_data_conditions` — same condition-plugin mechanism,
  different axes.
