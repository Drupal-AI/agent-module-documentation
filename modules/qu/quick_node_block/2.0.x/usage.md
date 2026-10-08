<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Quick Node Block provides a configurable block that renders any single node in a view mode you choose, so you can drop a piece of content into any region without a View or custom code.

---

The module adds one block plugin, `quick_node_block` (block category "Quick Node Block"). When you place it, its block form gives you an entity-autocomplete **Node** field and a **Display** select whose options are the view modes available for that node's content type (fetched live via the entity display repository, updated by AJAX when you pick a node). On save it stores two settings on the block config entity — `quick_node` (the autocomplete label, i.e. `Title (nid)`) and `quick_display` (the chosen view mode) — and at render time `build()` loads the node and returns `entity_type.manager` view-builder output for that node in that view mode. The block respects node access (`blockAccess()` returns the node's `view` access, forbidding the block when the node is unviewable) and adds a `node:<nid>` cache tag so it invalidates when the node changes. There is no global configuration page; all config lives on each placed block. A convenience local task, **Add to Block** (`/admin/node/{node}/quick_node_block`, permission `administer blocks`), appears on every node page and opens the block-add form pre-filled with that node. Requires only core `block` and `node`.

---

- Show a specific promotional node in a sidebar block using its "Teaser" view mode.
- Render a full article in a block placed in a non-content region (e.g. header or footer).
- Feature a single landing-page node in a block on many pages without building a View.
- Pick the exact display mode a node uses when shown in a block (teaser, full, or a custom view mode).
- Place the same node as a compact teaser in one region and full content in another.
- Add a node to a block directly from that node's page via the "Add to Block" tab.
- Surface an "About us" or "Contact" node in the footer across the site.
- Reuse an existing node's rendered output in a block instead of duplicating its content.
- Display a call-to-action node in a custom region defined by your theme.
- Show a highlighted news item in a block on the front page.
- Keep the block's content in sync with the node automatically (node:nid cache tag).
- Respect node view access so the block hides when the viewer can't see the node.
- Let editors swap the featured node by editing the block, no code deploy needed.
- Build a "featured content" region by placing several Quick Node Blocks with different nodes.
- Present a node with a stripped-down custom view mode designed for block placement.
- Quickly prototype content placement in regions before committing to a Views-based solution.
- Embed a node's rendered body and fields into a block on a dashboard.
- Use per-content-type view modes so different node types render appropriately in the block.
- Place a legal/disclaimer node block site-wide with visibility conditions from core Block.
- Show a seasonal or campaign node in a block and change it later by editing the block config.
