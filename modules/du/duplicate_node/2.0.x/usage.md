<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Duplicate Node Layout & Block adds a Duplicate tab/operation to nodes that pre-fills a new node edit form from an existing node — including its paragraphs, translations, and (optionally) its Layout Builder layout with the inline blocks re-cloned.

---

Duplicate Node Layout & Block (`duplicate_node`) lets content editors clone a node. Choosing Duplicate on a node opens a normal node edit form already populated from the source node via core's `createDuplicate()`; the editor reviews/edits and saves it as a brand-new node. Paragraph reference fields are deep-cloned so the copy owns its own paragraphs; all translations are carried over; the new node is re-owned by the current user with fresh created/changed timestamps. A settings form controls a configurable title prefix, whether the copy keeps the original's published status (otherwise the content type's default is used), and per-bundle exclusion lists of fields that should not be copied (for both nodes and paragraphs). When Layout Builder duplication is enabled, custom (inline) blocks placed in the node's layout are duplicated too and re-linked into the copy's layout so they can be edited independently. It depends on core Node and Layout Builder, provides per-content-type "duplicate {type} content" permissions plus an admin permission for its settings, exposes a Views field for a duplicate link, and integrates opportunistically with Paragraphs, Address, Group (gnode), Content Moderation, and Markdown when those modules are present.

---

- Clone an existing node into a new, editable node from a Duplicate tab or operations link.
- Build new pages from a "template" node without recreating fields by hand.
- Duplicate a layout-heavy Layout Builder page including its sections and components.
- Copy inline/custom blocks placed in a node's Layout Builder layout into the clone.
- Deep-clone paragraph reference fields so the copy owns independent paragraph entities.
- Duplicate all translations of a multilingual node in one action.
- Automatically prepend a configurable prefix (e.g. "Duplicate of") to the copy's title.
- Reset the copy's publication status to the content type default instead of the original's.
- Optionally preserve the original's published/unpublished status on the copy.
- Exclude specific node fields per content type from being copied.
- Exclude specific paragraph fields per paragraph bundle from being copied.
- Re-assign ownership of the copy to the current user with fresh timestamps.
- Grant duplication rights per content type via "duplicate {type} content" permissions.
- Add a "Duplicate" link column to a Views listing of nodes.
- Provide a Duplicate contextual link and local task tab on node pages.
- Carry a moderated node's moderation state widget into the duplicate form.
- Re-attach a duplicated node to the same Group(s) it belonged to (with Group/gnode).
- Seed duplicated Address field initial values so address data is retained on the copy.
- Alter the duplicated node programmatically via `hook_duplicated_node_alter()`.
- Alter duplicated paragraph fields via `hook_duplicated_node_paragraph_field_alter()`.
- Configure a title prefix, status handling, and exclusions at the settings form.
- Replace the outdated Node Clone workflow with a Layout Builder-aware equivalent.
- Let editors quickly spin off variants of an existing content item.
