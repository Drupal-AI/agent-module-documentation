<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Tasks (entity_tasks) — agent index

Re-exposes Drupal core's **local task tabs** (View/Edit/Delete/Revisions/Translate…) for the
**current route** as (a) a placeable **block** and (b) an **admin-toolbar** item with three display
modes. Display/placement only — the tabs come from core and keep their own access. Package
**Utility**. No dependencies beyond core. Core `^10 || ^11`. License GPL-2.0-or-later. Version 3.0.1.

## What it actually provides

- **Block plugin** `entity_tasks_block` (`src/Plugin/Block/EntityTasksBlock.php`), label *"Entity
  tasks block"*. Renders `LocalTaskManager::getLocalTasks(currentRoute, 0)['tabs']`. →
  [blocks/entity-tasks-block.md](blocks/entity-tasks-block.md)
- **Toolbar integration**: `hook_toolbar_alter()` → service `entity_tasks.toolbar`
  (`src/Service/ToolbarService.php`) injects toolbar items in classic/expanded/dropdown mode. →
  [toolbar/toolbar.md](toolbar/toolbar.md)
- **Config form** `EntityTasksConfigForm` at route `entity_tasks.config`
  (`/admin/config/entity-tasks`), config object `entity_tasks.config` key `display_mode`. →
  [config/settings.md](config/settings.md)
- **Permissions** (`entity_tasks.permissions.yml`): `access entity tasks`,
  `administer entity tasks configuration`.
- **Themes/templates**: `entity_tasks_block`, `entity_tasks_dropdown`
  (`entity_tasks.themes.yml`, loaded via a custom `hook_theme()` that decodes the `.themes.yml`).
- **Libraries** (`entity_tasks.libraries.yml`): `block`, `toolbar`, `dropdown` (CSS + JS that swaps
  in per-task SVG icons). No config schema shipped, no install config, no Drush, no submodules.

## Quick facts

- Only renders when the current user has **`access entity tasks`**; toolbar also skips admin routes.
- Tabs are core's, so each carries its own `#access`; toolbar `getLinks()` keeps only
  `AccessResultAllowed` links.
- Icon SVGs live in `images/` and are inlined via `drupalSettings` for known task types.
