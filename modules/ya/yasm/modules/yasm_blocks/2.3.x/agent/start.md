<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# YASM Blocks (yasm_blocks) — agent index

Optional **YASM submodule**: placeable statistics-count **blocks**. Version **2.3.x**, package
`statistics`, core `^10.3 || ^11 || ^12`, PHP `^8.1`, GPL-2.0-or-later. Depends on **`yasm`** (for its
counting services) and core **`block`**. No routes, no permissions of its own, no config schema.

## What it provides

Three block plugins (annotated `@Block`, category "YASM"), all extending the abstract
`Plugin\Block\YasmBlock`:

- **`yasm_block_site`** — `Plugin\Block\SiteBlock`. Site-wide published counts: nodes, comments,
  users, groups (if Group on), files. Uses `yasm.entities_statistics->count()` with `status = 1`.
- **`yasm_block_user`** — `Plugin\Block\UserBlock`. The current user's own published nodes, comments,
  files (`uid = current user`).
- **`yasm_block_group`** — `Plugin\Block\GroupBlock`. Contents, members, comments, files and webform
  submissions for the configured group(s) or the `group` entity in the current route; sums via
  `yasm.groups_statistics`. Adds a `groups` multiselect to the block form.

Shared base `YasmBlock` adds the block-form options (`block_style` = list/cards/counters,
`with_icons`, `attach_fontawesome`) and `renderCards()` which themes the counts with the parent's
`yasm_card` / `yasm_item` / `yasm_columns` themes and attaches the `yasm_blocks/counters` JS +
`yasm/global` / `yasm/fontawesome` libraries. One hook only: `Hook\YasmBlocksHooks::help()` renders
the README.

## Solution docs

- **The three blocks, their forms, styles and data sources** → [plugins/blocks.md](plugins/blocks.md)
- Parent module: [`yasm`](../../../2.3.x/agent/start.md)
