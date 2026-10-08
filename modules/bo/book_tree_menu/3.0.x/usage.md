<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Book Tree Menu turns core Book's navigation into a full, always-expandable tree menu, so readers can open and close any branch of a book from any page instead of having to visit a parent page first.

---

Core's Book module builds hierarchical documentation, but its navigation only expands the branch of the page you are currently on — to reveal children in a different submenu you must first navigate to that parent. Book Tree Menu removes that limitation. It swaps the `book.manager` service class (via a service provider) for `oscBookManager`, whose `bookTreeAllData()` loads the entire book outline at every depth rather than just the active trail, and it replaces core's `book-tree.html.twig` with a template that emits expand/collapse (Bootstrap `dropdown`/`caret`) markup so any submenu can be toggled client-side.

There is nothing to configure and no new block to place: the enhanced tree renders through core Book's own "Book navigation" block, which you enable/place as usual. Clicking a parent item in the tree toggles its submenu rather than navigating away, which suits handbook-style books where parent pages are just containers. Node access is unchanged — the tree is still access-checked per item, so users only see pages they may view. It depends on the contrib Book module (`drupal/book` ^2.0) and is only useful on sites that use books; it sits alongside alternatives like `custom_book_block` as one take on "core book navigation is not enough". For big books, confirm the fully-expanded tree is the reader experience you want, since the whole outline is loaded.

---

- Render a book's whole outline as a tree menu.
- Let readers expand or collapse any book branch from any page.
- Stop forcing users to visit a parent page to reveal its children.
- Improve navigation for handbook and documentation sites built on Book.
- Show the full book hierarchy alongside the current page.
- Let readers see where they are within the larger book structure.
- Toggle a submenu without navigating to its container page.
- Replace core Book's collapse-on-active-trail navigation behavior.
- Override core's `book-tree.html.twig` with expandable tree markup.
- Swap the `book.manager` service for a full-tree implementation.
- Provide whole-of-book wayfinding from every page.
- Jump directly between distant sections of a book.
- Display deeply nested book pages as one navigable tree.
- Present book navigation with Bootstrap-style dropdown markup.
- Keep node access enforced while showing the full outline.
- Style the tree via emitted `dropdown`/`dropdown-menu`/`caret` classes.
- Re-theme the tree by overriding the `book_tree` template in your theme.
- Use core Book's "Book navigation" block to surface the enhanced tree.
- Build long-form documentation with better reader navigation.
- Enable richer book traversal without writing custom code.
