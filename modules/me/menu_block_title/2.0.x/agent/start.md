# Menu Block Title — agent index

Adds a **"Block title as menu link parent"** checkbox to menu blocks. When ticked, the block's
title becomes a link to the active menu item's parent. No settings page, route, permission, service
or Drush — the only state is a third-party setting on the block config entity.

- **Enable it on a block, where the flag is stored, and which blocks qualify** →
  [configure/enable-on-block.md](configure/enable-on-block.md)
- **How the relabel happens (block_view_alter → pre_render, cache context)** →
  [api/mechanism.md](api/mechanism.md)

Key fact: the flag lives at
`block.block.<id>` → `third_party_settings.menu_block_title.modify_title: true`. The checkbox only
appears on blocks whose form has a `menu_levels`/`level` setting (core `system_menu_block:*`
derivatives and the contrib `menu_block` module), and only takes effect when the block title is
visible. Works best on a block starting at menu level 2.
