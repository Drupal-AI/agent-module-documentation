# Hooks (votingapi.api.php)

Implement these in `mymodule.module`.

## `hook_vote_result_info_alter(&$results)`
Alter the registered VoteResultFunction plugin definitions (keyed by machine
name) — e.g. relabel the built-in `count` result.

```php
function mymodule_vote_result_info_alter(&$results) {
  $results['count']['label'] = t('All the things');
}
```

## `hook_votingapi_results_alter(array &$vote_results, $entity_type, $entity_id)`
Add to or change the aggregate results just before they are stored. Fired from
`VoteResultFunctionManager::recalculateResults()` after the built-in plugins
run. Each entry is an array with `entity_id`, `entity_type`, `type`,
`function`, `value`, `value_type`, `timestamp`. Use it to inject a custom
aggregate (e.g. standard deviation) without writing a plugin.

## `hook_votingapi_metadata_alter(&$data)`
Describe custom tags, value types, and aggregate functions so other modules can
interpret and display your data. `$data` has `tags`, `value_types`, and
`functions` bins; each entry minimally has `name` and `description`.

## `hook_votingapi_views_formatters($field)`
Return `['callback' => 'Human description']` pairs to expose custom Views field
formatters for vote values, tags, or aggregate functions.

## Note on core-style hooks
The module's own implementations (`hook_cron`, `hook_entity_delete`,
`hook_help`, `hook_views_query_alter`) use the OOP `#[Hook]` attribute in
`src/Hook/*` with `#[LegacyHook]` shims in `votingapi.module`. You implement the
alter hooks above the normal procedural way.
