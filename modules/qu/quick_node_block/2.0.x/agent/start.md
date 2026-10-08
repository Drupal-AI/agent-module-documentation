<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Quick Node Block — agent index

One block plugin that renders a chosen node in a chosen view mode. **No global config**
(`configure: null`), no permissions of its own, no schema, no Drush. All state lives on the
placed block config entity.

- **Place the block, its two settings, the "Add to Block" node task** →
  [configure/place-block.md](configure/place-block.md)
- **The `quick_node_block` plugin internals (build, access, cache, AJAX display options)** →
  [api/block-plugin.md](api/block-plugin.md)

Key facts:
- Block plugin id `quick_node_block`, category "Quick Node Block". Depends on core `block`, `node`.
- Block settings: `quick_node` (autocomplete label `"Title (nid)"`) and `quick_display`
  (a node view mode machine name, e.g. `teaser`, `full`).
- Local task **Add to Block**: route `quick_node_block.quickadd` at
  `admin/node/{node}/quick_node_block`, permission `administer blocks`.
- `build()` renders the node via the view builder; `blockAccess()` defers to node `view`
  access; adds a `node:<nid>` cache tag.
