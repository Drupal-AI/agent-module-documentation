<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Role View Mode Switcher (entity_role_view_mode_switcher) — agent index

Alters an entity's render **view mode based on the current user's role**, per entity. Version **2.1.0**.
Package `Other`. Core `^8 || ^9 || ^10 || ^11`. License GPL-2.0-or-later. **No declared module or Composer
dependencies** (info.yml lists none; composer.json `require` is empty).

## What it actually is

- One hook: `entity_role_view_mode_switcher_entity_view_mode_alter(&$view_mode, $entity, $context)` in
  `entity_role_view_mode_switcher.module` — the whole runtime is this hook plus one helper.
- One config entity type: **`rule`** (`src/Entity/Rule.php`, `RuleInterface`), label *"View Mode Switcher
  Rule"*, config prefix `rule`, admin permission **`administer site configuration`**. Exports `id`, `label`,
  `conditions`. Admin UI under **Structure → View Mode Switcher Rule**
  (`/admin/structure/entity_role_view_mode_switcher_rule`).
- One helper: `ViewModeSwitcher::switchViewModes()` (`src/Util/ViewModeSwitcher.php`) — the actual switch logic.
- No permissions.yml (uses core `administer site configuration`), no services, no Drush, no plugins, no fields
  of its own. Config schema in `config/schema/rule.schema.yml`.

## How switching is wired

You add an **entity_reference field targeting `rule`** to a bundle; select a rule when editing an entity;
at view time the hook reads that reference and may swap the view mode. Mechanism, ordering and the
qualified-view-mode string format → [api/switch-mechanism.md](api/switch-mechanism.md).

## Docs

- **The Rule config entity, its forms/routes/list builder, and the conditions schema** →
  [config/rule-entity.md](config/rule-entity.md)
- **The switch algorithm (`hook_entity_view_mode_alter` + `ViewModeSwitcher`) and how to enable it on a
  bundle** → [api/switch-mechanism.md](api/switch-mechanism.md)

## Note

This changes *which view mode renders* (presentation), not access. A trimmed view mode is not an access
boundary; protect sensitive fields with real field/entity access.
