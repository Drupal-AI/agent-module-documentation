<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Layout Builder Reorder adds "Move up" / "Move down" links to each section in the Layout Builder UI, letting editors change the order of whole sections (core Layout Builder only lets you reorder blocks within a section, not the sections themselves).

---

The module is a small runtime enhancement with no configuration. A `hook_element_info_alter()` (attribute-based, in `LayoutBuilderReorderHooks`) registers a `#pre_render` callback (`SectionRearrangeRender::preRender`, a trusted callback) on the core `layout_builder` render element. That callback walks each rendered section that has a "Configure" link, and injects a **Move up** link (for all but the first section) and a **Move down** link (for all but the last), each an AJAX link with classes `layout-builder__link--rearrange--up` / `--down`. Clicking one hits the module's route `layout_builder_reorder.move_section` (`/layout_builder/move/section/{section_storage_type}/{section_storage}/{delta}/{new_delta}`), whose controller swaps the two sections' deltas in the Layout Builder tempstore (`removeAllSections()` then re-`appendSection()` in the new order) and returns an AJAX response that rebuilds the layout. Access reuses core's `_layout_builder_access: view` (no new permission). There is no settings form, service, config, or Drush command — enabling the module is all that is required, and it works wherever Layout Builder is used (default layouts and per-entity overrides).

---

- Reorder whole sections in a content type's default Layout Builder layout.
- Move a section up or down on a specific node's Layout Builder override.
- Rearrange a hero/intro section to the top of a landing page layout.
- Push a footer/CTA section to the bottom of a layout.
- Reorder sections without deleting and re-adding them.
- Give editors an in-place Move up / Move down control per section.
- Fix section order after adding a new section in the wrong place.
- Rearrange sections on a block/entity view display that uses Layout Builder.
- Reorder sections during page building without leaving the Layout Builder UI.
- Provide section-level ordering that core Layout Builder lacks out of the box.
- Reorder sections via AJAX so the layout preview updates immediately.
- Restyle the rearrange links using the `layout-builder__link--rearrange` CSS classes.
- Keep section reordering gated by the same access as the rest of Layout Builder.
- Rearrange sections on a multi-section marketing page.
- Adjust the vertical order of content zones on a complex layout.
- Enable straightforward section ordering for non-technical editors.
- Reorder sections in an overridden node layout before publishing.
- Move a testimonials section above a features section on the fly.
- Correct the order of stacked sections after a content migration into Layout Builder.
- Reorder sections without touching block placement inside them.
