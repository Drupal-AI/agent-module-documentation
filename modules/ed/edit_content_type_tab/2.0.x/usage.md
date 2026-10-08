<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Edit Content Type Tab presents users with a tab to edit the content type of the current node.

---

Edit Content Type Tab adds a local task (tab) that lets users change the **content type (bundle)** of
the current node — converting a node from one content type to another in place, for cases where content was
created under the wrong type. It is in the Development package.

Use it to re-bundle nodes. **Security/operational caution: changing a node's content type is a powerful,
potentially destructive operation** — it can drop/remap fields (data loss if the target type lacks fields),
and it is not a routine editorial action. So restrict this tab to **trusted administrators** (the operation
should be gated tightly), test on non-critical content first, and back up before bulk conversions. It relies
on the route's access; ensure that access is limited to trusted roles. It has no dedicated access-control
role. Enable the tab where re-bundling is needed.

---

- Add a tab to change a node's content type.
- Convert a node between bundles.
- Re-bundle content in place.
- Fix content created under the wrong type.
- CAUTION: content-type change is powerful/destructive.
- Understand it can drop/remap fields (data loss).
- Restrict the tab to trusted administrators.
- Gate the operation tightly.
- Test on non-critical content first.
- Back up before bulk conversions.
- Limit route access to trusted roles.
- Have no dedicated access-control role.
- Enable where re-bundling is needed.
- Handle content-type editing.
- Convert node types.
- Change bundles carefully.
- Handle re-bundling.
- Restrict the tab.
- Change content types.
- Convert content.
