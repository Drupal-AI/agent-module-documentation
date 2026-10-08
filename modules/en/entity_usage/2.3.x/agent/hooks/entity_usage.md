<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Hooks & events

Hook documented in `entity_usage.api.php`.

## `hook_entity_usage_block_tracking(...)`

Block a specific usage record from being written. Return `TRUE` to block; any other value lets
the record through. Invoked from `EntityUsage::registerUsage()` via
`moduleHandler->invokeAll('entity_usage_block_tracking', $context)`.

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

- `$method` is normally the tracking plugin id (e.g. `entity_reference`, `link`, `html_link`,
  `entity_embed`, `media_embed`, `ckeditor_image`).
- Also available: the `entity_usage_track_info` alter hook (alter plugin definitions).

## Events (`Drupal\entity_usage\Events\Events`)

- `USAGE_REGISTER` (`entity_usage.register`) — a record was added/updated (`EntityUsageEvent`).
- `BULK_DELETE_DESTINATIONS`, `BULK_DELETE_SOURCES`, `DELETE_BY_FIELD`,
  `DELETE_BY_SOURCE_ENTITY`, `DELETE_BY_TARGET_ENTITY` — the matching bulk/targeted delete ran.
- `URL_TO_ENTITY` (`entity_usage.url_to_entity`) — resolve a URL string to an entity
  (`UrlToEntityEvent`; subscribers under `src/UrlToEntityIntegrations/` cover entity routing,
  language, public files and redirects).
