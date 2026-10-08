<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Simple Block + Layout Builder lets you create and edit Simple Block config-entity blocks directly inside the Layout Builder UI, adding a "Create simple block" option alongside core's "Add block".

---

This submodule of `simple_block` wires the config-entity blocks into Layout Builder. Core's `ChooseBlockController` hardcodes only the core "Add custom (content) block" link, so the submodule listens to `KernelEvents::VIEW` (event subscriber `SimpleBlockAddControllerSubscriber`) on the `layout_builder.choose_block` route and injects a **"Create simple block"** link (route `simple_block_layout_builder.edit_block`, gated by `administer blocks`). It sets a `layout_builder` form handler on the `simple_block` entity (`EditSimpleBlockInLayoutBuilderForm`, extending `SimpleBlockEditForm`) so the block can be created/edited in an off-canvas dialog and placed as a Layout Builder component with plugin id `simple_block:<id>`. `hook_contextual_links_alter()` rewrites the placed block's "Configure" contextual link to that same edit form when the component is a `simple_block` derivative, so editing a placed simple block opens the simple-block form. Note simple blocks created this way are **not** auto-deleted when removed from a layout. Depends on `layout_builder` and `simple_block`; adds no config, permission, Drush command, or plugin of its own.

---

- Create a new simple block without leaving the Layout Builder UI.
- Add a "Create simple block" option to the Layout Builder "Add block" list.
- Edit a placed simple block via its Configure contextual link in Layout Builder.
- Place config-entity blocks (`simple_block:<id>`) into a section's region.
- Build landing pages in Layout Builder using deployable config blocks.
- Author block content in an off-canvas dialog while laying out a page.
- Keep Layout-Builder-authored blocks as exportable configuration.
- Give editors a config-block authoring flow inside Layout Builder.
- Reuse the same simple block across multiple layouts by id.
- Combine Layout Builder sections with title/content config blocks.
- Add a promo config block to a node's overridden layout.
- Provide config blocks as an alternative to core inline (content) blocks in LB.
- Edit a simple block's formatted content from the layout canvas.
- Place a simple block into the default layout of a content type's view display.
- Author blocks that deploy with config while designing layouts visually.
- Wire the "Configure" link of a placed simple block to the right edit form.
- Let a site builder assemble pages from pre-made config blocks.
- Extend Layout Builder's block palette with the "Simple block" category.
- Maintain a consistent block library in config while using Layout Builder.
- Avoid content-entity blocks when you need config-managed markup in a layout.
