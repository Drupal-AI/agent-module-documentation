<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Bing Indexing API

## Credentials — `/admin/config/services/bing-index-api` (`bing_indexing_api.credentials`)
- `api_key` — Bing Webmaster API key.
- `base_domain` — site URL used as `siteUrl`.

## Settings — `/admin/config/services/bing-index-api/settings` (`bing_indexing_api.settings`)
Trigger flags read by the node hooks:
- `node_presave` + `node_presave_published_only` — submit on create/update.
- `node_unpublish` — submit when a node goes published→unpublished.
- `node_delete` + `node_delete_published_only` — submit on delete.

## Bulk — `/admin/config/services/bing-index-api/bulk-update`
Submit multiple URLs in one call.

## Programmatic
```php
\Drupal::service('bing_indexing_api.client')->reindexUrl($node->toUrl()->setAbsolute()->toString());
```
`reindexUrl()` accepts a string or array of URLs and returns `['success'=>bool,'message'=>...]`.