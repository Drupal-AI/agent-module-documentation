<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Book service — `entity_reference_hierarchy_book_nav.book`

Class `Drupal\entity_reference_hierarchy_book_nav\Book` (`src/Book.php`, `final`), registered in
`entity_reference_hierarchy_book_nav.services.yml` with one argument: `@entity_type.manager`. It is
the only service; the blocks depend on it.

## Methods

- `getBook(NodeInterface $node)` — returns the book node the given node belongs to, or `FALSE`.
  If `$node` is itself of type `book`, returns it directly. Otherwise runs a node entity query
  (`type = 'book'` AND `field_book_structure = $node->id()`, `accessCheck(TRUE)`) and loads the first
  match with `reset()`. The access check is applied to the book lookup.
- `nextPage(NodeInterface $book, NodeInterface $page)` — locates `$page->id()` among the book's
  `field_book_structure` deltas and delegates to `nextPageNotChapter($delta + 1, $book)`. If the page
  is the book node itself, starts at delta 0.
- `previousPage($book, $page)` — mirror of the above; delegates to
  `previousPageNotChapter($delta - 1, $book)`. Returns `FALSE` when the page is the book node itself.
- `nextPageNotChapter($id, $book)` / `previousPageNotChapter($id, $book)` — walk the
  `field_book_structure` list from `$id` forward/backward. For each item they load
  `$item->entity` and **skip** it when it is a `book_chapter` (unlinked heading) **or** when
  `!$page->access()` (the referenced node's view access is checked), continuing to the next/previous
  delta. Return the first eligible node. `previousPageNotChapter` returns the book node when the
  index falls below 0. A missing referenced entity (`!$page`) returns `FALSE`.

## Notes

- Ordering and depth come from the `entity_reference_hierarchy` field: iteration is over field deltas
  in stored order.
- Access is enforced per page during the walk, so prev/next never points at a node the visitor
  cannot view; chapter headings are transparently stepped over.
