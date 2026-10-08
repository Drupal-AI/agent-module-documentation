# Block: Custom book navigation

Plugin id `custom_book_navigation` — class
`Drupal\custom_book_block\Plugin\Block\CustomBookNavigationBlock`, extends core
`Drupal\book\Plugin\Block\BookNavigationBlock`. Admin label "Custom book navigation",
listed in block category **Menus**. It renders a book's navigation tree (a table of
contents) with more placement controls than core's block.

## Settings

Set on the block placement form (`blockForm()`); saved by `blockSubmit()` into the block's
`settings`. `block_mode` is inherited from the core parent; the rest are added here.

| Setting | Type | Default | Effect |
| --- | --- | --- | --- |
| `block_mode` | radios (inherited) | `all pages` | Core option. `all pages` = render every book's tree (subject to `target_book`); any other value = only render the current book's subtree, and only on a book page. |
| `target_book` | radios | `''` | `''` = show all books. `dynamic` = auto-detect the book of the current route node. A specific book **nid** = only that book. Options are built from `bookManager->getAllBooks()`. |
| `max_levels` | number, min 0 | `''` | Maximum tree depth (passed as `max_depth`). `0`/empty = all levels. `1` = only the top-level book node (fast path, no tree query). |
| `start_level` | number, min 1 | `1` | Minimum depth (passed as `min_depth`). When `> 1`, the tree is filtered to the active branch via a `p{start_level}` condition on the current link. |
| `always_expand` | checkbox | `1` | Checked = the whole tree is rendered expanded (`expanded => []`). Unchecked = expand only the active trail (core-like "expanded in context"). |

Defaults come from `defaultConfiguration()`:
`target_book => ''`, `start_level => 1`, `max_levels => ''`, `always_expand => 1`
(plus the inherited `block_mode => 'all pages'`).

## Runtime behavior (`build()`)

- Guards that the active `book.manager` is an `ExpandBookManager` (or its proxy); if some other
  module has reclassed the service, `build()` returns `[]`. See
  [api/expand_book_manager.md](../api/expand_book_manager.md).
- Reads the current book id from the route `node` parameter (`$node->book['bid']`).
  If `target_book === 'dynamic'`, the target resolves to that current book id.
- **`block_mode` = `all pages`:** iterates every book from `getAllBooks()` sorted by weight
  (`SortArray::sortByWeightElement`), skipping any that do not match `target_book`.
  For `max_levels == 1` it loads just the book node and renders a single-item pseudo-tree
  (setting `access` from `$book_node->access('view')`); otherwise it calls
  `bookTreeAllData($book_id, $book, $max_levels, $start_level, $always_expand)` then
  `bookTreeOutput()`, and marks the active book's item `in_active_trail`. Output uses the
  `#theme => 'book_all_books_block'` (from core Book).
- **Otherwise (a book page):** if `target_book` is set and differs from the current book, returns
  `[]`. It entity-queries the top book node with `accessCheck(TRUE)` + `status = PUBLISHED`
  (so unpublished books are hidden), then builds `bookTreeAllData(...)`, drops the top element,
  and returns `bookTreeOutput()` of its `below` subtree.

Access: only view-accessible, published links appear — `ExpandBookManager::buildItems()` skips any
link whose `access` is false, and core's `bookTreeCheckAccess()` runs during tree build.

## Place / configure it (drush or PHP)

There is no global settings form or `configure` route; each placement is a `block` config entity.
Create one with drush config or PHP, e.g.:

```php
use Drupal\block\Entity\Block;

Block::create([
  'id' => 'custombooknav',
  'theme' => 'olivero',
  'region' => 'sidebar',
  'plugin' => 'custom_book_navigation',
  'settings' => [
    'id' => 'custom_book_navigation',
    'label' => 'Book navigation',
    'label_display' => '0',
    'provider' => 'custom_book_block',
    'block_mode' => 'book pages',
    'target_book' => 'dynamic',
    'max_levels' => 3,
    'start_level' => 1,
    'always_expand' => 0,
  ],
  'visibility' => [],
  'weight' => 0,
])->save();
```

## Config schema note

The module ships **no** `config/schema`. The added settings save under core's generic
`block.settings.*` fallback (there is no `block.settings.custom_book_navigation` type), so the
extra keys are stored but not individually typed. This is why `data.json` reports
`provides_config_schema: false`. Values are plain scalars, so this has no runtime effect here.
