Entity Reference Hierarchy Book Navigation turns a nested Entity Reference Hierarchy field into a book-style table of contents block and previous/next navigation block for the pages of a "book".

---

The module ships a `Book` content type and a `Book Chapter` content type plus a multi-value `field_book_structure` field of type `entity_reference_hierarchy` (target: node). Editors add and order child nodes under a Book, and the hierarchy widget records each item's depth. Two context-aware blocks then read that structure whenever the visitor is on a node that belongs to a book: the "Book Contents Block" renders the whole ordered tree as a nested menu (linking to each referenced page, but rendering `book_chapter` items as unlinked headings), and the "Book Navigation" block renders "Previous Section" / "Next Section" links relative to the current page. A small `Book` service (`entity_reference_hierarchy_book_nav.book`) does the work: it finds the book that references a given node, and walks `field_book_structure` forward/backward — skipping chapter headings and pages the visitor cannot access — to compute the adjacent pages. It requires the `entity_reference_hierarchy` contrib module and needs no configuration beyond placing the two blocks and pointing the field at the content types you want inside books.

---

- Build a documentation/handbook site where each Book node aggregates ordered child pages.
- Provide a sidebar table of contents that appears automatically on every page inside a book.
- Add "Previous Section" / "Next Section" links to the bottom of book pages for linear reading.
- Group pages under unlinked chapter headings using the `Book Chapter` content type.
- Create multi-level (nested) navigation trees by using the hierarchy field's depth per item.
- Reuse existing content types inside a book by adding them to the field's allowed target bundles.
- Order pages manually via the entity-reference-hierarchy widget instead of by publish date.
- Show a clickable outline of a policy manual, course, or product guide.
- Give long-form content a wiki-like "book" structure without core's Book module.
- Place the contents block in a sidebar region and the navigation block in the content footer.
- Let the same node appear in a book and drive its own prev/next context.
- Restrict which content types can be added to a book via the field's target-bundle settings.
- Localize book navigation, since the blocks vary their cache by language.
- Present a table of contents that automatically hides pages the current user cannot view.
- Add pagination-style reading flow to knowledge-base articles.
- Build an onboarding guide as a book with chapters and sequential steps.
- Assemble release notes or changelog entries into an ordered, navigable book.
- Give editors a single Book node to curate the order of many existing pages.
- Render a nested outline as a themed `menu` element so it inherits menu styling.
- Ship a lightweight "next/previous" widget without installing a heavier navigation suite.
- Use the bundled CSS library (`entity_reference_hierarchy_book_nav/book_nav`) to style the nav.
- Model a multi-chapter tutorial where chapters are headings and lessons are linked pages.
- Provide breadcrum-adjacent linear navigation for structured reference material.
