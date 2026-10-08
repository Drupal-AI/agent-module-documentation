<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Gin Layout Builder Plus — agent index

Opinionated add-on to **gin_lb**. Rebuilds Layout Builder's "Add block" / "Add section"
pickers into icon-driven **field_group horizontal tabs**, adds a **Library** tab backed by
Section Library, and puts an **"Add to library"** button on the node layout form.
No config, no settings form, no route, no permissions, no Drush, no plugins.

- **What it changes and the code that does it (event subscriber, form_alter, theme hook,
  library)** → [api/behavior.md](api/behavior.md)

Key facts:

- Requires `gin_lb`, `field_group`, `section_library` (info.yml deps). Reuses gin_lb's
  `gin_lb.context_validator` service — it adds nothing on Gin-themed or non-Layout-Builder requests.
- Core mechanism: `LayoutBuilderBrowserEventSubscriber` (kernel `VIEW`, **weight 45**) rewrites
  the `layout_builder.choose_section` and `layout_builder.choose_block` controller results.
- The **Library** tab lists every `section_library_template` entity
  (`SectionLibraryTemplate::loadMultiple()`) as off-canvas import links.
- Only theme hook: **`gin_lb_plus_icon`** (template `gin-lb-plus-icon.html.twig`); only library:
  **`gin_lb_plus/core`** (CSS + field_group horizontal-tabs behaviour).
- It defines **no** hooks of its own (no `*.api.php`) and stores **no** configuration.
