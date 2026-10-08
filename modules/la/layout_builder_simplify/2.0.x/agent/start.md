<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Layout Builder Simplify (layout_builder_simplify) — agent index

**Reworks Layout Builder's "Choose a block" off-canvas UI into a category-first chooser with a searchable custom-block browser.**

- **Version:** 2.0.x
- **Core:** ^8 || ^9 || ^10
- **Dependencies:** layout_builder, system (>=8.5.0-rc1)
- **Key routes:** `layout_builder_simplify.choose_individual_block` (`_layout_builder_access: 'view'`); `layout_builder_simplify.autocomplete.custom_blocks` at `/block-search.json` (`_permission: 'access content'`, JSON).
- **Override:** `RouteSubscriber` swaps `layout_builder.choose_block` to `ChooseBlockController::build`.
- **Services:** none custom; controller uses `database`, `entity_type.manager`, `plugin.manager.block`.

**Access:** Block-placement/chooser routes inherit Layout Builder access (`view`). The `/block-search.json` autocomplete requires `access content` and returns custom-block info/uuid/type.

See [configure/chooser.md](configure/chooser.md)
