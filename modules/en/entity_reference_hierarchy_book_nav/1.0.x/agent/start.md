<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Reference Hierarchy Book Navigation (entity_reference_hierarchy_book_nav) — agent index

Book-style navigation built from an **Entity Reference Hierarchy** field. Ships two context-aware
**blocks** (a table-of-contents tree and a previous/next block), two **content types** (`book`,
`book_chapter`), a multi-value field **`field_book_structure`** (type `entity_reference_hierarchy`,
target node), and one **service** that walks the structure. Package `Custom`. Core `^10 || ^11`.
Version 1.0.0. License GPL-2.0-or-later.

- **Depends on** the `entity_reference_hierarchy` contrib module (info.yml + field storage).
- **No** routes, permissions, config forms, config schema, Drush commands, or hooks.
- Installs config only: `node.type.book`, `node.type.book_chapter`, `field.storage.node.field_book_structure`,
  `field.field.node.book.field_book_structure` (+ a body field), in `config/install/`.

## What it provides

- Service **`entity_reference_hierarchy_book_nav.book`** → `src/Book.php` (`Book`): finds the book a
  node belongs to and computes prev/next pages. See [api/book-service.md](api/book-service.md).
- Block **`entity_reference_hierarchy_book_nav_book_contents_block`** ("Book Contents Block") and
  **`entity_reference_hierarchy_book_nav_book_navigation`** ("Book Navigation"), both extending
  `BookBlockBase` (`src/Plugin/Block/`). See [plugins/blocks.md](plugins/blocks.md).
- CSS library `entity_reference_hierarchy_book_nav/book_nav` (`css/book_nav.css`).

## Operate it

Install `entity_reference_hierarchy`, enable this module, point `field_book_structure` at the target
content types, add ordered child pages to a Book node, then place both blocks (they only render on
nodes that belong to a book). See [config/setup.md](config/setup.md).
