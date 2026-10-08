# book permissions

Defined in `book.permissions.yml` (8 permissions).

| Permission | Gates | Notes |
|---|---|---|
| `administer book outlines` | The all-books admin overview (`/admin/structure/book`), per-book re-order (`/admin/structure/book/{node}`) and child-ordering forms. | |
| `create new books` | Starting a new top-level book from a node. | |
| `add content to books` | "Add content and child pages to books and manage their hierarchies" — placing/moving nodes in an outline via the node Outline tab. | |
| `reorder book pages` | Re-ordering child pages of a book. | |
| `access printer-friendly version` | Viewing a book page + all sub-pages as one printable document (`/book/export/html/{node}`). | Description warns it can be performance-heavy. |
| `access book list` | The list of all books at `/book` (`book.render`). | |
| `delete book` | Deleting an entire book (`/admin/structure/book/delete/{book_id}`). | |
| `administer book settings` | The settings form (`/admin/structure/book/settings`). | `restrict access: true`. |

`delete book` and `administer book settings` are flagged `restrict access: true`
(security-sensitive). The Outline/remove/print/export routes combine these
permissions with custom access checks: `_access_node_book_outline`
(`BookNodeOutlineAccessCheck`), `_access_book_removable`
(`BookNodeIsRemovableAccessCheck`) and `_access_node_book_print`
(`BookNodePrintAccessCheck`).

Grant to a role via Drush:

```bash
drush role:perm:add editor 'add content to books'
drush role:perm:add editor 'reorder book pages'
```
