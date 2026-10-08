<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Book Visibility adds a block-visibility condition (plugin id "book") that shows or hides a block based on which core Book the current node belongs to.

---

Book Visibility enhances the core Book module by supplying one Condition plugin — `BookVisibility` (id `book`), extending `ConditionPluginBase` — that appears as a new "Book" tab on the core block configuration form (`/admin/structure/block`). A site builder checks one or more books; the block then renders only on node pages whose `book['bid']` matches a selected book. It is a presentation/visibility feature in the Book package: it decides whether a *block* is placed on the page, not who is allowed to read the book content. Book-page access is still governed entirely by core node access (the `access content` permission and Book's own routes) — this module adds no access control, no routes, and no permissions. The core Book module was deprecated in Drupal 10.3, so this module is mainly relevant to sites still on older core or the pre-deprecation Book module.

---

- Show a block only on pages inside a specific book.
- Restrict a book-navigation block to one or a few chosen books.
- Hide a promotional/sidebar block on all book pages except selected books.
- Vary which blocks appear as a visitor moves between different books.
- Place a "table of contents" block only within a documentation book.
- Combine book-scoping with core block placement (region, theme) as usual.
- Use the negate option on the condition to show a block on every page *except* the chosen books.
- Scope a call-to-action block to a product-manual book only.
- Keep a help block visible only within a help book.
- Add book context to blocks without writing a custom condition plugin.
- Configure everything from the standard block UI — no dedicated admin page.
- See a "The block is restricted to specific books" / "Not restricted" summary on the block form's vertical tab.
- Leave the condition unchecked to impose no book restriction (block shows normally).
- Target multiple books at once by checking several boxes.
- Apply per-book visibility to any block type (system, views, custom).
- Migrate legacy per-book block logic from custom code to a supported condition plugin.
- Use on Drupal 8/9/10/11 sites that still rely on the core Book module.
- Complement core node-access controls for book content (this module does not replace them).
