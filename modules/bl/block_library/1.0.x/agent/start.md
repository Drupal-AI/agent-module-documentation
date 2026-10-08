# Block Library — agent index

Adds per-block-type **icons** to Layout Builder's inline-block picker ("Add block" list).
Depends on core `layout_builder` and contrib `layout_builder_restrictions`. No settings page
(`configure` null), no permissions, no Drush, no config schema, no plugin types.

- **Icon field on block content types, the `icon_path` third-party setting, path validation,
  upload handling, and how the picker list renders icons (inline SVG vs `<img>`)** →
  [configure/icons.md](configure/icons.md)

Key facts:
- Icon UI is injected into `block_content_type_add_form` / `block_content_type_edit_form` via
  `hook_form_alter` in `block_library.module`; saved by entity builder
  `_block_library_block_content_type_form_builder` as third-party setting
  `block_library.icon_path` on the `block_content_type` config entity.
- `src/Routing/RouteSubscriber.php` overrides the controller of route
  `layout_builder.choose_inline_block` to
  `\Drupal\block_library\Controller\ChooseBlockController::inlineBlockList` (extends the
  `layout_builder_restrictions` controller); it prepends each block type's icon to the link
  title, adds class `lb-list`, and attaches library `block_library/inline_blocks_style`.
- SVG icons are inlined via `file_get_contents` with the XML prolog + DOCTYPE stripped
  (`preg_replace`) so `currentColor` works; other types render as `<img>`.
- Editing icons requires block-content-type admin access (`administer block content` /
  `administer block types`, `restrict access: TRUE`) — trusted-admin config only.
