<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions

`toc_js_per_node.permissions.yml` defines one permission:

- **`administer toc_js per node`** — "Administer Toc.js per node": enable/disable the table of
  contents per node.

The per-node "Display a table of contents" checkbox on the node add/edit form is shown when the user
has `administer toc_js per node` **or** core's `administer nodes`
(`hasPermission('administer toc_js per node') || hasPermission('administer nodes')`). Without either,
the node's `toc_js_active` value is passed through unchanged (as a hidden value) rather than editable.
