Book Organizer gives Drupal core's Book module a Views-powered hierarchical overview at /admin/content/book-organized, with bulk book-level publish, unpublish and delete operations.

---

Book Organizer replaces the flat core book admin list with a hierarchy-aware table: every top-level book is shown as a collapsible section with its child pages indented beneath it, standalone (non-book) nodes are listed and clearly marked, and the standard Views title/status/language exposed filters plus a per-book in-page search box let you narrow results. Books with more than twenty pages lazy-load their children over an AJAX/JSON endpoint so large books stay responsive. Each book exposes an operations dropbutton for editing and viewing pages, launching core's "Order pages" outline UI, adding a child page, and running book-wide publish, unpublish or delete through the Batch API. Access to the overview and the AJAX route is gated by a single restricted permission, "administer book organizer", while every individual page action and every batched node still respects normal node view/update/delete access. The module is a thin management layer over core Book—it does not itself reorder pages or reparent nodes; the "Order pages" link hands off to core's book.admin_edit form.

---

- Browse all books grouped by their top-level structure at /admin/content/book-organized (also reachable as Content → Books (Organized)).
- See each book's child pages indented under it in a single hierarchy table instead of a flat node list.
- Filter the whole overview by title, publication status, or language using the Views exposed filters.
- Search within a single expanded book using the per-book in-page search box (client-side title filter).
- Collapse or expand individual book sections; the open/closed state persists per book in the browser via localStorage.
- Use the "Expand all"/"Collapse all" toggle to open or close every book section at once.
- Lazy-load the children of very large books (more than 20 pages) on demand rather than rendering them all up front.
- Publish an entire book and all of its pages in one confirmed, batched operation.
- Unpublish an entire book and all of its pages in one confirmed, batched operation.
- Rely on the state-aware toggle that shows "Publish the book and its children" or "Unpublish the book and its children" depending on the book's current status.
- Delete a book together with all of its child pages, processed child-first through the Batch API so parents are removed only after their children.
- Confirm every destructive book-wide action on a standard Drupal confirm form before it runs.
- Add a new child page directly under a book, pre-parented to that book, when your role can add content to books.
- Jump straight to core Book's "Order pages" outline editor for a book from its operations menu.
- Edit or view any individual book page from its per-row operations dropbutton.
- Keep standalone book-type nodes (not part of any hierarchy) visible in the overview, clearly labelled.
- See per-book page counts and published/unpublished tallies computed in batched queries.
- Grant editors curated access to the organizer and its book-level operations with the single "administer book organizer" permission.
- Ensure batched operations skip any page the acting user lacks permission to delete or edit, with a summary warning of how many were skipped.
- Extend the underlying book_organized view (add fields, filters, or displays) through the normal Views UI.
