Block Library enhances Layout Builder's "Add block" (choose inline block) list by letting each block content type carry a custom icon (image or inline SVG) that is shown next to the block name in the picker.

---

The module depends on core `layout_builder` and on `layout_builder_restrictions`. It adds an **Icon** section to the block content type add/edit forms (`block_content_type_add_form` / `block_content_type_edit_form`) with two ways to supply an icon: a path textfield (`icon_path`, accepting `public://…`, a Drupal-root-relative path, or a stream URI) or a file **upload** (validated as an image). The chosen path is stored as a third-party setting (`block_library.icon_path`) on the block content type config entity via an entity builder. A `RouteSubscriber` overrides the controller for the `layout_builder.choose_inline_block` route with `block_library`'s `ChooseBlockController::inlineBlockList()`, which extends the one from `layout_builder_restrictions`; that controller loops the inline-block links, loads each block type's icon, and prepends it to the link title. For SVG files it inlines the file contents (stripping the XML prolog and DOCTYPE) so CSS `currentColor` works; other image types are rendered as an `<img>`. The picker list gets a `lb-list` class and the module's `inline_blocks_style` CSS library. There is no settings page (`configure` is null), no permissions, no Drush, and no config schema of its own; the icon path travels inside the block content type's exported config.

---

- Show a custom icon beside each custom block type in Layout Builder's "Add block" list.
- Upload a PNG/JPG/GIF icon for a block content type through the block type form.
- Reference an existing icon by path (`public://…`, module path, or theme path) instead of uploading.
- Use an inline SVG icon that inherits text color via CSS `currentColor`.
- Make the inline-block picker more scannable for editors by giving block types recognizable glyphs.
- Brand a component library so editors visually distinguish hero, card, CTA, and quote blocks.
- Store the icon choice as part of the block content type's exportable configuration.
- Give a design-system's Layout Builder blocks consistent iconography.
- Improve editor UX on sites with many inline block types.
- Provide icons without writing a custom Layout Builder controller yourself.
- Keep icons versioned in a theme/module directory and point block types at them by path.
- Swap a block type's icon later by editing its Icon field.
- Combine with `layout_builder_restrictions` (a hard dependency) to curate and visually label allowed blocks.
- Style the picker list via the added `lb-list` class and `inline_blocks_style` library.
- Render raster icons as `<img>` and vector icons inline automatically based on MIME type.
- Validate uploaded icon files as images before saving.
- Migrate icon assignments between environments through config sync (third-party settings).
- Clear a block type's icon by emptying the Icon field (the third-party setting is unset).
- Present a friendlier "Add block" experience during Layout Builder authoring.
