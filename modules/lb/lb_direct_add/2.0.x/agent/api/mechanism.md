<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# How the direct-add widget is built

## Entry point — `hook_element_info_alter()`

`lb_direct_add_element_info_alter()` appends `LayoutBuilder::preRender` to the
`layout_builder` render element's `#pre_render`. There is no route or event subscriber; the whole
behavior runs while the Layout Builder UI element renders. `LayoutBuilder` implements
`TrustedCallbackInterface` (declares `preRender` in `trustedCallbacks()`).

## `LayoutBuilder::preRender($element)`

For each section, and each region in it:

1. Get inline block definitions for the context:
   `block.plugin.manager->getFilteredDefinitions('layout_builder', $contexts, ['section_storage' => …, 'region' => …, 'list' => 'inline_blocks'])`, then `getGroupedDefinitions()`; it uses the
   group keyed by the translated **"Inline blocks"** category.
2. **Restrictions integration** — if `layout_builder_restrictions` is enabled, it loads the
   sorted restriction plugins and removes any inline block type not returned by each plugin's
   `inlineBlocksAllowedinContext($section_storage, $delta, $region)`.
3. Build one link per remaining type to `layout_builder.add_block` (params: storage type/id,
   delta, region, `plugin_id`), each carrying `class="use-ajax"`,
   `data-dialog-type="dialog"`, `data-dialog-renderer="off_canvas"` (so the add form still opens
   in the off-canvas tray).
4. Append a **"More…"** link to `layout_builder.choose_block` (the original chooser) **only** if
   the user has `access layout builder direct add more options`.
5. Replace the region's existing `layout_builder_add_block` element:
   - `use_label` falsy → `addDropbutton()`: a `#type => 'dropbutton'` with `#links`.
   - `use_label` truthy → `addLinks()`: a trigger `#type => 'link'` (title = `label` setting) plus
     a themed `links` list (the popover). Then the original `link` child is unset.
6. Attaches the `lb_direct_add/direct_add` library (CSS + JS + `core/once`).

## Notes for agents

- The widget appears in **every** section/region of any Layout Builder layout (defaults and
  overrides); there is no per-display opt-in.
- Only **inline/custom** block types are listed directly; reusable/other blocks remain reachable
  through the "More…" chooser.
- To change dropbutton vs popover, edit `lb_direct_add.settings` (`use_label`) — see
  [../configure/settings.md](../configure/settings.md).
