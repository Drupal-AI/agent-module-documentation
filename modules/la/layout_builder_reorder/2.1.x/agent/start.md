<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Layout Builder Reorder — agent index

Adds **Move up / Move down** links to each Layout Builder **section**, so editors can reorder
whole sections (core only reorders blocks within a section). Zero configuration: enabling the
module is all that's needed. No settings form (`configure: null`), no permission, no config,
no service, no Drush.

- **How it works: the pre_render, the move route/controller, the section-swap** →
  [api/mechanism.md](api/mechanism.md)

Key facts:
- Requires core `layout_builder`; core `^11.4 || ^12`.
- `hook_element_info_alter()` (attribute hook in `LayoutBuilderReorderHooks`) adds
  `SectionRearrangeRender::preRender` as a `#pre_render` on the `layout_builder` element.
- Route `layout_builder_reorder.move_section`:
  `/layout_builder/move/section/{section_storage_type}/{section_storage}/{delta}/{new_delta}`,
  controller `MoveLayoutBuilderSectionController`, access `_layout_builder_access: view`.
- The controller swaps the sections at `delta` and `new_delta` in the Layout Builder
  tempstore and rebuilds the layout via AJAX.
- Link CSS classes: `layout-builder__link--rearrange`, `--up`, `--down`.
