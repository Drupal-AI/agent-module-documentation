# API: services, hook, plugins, tokens

## Services

### `localgov_publications.publication_manager` → `Service\PublicationManager`
Constructor arg: `@entity_type.manager`.

- `getTopLevel(NodeInterface $node): ?NodeInterface` — returns the node itself if it is not in a book
  or is the book root (`$node->book['pid'] === '0'`); otherwise loads and returns the root
  (`$node->book['bid']`). **No access check** on the loaded root (used for the page-header title/dates).
- `getCoverPage(int $publicationId): ?NodeInterface` — the first cover-page node whose
  `localgov_publication` field references `$publicationId`, or NULL. Uses `accessCheck(FALSE)` (it feeds
  URL-alias/token generation, not a rendered listing).

### `localgov_publications.heading_finder` → `Service\HeadingFinder` (implements `HeadingFinderInterface`)
- `searchMarkup(string $markup): \Drupal\Core\Link[]` — regex-scans rendered HTML for `<h2 …>` tags,
  reads each heading's `id=` attribute, and returns `Link` objects pointing at `#<id>` fragments
  (heading text used as the link label). Headings without an `id` are skipped. Used by the ToC block.

### `localgov_publications.breadcrumb` → `Breadcrumb\BreadcrumbBuilder`
Extends core `PathBasedBreadcrumbBuilder`; `applies()` only for the two publication node types. Priority
750 so it runs before `book`'s breadcrumb builder, giving publication pages a path-based breadcrumb
instead of the book-outline one.

### `localgov_publications.route_subscriber` → `EventSubscriber\LocalgovPublicationsRouteSubscriber`
Swaps the `book.admin` route controller (priority -300). See [../configure/publications.md](../configure/publications.md).

## Hook it invokes (for integrators)

```php
/** Alter a publication's navigation menu tree before the publication_navigation block renders it. */
function hook_localgov_publications_menu_tree_alter(array &$tree) { /* $tree from BookManager::bookTreeAllData() */ }
```
Both `moduleHandler->alter()` and `themeManager->alter()` are called, so themes may implement it too.
Example (shorten nav titles from a custom field) is in `localgov_publications.api.php`.

## Plugins it provides (instances, not new plugin types)

- **Text-format filter** `localgov_publications_heading_ids` (`Plugin/Filter/HeadingIdFilter`, a copy of
  the `auto_heading_ids` module) — TYPE_TRANSFORM_IRREVERSIBLE, weight 10. Adds transliterated, unique
  `id` anchors to `h2`–`h6`. Setting `keep_existing_ids` (bool) leaves existing ids untouched. Installed
  onto the `wysiwyg` format automatically.
- **Preview link autopopulate** `localgov_publications` (`Plugin/PreviewLinkAutopopulate/Publications`,
  requires the optional `preview_link` module) — when previewing a publication page or cover page, adds
  every page in the publication (via `bookManager->bookTreeGetFlat`) plus any cover pages to the preview
  link.

## Tokens (node)

Defined in `localgov_publications.tokens.inc` + `Token\Hooks` (added via `hook_tokens_alter`):

| Token | Resolves to |
|---|---|
| `[node:localgov-publication-cover-page-alias]` | URL alias of the publication's cover page (if any). |
| `[node:localgov-publication-path]` | Full path to a publication page: cover-page alias (root) or root alias (children) + the join of parent page titles. Used by the `publication_page` pathauto pattern. |

Both return nothing unless the node is in a book (`$node->book['bid']`); both add the cover page as a
cacheable dependency.
