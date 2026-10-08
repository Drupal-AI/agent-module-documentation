# book — agent start

Organizes nodes into hierarchical outlines ("books") with navigation, breadcrumbs,
table of contents and a printer-friendly export. Formerly Drupal core, now contrib.
Depends on core `node`. A book = a tree of nodes stored in the `book` outline table,
keyed by the top node's id (bid); managed by the `book.manager` service (max 9 levels).
Config lives in one object, `book.settings`. Provides 8 permissions.

- Configure allowed types, sort order, parent selector, settings form + routes → [configure/settings.md](configure/settings.md)
- Permissions and what each gates → [permissions/permissions.md](permissions/permissions.md)
- Call `book.manager` / `book.export` / outline storage in code → [api/services.md](api/services.md)
- Book navigation block, Book condition, book_node_selection reference handler → [plugins/blocks.md](plugins/blocks.md)
- Theme hooks & templates (navigation, tree, export, all-books block) → [theming/templates.md](theming/templates.md)

Submodules (nested):
- `book_olivero` → Olivero-theme styling/templates → [../../modules/book_olivero/3.0.x/agent/start.md](../../modules/book_olivero/3.0.x/agent/start.md)
- `book_content_type` → bundled "Book" content type → [../../modules/book_content_type/3.0.x/agent/start.md](../../modules/book_content_type/3.0.x/agent/start.md)
