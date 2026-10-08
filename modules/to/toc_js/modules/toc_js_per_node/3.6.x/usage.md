<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Toc.js per node lets editors turn the Toc.js table of contents on or off for an individual node, once a content type opts in to per-node overrides.

---

This submodule of Toc.js adds a boolean base field `toc_js_active` to all nodes and a per-content-type opt-in. On a content type that already has Toc.js enabled, a "Permit to enable/disable toc per node" checkbox (stored as third-party setting `toc_js_per_node.override`) plus a default state (`toc_js_per_node.override_default`, "Enabled"/"Disabled") appear in the Table of contents settings. When override is on, the node add/edit form shows a "Display a table of contents" checkbox (gated by the `administer toc_js per node` or `administer nodes` permission) that writes the node's `toc_js_active` value; `hook_entity_bundle_field_info` applies the content type's default to that field. At view time, Toc.js respects the node's `toc_js_active` value and hides the TOC when it is off. The submodule also provides a `toc_js_per_node_block` block (extending the Toc.js block) with an "Override node type configuration" toggle so a block can either use the node type's TOC settings or its own custom settings, while still honoring the per-node on/off. It requires Toc.js (and Node), defines the `administer toc_js per node` permission, and ships config schema for the per-node third-party settings and the block settings.

---

- Let an author hide the table of contents on a specific long article.
- Enable a TOC only on selected nodes of a content type, not all of them.
- Opt a content type into per-node TOC control with the "override" checkbox.
- Set whether new nodes show the TOC by default (override_default).
- Give editors a "Display a table of contents" toggle on the node edit form.
- Turn the TOC off for a landing node while keeping it on for other pages of the same type.
- Store the per-node choice in the node's `toc_js_active` base field.
- Gate who can toggle the per-node TOC with `administer toc_js per node`.
- Place a `toc_js_per_node_block` that respects each node's on/off choice.
- Let a block override the node type's TOC settings with its own configuration.
- Keep the node-type TOC settings but allow exceptions per node.
- Default a content type's nodes to "no TOC" but let editors enable it individually.
- Default a content type's nodes to "TOC on" but let editors disable it individually.
- Translate/revision the per-node TOC flag along with the node (revisionable/translatable field).
- Provide editorial flexibility without separate content types for TOC/no-TOC.
- Combine the per-node block with the node-type extra field for different regions.
- Hide the TOC on short nodes where it adds no value.
- Show the TOC only on documentation nodes flagged by an editor.
- Respect the per-node flag in both the extra field and the per-node block.
- Roll out per-node TOC control to an editorial team via one content-type setting.
