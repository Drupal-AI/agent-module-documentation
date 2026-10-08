# book API — services

Services from `book.services.yml`. The main entry point is **`book.manager`**
(`\Drupal\book\BookManagerInterface`, autowirable by interface).

## book.manager — BookManagerInterface

Key public methods:

| Method | Purpose |
|---|---|
| `getAllBooks(): array` | All top-level books on the site. |
| `loadBookLink(int $nid, bool $translate = TRUE): array` | The book-outline link row for a node (bid, pid, weight, depth, p1..p9, has_children…). |
| `loadBookLinks(array $nids, bool $translate = TRUE): array` | Batch version. |
| `bookTreeAllData(int $bid, ?array $link = NULL, ?int $max_depth = NULL, ?int $min_depth = NULL, bool $expanded = FALSE): array` | Full nested tree data for a book. |
| `bookSubtreeData(array $link): array` | Data for the subtree under a link. |
| `bookTreeOutput(array $tree): array` | Render array for a tree. |
| `bookTreeGetFlat(array $book_link): array` | Flattened link list. |
| `getTableOfContents(int|string $bid, int $depth_limit, array $exclude = [], bool $truncate = TRUE): array` | Options list for a TOC/parent selector. |
| `getBookParents(array $item, array $parent = []): array` | Materialized p1..p9 parent path for a link. |
| `getActiveTrailIds(string $bid, array $link): array` | Active trail for breadcrumbs/navigation. |
| `updateOutline(NodeInterface $node): bool` | Add/update a node in its book outline (reads `$node->book`). |
| `saveBookLink(array $link, bool $new): array` | Low-level insert/update of an outline link. |
| `deleteFromBook(int $nid): void` | Remove a node (and fix the outline). |
| `checkNodeIsRemovable(NodeInterface $node): bool` | Whether a node can be removed from its book. |
| `addFormElements(...)` | Inject the book-outline form elements onto a node form. |
| `getLinkDefaults(int|string $nid): array` | Default link values for a new outline entry. |

Example:

```php
$manager = \Drupal::service('book.manager'); // or inject Drupal\book\BookManagerInterface
$books   = $manager->getAllBooks();
$link    = $manager->loadBookLink((int) $node->id());
$bid     = $link['bid'];
$tree    = $manager->bookTreeAllData($bid);
```

## Other services

| Service id | Class / interface | Use |
|---|---|---|
| `book.export` | `\Drupal\book\BookExport` | Build the printer-friendly export render array (`bookExportHtml()`), backing `/book/export/html/{node}`. |
| `book.outline` | `\Drupal\book\BookOutline` | Compute prev/next/up navigation for a book link. |
| `book.outline_storage` | `\Drupal\book\BookOutlineStorageInterface` | Direct CRUD on the `book` outline table (`backend_overridable`). |
| `book.breadcrumb` | `BookBreadcrumbBuilder` | Book-aware breadcrumbs (tagged `breadcrumb_builder`, priority 701). |
| `book.uninstall_validator` | `BookUninstallValidator` | Blocks uninstall while outlines exist. |

## Extension points (code)

- **`hook_query_books_alter(AlterableInterface $query)`** — the `book_node_selection`
  handler and other book queries add the `books` query tag; implement this alter to
  filter which nodes are treated as selectable book nodes.
- **Tokens** — `hook_token_info`/`hook_tokens` (in `BookTokenHooks`) add a `book`
  token group (including a joined parent-path token) usable wherever tokens apply.
- **Views** — `hook_views_data` (in `BookViewsHooks`) exposes book relationships/fields.
