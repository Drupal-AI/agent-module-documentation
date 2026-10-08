<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Menu Multilingual — agent index

Adds two per-menu-block options that **hide menu links** whose label isn't translated, or whose
target content isn't translated, in the current language. Works on `system_menu_block` and the
contrib `menu_block`. Settings are **third-party settings on the block config entity**. Requires
`menu_link_content` + `content_translation`. **No config route, no permissions, no Drush.**

- **The two block options, where they're stored, and the filtering rules (und/zxx, children)** →
  [configure/block-settings.md](configure/block-settings.md)
- **The `menu_multilingual.modifier` service + `MenuLinkContentMultilingual` plugin** →
  [api/modifier.md](api/modifier.md)

Key facts:
- Settings key: `block.block.<id>.third_party.menu_multilingual` with booleans
  `only_translated_labels` and `only_translated_content`.
- Added to the block form via `hook_form_block_form_alter`; applied via a `#pre_render` on the
  block that runs `menu_multilingual.modifier`.
- Only acts on blocks whose plugin id is `menu_block` or `system_menu_block` AND that have at
  least one option enabled. Clear cache after changing menu items or block settings.
