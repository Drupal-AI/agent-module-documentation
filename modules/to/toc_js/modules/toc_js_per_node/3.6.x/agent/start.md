<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Toc.js per node — agent index

Submodule of Toc.js. Lets editors enable/disable the TOC per node, once a content type opts in.
Adds a boolean base field `toc_js_active` to nodes. Requires `node` + `toc_js`. No `configure`
route, no Drush. Config schema + permission `administer toc_js per node`.

- **Opt a content type into per-node override, the base field, the node-form toggle** →
  [configure/per-node-override.md](configure/per-node-override.md)
- **Block plugin `toc_js_per_node_block`** → [plugins/block.md](plugins/block.md)
- **Permission `administer toc_js per node`** → [permissions/permissions.md](permissions/permissions.md)

Key facts: per-content-type opt-in is stored as node type third-party settings under
`toc_js_per_node`: `override` (bool, "Permit to enable/disable toc per node") and `override_default`
(bool, default node state). The per-node choice is stored in the node base field `toc_js_active`.
The content type must already have Toc.js enabled (`toc_js.toc_js_active = TRUE`).
