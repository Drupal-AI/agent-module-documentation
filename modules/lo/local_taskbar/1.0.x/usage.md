<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Local Taskbar restyles Drupal's local tasks (the primary/secondary action tabs) by supplying its own block template and theme suggestion.
---
The module is intentionally tiny. It implements `hook_theme()` (via `Drupal\local_taskbar\Hook\LocalTaskBarHooks`) to register a `block__local_tasks_block` theme hook pointing at the module's `templates/block--local-tasks-block.html.twig`, and `hook_theme_suggestions_block_alter()` to add that suggestion for any block whose plugin is `local_tasks_block`. A `local_taskbar_preprocess_block__local_tasks_block()` preprocess in the `.module` file exposes `content` and a fresh `Attribute` object to the template.

There is no configuration form, no route, no permission, and no service beyond the hook class. It also ships an SDC component under `components/local_taskbar/`. To use it, enable the module and place (or keep) a Tabs / local tasks block in your theme; the tabs then render through the module's template, which you can override in your own theme. Operationally and security-wise there is nothing to lock down: it renders only the standard local-task links a user already has access to.
---
- Enable the module to restyle the local tasks (tabs) block.
- Place a "Tabs" / local tasks block in a region if one is not already present.
- Override `block--local-tasks-block.html.twig` in your theme for custom tab markup.
- Copy the module template into your theme as a starting point for tab styling.
- Rely on the `block__local_tasks_block` theme suggestion for targeted template overrides.
- Style primary vs. secondary tabs differently using the dedicated template.
- Use the shipped SDC component `local_taskbar` as a rendering reference.
- Add CSS to the taskbar via your theme's libraries.
- Keep tab markup consistent across an admin theme and front-end theme.
- Remove the module to fall back to the default core tabs rendering.
- Inspect `LocalTaskBarHooks::theme()` to see the registered template path.
- Combine with an admin toolbar module for a fuller admin navigation.
- Debug tab rendering by enabling Twig theme-suggestion debugging.
- Confirm the local tasks block plugin id is `local_tasks_block` when it is not being themed.
- Use the preprocess-provided `attributes` object to add wrapper attributes in a template override.