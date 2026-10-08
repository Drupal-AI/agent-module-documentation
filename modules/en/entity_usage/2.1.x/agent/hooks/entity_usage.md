# Hooks

Defined in `entity_usage.api.php`.

## `hook_entity_usage_block_tracking(...)`

Block a specific usage record from being written. Return `TRUE` to block; any other value lets
the record through. Invoked from `EntityUsageInterface::registerUsage()`.

```php
/**
 * Implements hook_entity_usage_block_tracking().
 */
function mymodule_entity_usage_block_tracking($target_id, $target_type, $source_id, $source_type, $source_langcode, $source_vid, $method, $field_name, $count) {
  // Don't track links found in this particular field.
  if ($field_name === 'field_foo_bar' && $method === 'link') {
    return TRUE;
  }
  return FALSE;
}
```

- `$method` is normally the tracking plugin id (e.g. `entity_reference`, `link`, `embed`).
- Also available: the `entity_usage_track_info` alter hook (alter plugin definitions) and
  events under `Drupal\entity_usage\Events` (`EntityUsageEvent`, `UrlToEntityEvent`).
