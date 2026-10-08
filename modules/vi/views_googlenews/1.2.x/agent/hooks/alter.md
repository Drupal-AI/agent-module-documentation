<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Hook: alter a Google News feed item

The row preprocess invokes one alter hook per item, before the item is turned into XML:

```php
\Drupal::moduleHandler()->alter('views_googlenews_item', $item);
```

## `hook_views_googlenews_item_alter(array &$item)`

`$item` is the associative array built by the `google_news_fields` row plugin for one feed
row. Keys you can read/change:

- `loc`
- `news_publication_name`
- `news_publication_language`
- `news_access`
- `news_genres`
- `news_publication_date`
- `news_title`
- `news_keywords`
- `news_stock_tickers`

Example:

```php
/**
 * Implements hook_views_googlenews_item_alter().
 */
function MYMODULE_views_googlenews_item_alter(array &$item) {
  // Force a fixed publication name and add a default genre.
  $item['news_publication_name'] = 'My Newsroom';
  if (empty($item['news_genres'])) {
    $item['news_genres'] = 'PressRelease';
  }
}
```

Notes:
- Runs in `template_preprocess_views_view_row_googlenews()` before values are sanitized
  (`strip_tags`, `filterBadProtocol` on `loc`) and placed into the template.
- The publication name/language defaults (site name / default language) are applied in the
  **feed-level** preprocess (`template_preprocess_views_view_googlenews`), so overriding an
  empty `news_publication_name` here changes what gets defaulted.
