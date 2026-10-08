<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Layout Builder Direct Add replaces the single **"Add block"** link in each Layout Builder region with a drop-button (or popover menu) that lists the inline/custom block types directly, so editors can add a block in one click instead of stepping through the "Choose a block" off-canvas dialog.

---

The module hooks `hook_element_info_alter()` to append a `#pre_render` callback
(`LayoutBuilder::preRender`) to the `layout_builder` render element. At render time it walks
every section and region, asks the block plugin manager for the `inline_blocks` definitions
available in that context, and (if `layout_builder_restrictions` is installed) filters them
through the active restriction plugins so only permitted inline block types appear. For each
allowed type it builds a direct link to `layout_builder.add_block`, and replaces the region's
default `layout_builder_add_block` link with either a core **dropbutton** (`use_label = 0`) or a
labelled **popover trigger + link list** (`use_label = 1`, the trigger text taken from the
`label` setting). A **"More…"** link back to the original `layout_builder.choose_block`
off-canvas chooser is appended, but only for users holding the *access …"More options" link*
permission. Presentation is driven by two config values in `lb_direct_add.settings` (`use_label`,
`label`) exposed on a small settings form, and the module ships a CSS/JS library
(`lb_direct_add/direct_add`) attached during pre-render.

---

- Let editors add a specific custom block type to a layout in a single click.
- Turn the Layout Builder "Add block" link into a dropbutton of inline block types.
- Present available block types as a labelled popover menu instead of a dropbutton.
- Speed up page building by skipping the "Choose a block" off-canvas step for common blocks.
- Keep the full block chooser available via a permission-gated "More…" link.
- Combine with Layout Builder Restrictions so the dropbutton only lists allowed block types per region.
- Rename the popover trigger (e.g. "Add content") via the `label` setting.
- Reduce editor clicks on content-heavy landing pages built with Layout Builder.
- Hide the "More options" chooser from junior editors by withholding that permission.
- Standardize the add-block experience across all Layout Builder-enabled entity types.
- Give a cleaner add-block affordance in overrides (individual entity layouts) and defaults (view mode layouts).
- Let restricted roles add only the inline block types permitted in a given region.
- Present the dropbutton consistently in every section and region of a layout.
- Improve authoring UX for editors unfamiliar with the two-step block chooser.
- Configure whether the widget is a dropbutton or popover globally on one settings form.
- Surface newly created custom block types in the direct-add list automatically.
- Pair with off-canvas add forms so the block still opens in the side tray after selection.
- Simplify demos and training by showing block types up front.
- Cut friction when repeatedly adding the same handful of block types to a page.
- Provide accessible add-block links (visually-hidden "Add" text) for screen-reader users.
