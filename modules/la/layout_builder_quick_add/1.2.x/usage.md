<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Layout Builder Quick Add replaces Layout Builder's "Add block" step: instead of opening the off-canvas sidebar, the "Add block" link expands an inline listing of your inline-block types right in the region, so an editor picks a block in one click.

---

The module swaps the URL of Layout Builder's core "Add block" link at render time — via a `#pre_render` callback (`LayoutBuilderQuickAddHelper::layoutBuilderPreRender`) registered through `hook_element_info_alter` on the `layout_builder` element. The rewritten link points at the AJAX route `layout_builder_quick_add.add_blocks`, whose controller (`LayoutBuilderQuickAddController::addBlocks`) renders the `quick_add_blocks_listing` theme: a compact set of enabled block types, each with an optional icon, description tooltip, screenshot and a "multiple view modes" hint, plus a "See more blocks" link back to core's off-canvas chooser and a "Cancel" link. Clicking a block type follows core's own `layout_builder.add_block` route (`plugin_id = inline_block:<block_content_type_id>`), so the insertion itself stays on the core flow. A settings form at `/admin/config/content/layout_builder_quick_add` (route `layout_builder_quick_add.quick_add_config_form`, permission `administer layout_builder_quick_add configuration`) controls which block types appear, their order (tabledrag weights in `blocks_order`), per-type screenshots and icons, whether descriptions and the multiple-view-mode message show, and a CSS theme (`default`, `none`, `claro`, `gin`). Block-type icons are stored as a `layout_builder_quick_add:icon` third-party setting on each `block_content_type`, uploaded from an extra field the module adds to the block-type edit form. It depends on core `layout_builder` alone and runs on Drupal `^10 || ^11`.

---

- Add an inline block in Layout Builder without opening the off-canvas sidebar.
- Cut clicks when assembling a component-heavy page.
- Show a curated shortlist of block types at the "Add block" point.
- Reorder the block types offered in the quick-add listing.
- Restrict the quick-add listing to only a few chosen block types.
- Give each block type an icon so editors recognise it visually.
- Attach a screenshot preview to each block type's tooltip.
- Show or hide block-type descriptions in the picker.
- Warn editors when a block type has multiple view modes.
- Keep the core "See more blocks" chooser available as a fallback.
- Cancel an in-progress add without leaving the page.
- Match the picker's styling to the Claro admin theme.
- Match the picker's styling to the Gin admin theme.
- Style the picker yourself by choosing the `none` theme.
- Speed up building a landing page from inline blocks.
- Reduce training time for editors new to Layout Builder.
- Standardise the block-adding workflow across an editorial team.
- Preview the configured listing from the settings form before using it.
- Override the `quick_add_blocks_listing` templates to fully re-theme the picker.
- Add several inline blocks in quick succession to one region.
