<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Toolbar Edit Button - agent index

Moves the entity **Edit** local task into the admin **toolbar** on node/term canonical pages. Version **8.x-1.2**, core `^8 || ^9 || ^10`.

- Service `toolbar_edit_button.edit_button` (`ToolbarEditButtonService`) builds the toolbar item from local tasks + current route.
- No routes, no permissions, no config form. Attaches library `toolbar_edit_button/toolbar-edit-styling`.
- Only acts on `entity.node.canonical` and `entity.taxonomy_term.canonical`.