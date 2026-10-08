<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Blocks

Two block plugins in `src/Plugin/Block/`, both `final`, both extending `BookBlockBase`.

## `BookBlockBase` (`BookBlockBase.php`, abstract)

- Implements `ContainerFactoryPluginInterface`; `create()` injects the
  `entity_reference_hierarchy_book_nav.book` service (`Book $book`).
- `build()` reads the node from block context (`getContextValue('node')`), returns `[]` if none,
  calls `$this->book->getBook($node)`, returns `[]` if the node is not in a book, else calls the
  abstract `bookBuild(&$build, $node, $book)` (implemented by each subclass).
- `getCacheContexts()` = parent contexts merged with `['url.path', 'languages']`.
- `getCacheMaxAge()` returns `1` — the blocks are effectively re-rendered per request, so access is
  re-evaluated each time rather than served from a long-lived cache entry.
- Both subclasses declare `context_definitions = { "node" = @ContextDefinition("entity:node") }`, so
  they only appear/render in a node context, and `category = "Book"`.

## `BookContentsBlock` (id `entity_reference_hierarchy_book_nav_book_contents_block`)

- Admin label "Book Contents Block". Builds a nested table of contents.
- `bookBuild()`: renders the book title as a linked `<h3>` (when the book is not new), then iterates
  `field_book_structure`. It tracks `$structure->depth` against a running `$level` to push/pop a
  `$parents` stack, assembling a parent/child `$items` tree. For each item it checks
  `$node->access()`; only accessible nodes contribute a `title` (`$node->label()`), and only
  non-`book_chapter` nodes get a `link` (`$node->toUrl()`), so chapters render as unlinked headings.
- `buildList()` recursively converts `$items` into `#theme => 'menu'` item arrays (`title`, `url`,
  `attributes`, and `below`/`is_expanded` for children). Output is wrapped in a `<nav>` themed as
  `menu` with class `book-contents`, attaching the `entity_reference_hierarchy_book_nav/book_nav`
  library. Titles flow through the menu theme (escaped) and links via `Url`/`toUrl()`.

## `BookNavigationBlock` (id `entity_reference_hierarchy_book_nav_book_navigation`)

- Admin label "Book Navigation". Builds Previous/Next section links.
- `bookBuild()`: calls `$this->book->previousPage($book, $page)` and `nextPage($book, $page)`. Each
  result (when truthy) becomes a `toLink('Previous Section'|'Next Section')->toRenderable()` with the
  target node's label set as `title` and `aria-label`. Wrapped in `container` render elements with
  classes `book-navigation-previous` / `book-navigation-next`; attaches the `book_nav` library.
