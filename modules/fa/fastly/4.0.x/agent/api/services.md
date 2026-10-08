# Services, subscribers & hook

## Services (`fastly.services.yml`)

| Service id | Class | Role |
|---|---|---|
| `fastly.api` | `Api` | Talks to the Fastly API: `purgeAll()`, `purgeUrl($url)`, `purgeKeys($hashes)`, credential validation. |
| `fastly.cache_tags.hash` | `CacheTagsHash` | `cacheTagsToHashes($tags)` and `hashInput($s)` — md5+base64, truncated to `cache_tag_hash_length`, prefixed by `site_id`. `getSiteId()` auto-generates + stores a random id if none set. |
| `fastly.cache_tags.invalidator` | `CacheTagsInvalidator` | Tagged `cache_tags_invalidator`; turns Drupal cache-tag invalidations into Fastly purges. |
| `fastly.cache_tags.surrogate_key_generator` | `EventSubscriber\SurrogateKeyGenerator` | Adds `Surrogate-Key` response headers from the page's cache tags. |
| `fastly.cache_tags.add_stale_headers` | `EventSubscriber\AddStaleHeaders` | Adds stale-while-revalidate / stale-if-error headers. |
| `fastly.state` | `State` | Drupal state flag `fastly.state.valid_purge_credentials`. |
| `fastly.vclhandler` | `VclHandler` | Uploads/maintains VCL snippets on the service. |
| `fastly.services.webhook` | `Services\Webhook` | Posts webhook notifications. |

Parameters: `fastly.host` (`https://api.fastly.com/`), `fastly.connect_timeout` (3),
`fastly.webhook_connect_timeout` (2). Logger channel `logger.channel.fastly`.

## Purge programmatically

```php
$api = \Drupal::service('fastly.api');
$api->purgeUrl('https://example.com/node/1');

$hash = \Drupal::service('fastly.cache_tags.hash');
$api->purgeKeys($hash->cacheTagsToHashes(['node:1', 'node:2']));
```

## Image formatter

`Plugin\Field\FieldFormatter\FastlyImageFormatter` renders image fields through the Fastly Image
Optimizer (honoring the Image Optimizer settings). Select it as the formatter on an image field's
Manage display when `image_optimization` is enabled.

## Hook

```php
/** Alter the data VclHandler uploads to Fastly. */
function mymodule_vcl_handler_data_alter(array &$data) {
  // Modify VCL snippet data before upload.
}
```
Declared in `fastly.api.php` as `hook_vcl_handler_data_alter(&$data)`.
