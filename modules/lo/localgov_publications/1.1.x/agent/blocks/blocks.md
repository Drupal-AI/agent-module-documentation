# Blocks

Three block plugins, each taking an `entity:node` context ("Current node"). All are placed by the
shipped config in `config/localgov/` (region placements for the LocalGov theme):
`block.publication_navigation.yml`, `block.publication_in_page_navigation.yml`,
`block.publication_page_header_block.yml`.

| Block id | Class | Renders |
|---|---|---|
| `publication_navigation` | `Plugin/Block/PublicationNavigationBlock` | The in-publication page tree (links to sibling/child pages) for the current node's book. |
| `localgov_publications_toc_block` | `Plugin/Block/TocBlock` | An in-page table of contents: jump links to the current page's own `h2` headings. |
| `localgov_publications_page_header_block` | `Plugin/Block/PublicationPageHeaderBlock` | The publication title (+ current page title when on a child), published date and last-updated date. |

## publication_navigation

A trimmed copy of core's `BookNavigationBlock` implementing only the in-book tree (not the "all books"
mode), and it also renders on unpublished nodes the viewer can access. `build()` calls
`book.manager` `bookTreeAllData($node->book['bid'], $node->book)`, then invokes
`hook_localgov_publications_menu_tree_alter(&$tree)` (module + theme). If the top level has no children
(single-page publication) it returns empty. Access filtering of the tree is core Book's
`bookTreeOutput()`. `getCacheMaxAge()` is 0 (uncacheable). Active-trail items get an `active` class.

## localgov_publications_toc_block

`build()` renders the current node's **full** view mode to HTML (`renderer->renderRoot`, after
`Html::resetSeenIds()` so ids match the page), passes the markup to the `localgov_publications.heading_finder`
service, and outputs the returned `h2` anchor links as an `item_list`. Returns empty on a new (unsaved)
node or when no linkable `h2` is found. Depends on the `localgov_publications_heading_ids` filter
having added `id` attributes to the headings (see [../configure/publications.md](../configure/publications.md)).

## localgov_publications_page_header_block

Uses `localgov_publications.publication_manager` `getTopLevel($node)` to find the publication root, then
themes `localgov_publication_page_header_block` with the root title, the current page title (only when
not the root), and `localgov_published_date` / `localgov_updated_date` from the root formatted `j F Y`.
Cache metadata from both the node and root node is applied.

## Related theming

- `localgov_publications_block_access()` **forbids** the LocalGov core `localgov_page_header_block`
  from showing on publication nodes (this module's own header block replaces it).
- `hook_theme()` registers `book_navigation__publication` (template
  `book-navigation--publication.html.twig`, added as a theme suggestion on publication pages via
  `hook_theme_suggestions_book_navigation`), plus `localgov_publication_page_header_block`,
  `paragraph__localgov_publications_banner`, `media__document__publication`, and
  `field__localgov_publication` (template `publication-html-reference.html.twig`).
- Full-view publication nodes attach the `localgov_publications/localgov-publications` library.
