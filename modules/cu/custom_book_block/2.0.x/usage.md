<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Custom Book Block provides a single, more configurable book-navigation block, letting each placement choose which book to show, where in the tree to start, how deep to go, and whether to force the whole tree open.

---

Core's Book module ships one navigation block whose behaviour is essentially fixed. Documentation and handbook sites frequently want more: show only the current chapter, begin the tree at a chosen depth, cap how deep it renders, or keep the full outline expanded regardless of the active page. Custom Book Block adds one block plugin, `custom_book_navigation`, that extends the core block with four extra settings (`target_book`, `start_level`, `max_levels`, `always_expand`) alongside core's `block_mode`. To make the start-depth and always-expanded options possible it also replaces the `book.manager` service class with a subclass (`ExpandBookManager`) whose `bookTreeAllData()` accepts a minimum depth and an expand flag.

Everything is per placement — there is no global settings page, no permissions, and no drush commands. It depends only on the Book module (contrib `drupal/book ^2.0` on Drupal 10.3+/11). Because it works by overriding `book.manager` site-wide, it can conflict with other modules that reclass the same service; when that happens the block simply renders nothing. It is read-only navigation and respects book/node view access and published status, so scoping is the main thing to verify per placement.

---

- Place a configurable book navigation block in a region.
- Show navigation for only the current book (dynamic detection).
- Show navigation for one specific book by node id.
- Show all books' navigation in a single block.
- Start the book tree at a chosen depth.
- Limit book navigation to a maximum number of levels.
- Render only the top-level book node (max levels = 1).
- Force the entire book tree to render expanded.
- Expand only the active trail instead of the whole tree.
- Restrict the block to book pages only.
- Show the block on all pages.
- Scope book navigation differently per placement.
- Replace core's fixed book navigation block.
- Build a table-of-contents sidebar for a handbook site.
- Navigate deep, multi-level book hierarchies.
- Show a book subtree rather than the whole outline.
- Match navigation depth to the shape of the documentation.
- Handle a site with several separate books.
- Reuse the extended book.manager (`ExpandBookManager`) in custom code.
- Request a min-depth book tree via `bookTreeAllData()`.
- Keep book navigation aligned with node/book access.
- Provide adjustable book menus without custom theming.
- Improve wayfinding on long-form documentation.
- Detect and display the book of the page being viewed.
