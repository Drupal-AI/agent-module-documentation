<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Local Taskbar (local_taskbar) — agent index

**Themes the core local tasks (tabs) block** via a custom template and a `block__local_tasks_block` theme suggestion.

- **Version:** 1.0.x (1.0.0-alpha2)
- **Core:** ^10 || ^11
- **Hooks:** `hook_theme`, `hook_theme_suggestions_block_alter` (in `src/Hook/LocalTaskBarHooks.php`); `local_taskbar_preprocess_block__local_tasks_block()` in `.module`.
- **Template:** `templates/block--local-tasks-block.html.twig`; SDC component under `components/local_taskbar/`.
- **Config/routes/permissions:** none.
- **Security:** no routes, forms, permissions, or user input; renders only standard local-task links the user can already see. No attack surface.