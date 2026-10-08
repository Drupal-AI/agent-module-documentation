# book plugins (blocks, condition, reference handler)

Book does not define new plugin *types*; it provides plugins of core types.

## Block: `book_navigation`

`\Drupal\book\Plugin\Block\BookNavigationBlock` — admin label "Book navigation",
category "Menus". Renders the outline tree for the current context. Place it via
Block layout or a `block` config entity. Settings (schema
`block.settings.book_navigation`):

| Setting | Values / default | Effect |
|---|---|---|
| `block_mode` | `all pages` \| `book pages` \| `primary book page` \| `child book pages` | Which books/pages to show. `all pages` lists every book; the others scope to the current book/page. |
| `show_top_item` | bool | Include the top-level book page in the tree. |
| `use_top_level_title` | bool | Use the top page's title as the block title. |
| `starting_level` | int 1–9 | First depth level rendered. |
| `max_depth` | int 0–9 | How deep the tree renders (0 = unlimited within limits). |
| `book_select` | int | Which book to show (for scoped modes). |
| `expanded` | bool | Render the tree fully expanded. |

## Condition: `book`

`\Drupal\book\Plugin\Condition\Book` — id `book`, label "Book". Context: a `node`
entity. Use as a block/layout visibility condition to target book pages (and,
via config, specific books).

## Entity-reference selection: `default:book_node_selection`

`\Drupal\book\Plugin\EntityReferenceSelection\BookSelection` (extends core
`NodeSelection`). Choose handler **"Book node selection"** on an entity-reference
field to reference nodes; it adds the `books` query tag to the selection query
(alterable via `hook_query_books_alter`).
