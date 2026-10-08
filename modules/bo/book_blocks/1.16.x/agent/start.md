<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Book Blocks — agent index

Four block plugins for core Book, rendering only on the current book page: Children, Navigation, Table
of Contents, and a combined configurable Edit block. Requires the **Book** module (core in D8–D10,
contrib in D11 — declare/enable it even though `book_blocks.info.yml` lists no explicit dependency;
services and blocks reference `Drupal\book\*`). No permissions, no settings page
(read-only navigation blocks).

- **The four blocks, the Edit block's settings, config schema, templates, cache contexts** →
  [configure/blocks.md](configure/blocks.md)

Key facts:
- Blocks (`src/Plugin/Block/`): `book_block_children` (Book Children Links), `book_block_navigation`
  (Book Navigation Links), `book_block_toc` (Book Table of Contents), `book_block_edit` (Book Edit
  Links). All extend `BookBlocksBlockBase` and act on the current node's `book['bid']`.
- Only `book_block_edit` has a config form (schema `block.settings.book_block_edit`): `css`,
  `icons`, `toc`, `nav`, `add_sibling`, `left_link`/`middle_link`/`right_link` (`name`/`url`/`hint`).
- Services: cache contexts `route.book_block_toc` and `route.book_block_navigation`
  (both `Drupal\book\Cache\BookNavigationCacheContext`).
- Templates + preprocess (`.module`): `book_blocks_navigation`, `book_blocks_edit`,
  `book_blocks_children`; expose `book_id/title/url`, prev/parent/next links + `rel` head links, and the
  children tree (`book.outline` / `book.manager` services).
