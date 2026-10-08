# Aggregator hooks

From `aggregator.api.php`. Each plugin manager calls `alterInfo('aggregator_{type}_info')`,
so you can rewrite the discovered plugin definitions (e.g. swap in your own class for a
built-in plugin id without registering a new plugin).

```php
/**
 * Implements hook_aggregator_fetcher_info_alter().
 */
function my_module_aggregator_fetcher_info_alter(array &$info) {
  if (!empty($info['aggregator'])) {
    $info['aggregator']['class'] = \Drupal\my_module\MyDefaultFetcher::class;
  }
}
```

Three parallel hooks, each receiving `array[] &$info` keyed by plugin id:

| Hook | Alters |
|---|---|
| `hook_aggregator_fetcher_info_alter(array &$info)` | Available fetcher plugins |
| `hook_aggregator_parser_info_alter(array &$info)` | Available parser plugins |
| `hook_aggregator_processor_info_alter(array &$info)` | Available processor plugins |

The module itself also implements standard core hooks (in `src/Hook/AggregatorHooks.php`
via the `#[Hook]` attribute, not for you to invoke): `hook_cron()` (queues due feeds into
the `aggregator_feeds` queue), `hook_entity_extra_field_info()`, `hook_preprocess_block()`,
`hook_jsonapi_aggregator_feed_filter_access()`, and Drupal 6/7 migrate hooks
(`hook_migrate_prepare_row()`).
