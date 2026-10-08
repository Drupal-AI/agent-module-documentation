The Book module lets editors tie any node content into a hierarchical outline — a tree of chapters, sections and sub-pages — with automatic navigation, breadcrumbs, next/previous/up links and a printer-friendly export. It was part of Drupal core through Drupal 10 and now ships as a contributed module.

---

A "book" is a set of nodes arranged in a parent/child tree, identified by the top node's id (the book id, or "bid"). Any content type you list under `book.settings.allowed_types` can be placed into a book outline, and one book can mix multiple content types. The hierarchy (up to 9 levels deep) is stored in a dedicated `book` outline table and managed by the `book.manager` service, which also builds the render arrays for navigation and the table of contents. Each book node gains an "Outline" tab (`/node/{node}/outline`) to place or move it, and administrators get a re-order UI at `/admin/structure/book/{node}`. The module supplies a "Book navigation" block (with modes for all pages / current book / current page and depth controls), a "Book" visibility condition, a `book_node_selection` entity-reference handler, book-aware breadcrumbs, book tokens, Views integration, and a printer-friendly export at `/book/export/html/{node}` that flattens a whole book (or subtree) into one document. Settings live in the single `book.settings` config object, edited at `/admin/structure/book/settings`. Eight permissions gate creating books, adding content, reordering, deleting, printing and administering. The `book_olivero` submodule adds Olivero-theme styling/templates; the bundled `book_content_type` module (from the project's test fixtures) pre-configures a dedicated "Book" content type.

---

- Build a multi-page online manual, handbook or user guide as a navigable outline.
- Publish product or software documentation with chapters, sections and sub-sections.
- Create an FAQ or knowledge base where articles nest under topic pages.
- Turn a set of existing nodes of any content type into a structured book outline.
- Add the "Book navigation" block to a sidebar so readers can jump around the current book.
- Show only the current book's pages (or only child pages) via the block's display modes.
- Give every book page automatic breadcrumbs reflecting its place in the hierarchy.
- Offer a printer-friendly, single-document version of an entire book or a subtree.
- Let editors re-order pages and rename outline titles from `/admin/structure/book/{node}`.
- Move a page (and its children) to a new parent using the node's Outline tab.
- Restrict which content types may participate in books via `book.settings.allowed_types`.
- Enforce that a child page's type is one of the allowed book types.
- Sort sibling pages by manual weight or automatically by title (`book_sort`).
- Provide a "Book" visibility condition to show/hide blocks on book pages only.
- Use the `book_node_selection` reference handler to reference only book nodes.
- List all books on the site at `/book` (gated by "access book list").
- Manage all book outlines from the admin overview at `/admin/structure/book`.
- Generate book-aware tokens (e.g. joined parent path) for titles, paths or metatags.
- Expose book relationships to Views via the module's `views_data` integration.
- Programmatically read a book tree, table of contents or a node's parents through `book.manager`.
- Add or remove a node from an outline in code with `updateOutline()` / `deleteFromBook()`.
- Present a curriculum or course with lessons ordered as book pages.
- Author a serialized novel or long-form work split across ordered pages.
- Build a site resource guide or wiki-style reference with cross-linked pages.
- Alter which nodes are selectable in book contexts via the `books` query tag (`hook_query_books_alter`).
- Style book navigation for the Olivero front-end theme with the `book_olivero` submodule.
- Bootstrap a ready-made "Book" content type using the bundled `book_content_type` module.
- Prevent uninstalling the module while book outlines still exist (uninstall validator).
