<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Book Blocks adds four configurable blocks for Drupal's Book module — Children, Navigation, Table of Contents, and a combined Edit block — that operate on the book page currently being viewed.

---

The module augments core Book's built-in blocks with four block plugins that only render on a book
page (they read the current node's `book` outline data and hide on non-book content). "Book Children"
(`book_block_children`) lists the child pages of the current page; "Book Navigation"
(`book_block_navigation`) reproduces the prior/up/next links from the page bottom; "Book Table of
Contents" (`book_block_toc`) renders the book's TOC including a link to the top page; and "Book Edit"
(`book_block_edit`) is the most configurable — it combines navigation, TOC and edit links with options
for a display style (CSS class preset), icons-vs-text, whether to include the TOC and nav sections, and
a customizable "Add sibling page" link, plus configurable left/middle/right links (the left link
defaults to a `/book-index/{{ book_id }}` View path). Blocks are placed via the block UI or Layout
Builder and use book-navigation cache contexts (`route.book_block_toc`, `route.book_block_navigation`).
Templates (`book-blocks-navigation`, `book-blocks-edit`, `book-blocks-children`) are preprocessed to
expose book id/title/url, prev/parent/next links, and the children tree, and to emit `rel=prev/up/next`
head links. Requires the Book module (core in D8–D10, contrib in D11); no permissions or settings page
of its own. The TOC block pairs well with Collapsiblock for expand/collapse (the Edit block has this
built in without that module).

---

- Add a "child pages" list block to book/documentation pages.
- Add a prior/up/next navigation block to book pages.
- Add a Table of Contents block (with a link to the book's top page).
- Add a combined Edit block with TOC, navigation and edit links in one place.
- Show a customizable "Add sibling page" link for editors on book pages.
- Provide quick links to create/edit sibling and child book pages.
- Choose icons instead of text for the Edit block's controls.
- Toggle whether the Edit block includes the TOC and/or navigation sections.
- Pick a display-style CSS preset for the Edit block.
- Configure custom left/middle/right links (e.g. a book index View at `/book-index/{{ book_id }}`).
- Emit `rel=prev/up/next` head links for book pages for SEO/browser navigation.
- Restrict book navigation blocks so they only appear on book content.
- Build a documentation site layout with sidebar TOC and inline navigation.
- Use the Children block to surface subsections on section landing pages.
- Combine with Collapsiblock for a collapsible Table of Contents.
- Place book blocks in Layout Builder regions per content type.
- Give readers consistent prev/next navigation across a multi-page book.
- Replace or supplement core Book's default blocks with configurable ones.
- Provide an editor-facing quick-edit toolbar on each book page.
- Link back to a list of all books from within a book page.
