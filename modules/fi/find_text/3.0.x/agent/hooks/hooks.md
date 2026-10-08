# Hooks

From `find_text.api.php`.

## `hook_find_text_results(array &$results)`
Alter the search result set before it is displayed/returned. Invoked via
`moduleHandler->invokeAll('find_text_results', [&$results])` at the end of
`TextSearchService::searchFields()`.

`$results` is keyed `$results[<entity_type>][<id>][<langcode>] = [rows…]` (paragraphs/blocks folded under
`node`). Mutate in place to remove, add, or annotate entries — e.g. exclude a set of nodes:

```php
function mymodule_find_text_results(array &$results) {
  foreach (['123', '456'] as $nid) {
    unset($results['node'][$nid]);
  }
}
```
