<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Paragon Core (paragon_core) — agent index

**Base customisations for Paragon projects: renames and reorders node local-task tabs via `hook_local_tasks_alter()`.**

- **Version:** 1.0.x (dev checkout; git branch `1.0.x`, no `version:` in info.yml)
- **Core:** ^10 || ^11
- **Package:** Paragon
- **Project:** https://www.drupal.org/project/paragon_core

**What it does:** `paragon_core_local_tasks_alter()` → `LocalTasksAlter::localTasksAlter()`:
- `layout_builder_ui` tab → title "Layout Builder"
- `content_moderation.workflows` tab → title "Preview", weight 0
- `entity.node.version_history` → title "Version History"
- `entity.node.edit_form` → weight 2
- `entity.node.delete_form` → tab removed (unset)

**Routes/permissions/services:** none. **Config/entities:** none.

**Security:** No routes, endpoints, or permissions. Hiding the node Delete tab is cosmetic (local-tasks bar only); the delete route and its access checks are untouched. No security-relevant surface.
