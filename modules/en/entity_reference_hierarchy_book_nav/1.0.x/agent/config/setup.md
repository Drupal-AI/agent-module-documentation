<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Setup, content model, and installed config

No settings form and no config schema — the module ships default content model config in
`config/install/` and is operated through the block layout UI.

## Install / enable

- Requires the `entity_reference_hierarchy` contrib module (declared in `.info.yml` as
  `entity_reference_hierarchy:entity_reference_hierarchy`; the field storage also depends on it and
  on core `node`). `composer require` is empty, so install the dependency separately.
- Enabling creates the content types and field below (skipped if same-named config already exists).

## Installed config (`config/install/`)

- `node.type.book` (label "Book") — the container node type. Also gets a `body` field
  (`field.field.node.book.body.yml`).
- `node.type.book_chapter` (label "Book Chapter") — used for unlinked heading pages in the tree.
- `field.storage.node.field_book_structure` — field name `field_book_structure`, type
  `entity_reference_hierarchy`, `target_type: node`, `cardinality: -1` (unlimited), translatable.
- `field.field.node.book.field_book_structure` — attaches the field to the `book` bundle, label
  "Book structure", handler `default:node`, default `target_bundles: { book_chapter }`.

## Operating it

1. On the Book content type's `field_book_structure` field, set the allowed **target bundles** to the
   content types you want inside books (default is only `book_chapter`).
2. Create a Book node and add/order child nodes in the Book structure field; use the hierarchy
   widget's depth to create nesting. Use `book_chapter` nodes for unlinked section headings.
3. Place **Book Contents Block** and **Book Navigation** in your block layout (category "Book").
   Because both require a node context and check `getBook()`, they render only on nodes that belong
   to a book and are empty elsewhere.

## Caching

Blocks vary by `url.path` and `languages` (merged with default block contexts) and set
`max-age = 1`, so the tree and prev/next links are recomputed per request rather than cached
long-term. The CSS library `entity_reference_hierarchy_book_nav/book_nav` (`css/book_nav.css`) is
attached when a block renders.
