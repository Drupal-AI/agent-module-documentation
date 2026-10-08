<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# custom_book_block (Custom Book Block) — agent index

A more configurable replacement for core Book's navigation block. Provides ONE block plugin,
`custom_book_navigation`, that adds per-placement controls: which book to show, the start depth,
the max depth, and whether to force-expand the whole tree. To support those controls it also
swaps core's `book.manager` service for a subclass (`ExpandBookManager`) that can build a
min-depth / always-expanded tree.

Dependencies: core/contrib **Book** (`book:book`; composer `drupal/book ^2.0`). Core `^10.3 || ^11`.
No settings page — configuration is per block instance (block settings form). No permissions,
drush commands, hooks, or config schema of its own.

- **Place / configure the block and its settings** → [blocks/custom_book_navigation.md](blocks/custom_book_navigation.md)
- **Understand / reuse the overridden `book.manager` service** → [api/expand_book_manager.md](api/expand_book_manager.md)

Key facts:
- Block plugin id `custom_book_navigation` (admin_label "Custom book navigation", category "Menus");
  class `Drupal\custom_book_block\Plugin\Block\CustomBookNavigationBlock` extends core `BookNavigationBlock`.
- Block settings: `block_mode` (inherited: `all pages` | `book pages`), `target_book`
  (`''`=all books, `dynamic`=auto-detect, or a book nid), `max_levels`, `start_level`, `always_expand`.
- Service override: `book.manager` reclassed to `Drupal\custom_book_block\ExpandBookManager` in
  `Drupal\custom_book_block\CustomBookBlockServiceProvider::alter()`; lazy proxy
  `Drupal\custom_book_block\ProxyClass\ExpandBookManager`.
- No `*.routing.yml`, `*.permissions.yml`, `*.services.yml`, `config/`, `*.module`, `*.install`, or drush files.
