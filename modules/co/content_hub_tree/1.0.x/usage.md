<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Content Hub Tree adds an admin content-overview screen that lists nodes in a menu-tree structure instead of the flat core Content view.

---

Content Hub Tree provides an alternative content administration screen. Where the core Content
list (Admin → Content) is a flat table, this module renders a "Content tree" that follows the
parent-child shape of a chosen menu: each menu link that points at a node becomes a row showing
that node's title, content type, published status, author and updated date, nested under its
parent link. It depends on core Menu Link Content, which supplies the menu links it reads.

You opt a menu in with an "Include in Content tree" checkbox on the menu's edit form. Each
opted-in menu then gets a "Content tree" tab under Admin → Content. The screen is reached at
`/admin/content/content-tree/{menu}` and requires the "administer menu" permission. From it you
can jump between opted-in menus, edit or delete the referenced nodes via each row's operations,
and run node bulk operations (the same node actions available on the core content view) against
selected rows. Menu links that do not resolve to a node still appear in the tree but are shown
as plain menu links.

---

- Show content as a tree that mirrors a menu's hierarchy.
- Offer an alternative to the flat Admin → Content list.
- Opt a menu in with an "Include in Content tree" checkbox.
- Add a "Content tree" tab under Admin → Content per opted-in menu.
- Require the "administer menu" permission to open the screen.
- Map menu links that point at nodes to node rows.
- Show node title, type, status, author and updated columns.
- Reuse the "content" view's field settings when that view exists.
- Provide node bulk operations on selected rows.
- Offer per-row edit/delete operations for referenced nodes.
- Collapse and expand branches of the tree.
- Switch between opted-in menus with a select dropdown.
- Display non-node menu links as plain menu links.
- Depend on core Menu Link Content.
- Add no dedicated settings form.
- Base the tree structure on the chosen menu.
