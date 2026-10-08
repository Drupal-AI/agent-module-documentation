<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Simple Block + Layout Builder — agent index

Submodule of **simple_block**. Adds a **"Create simple block"** option in the Layout Builder
"Add block" list and lets you edit placed simple blocks in an off-canvas dialog. Config blocks
are placed as `simple_block:<id>` components. No config, permission, Drush, or plugin of its own.

- **How the integration works & how to place a simple block in a layout** →
  [configure/layout-builder.md](configure/layout-builder.md)
- **Parent module (the simple_block config entity, block derivative, permissions)** →
  [../../../../1.7.x/agent/start.md](../../../../1.7.x/agent/start.md)

Key facts:
- Event subscriber `SimpleBlockAddControllerSubscriber` (on `KernelEvents::VIEW`, route
  `layout_builder.choose_block`) injects the **"Create simple block"** link → route
  `simple_block_layout_builder.edit_block` (requires `administer blocks`).
- Sets a `layout_builder` form handler on `simple_block` (`EditSimpleBlockInLayoutBuilderForm`).
- `hook_contextual_links_alter()` rewrites a placed simple block's Configure link to that form.
- Placed as a Layout Builder section component with plugin id `simple_block:<id>`.
