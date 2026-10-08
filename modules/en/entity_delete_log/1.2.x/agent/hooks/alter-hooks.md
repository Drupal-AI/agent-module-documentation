# Alter hooks

Both hooks fire inside `hook_entity_delete()` **only** for entity types enabled in
`entity_delete_log.settings` → `entity_types`. Implement them in `MYMODULE.module`.

## `hook_entity_delete_log_alter($entity, $type, array $variables)`

Called (via `invokeAll`) just before the row is inserted, giving you a chance to change the data.

Important caveat from the source: the module does
`$variables = \Drupal::moduleHandler()->invokeAll('entity_delete_log_alter', [$entity, $type, $variables])`,
so **your implementation must return the full `$variables` array** — the return value replaces it.
`$variables` keys: `uid`, `entity_id`, `entity_bundle`, `entity_type`, `author`, `created`,
`deleted`, `entity_title`, `revisions`.

```php
function mymodule_entity_delete_log_alter($entity, $type, $variables) {
  // e.g. prefix titles from a particular bundle.
  if ($type === 'node' && $entity->bundle() === 'article') {
    $variables['entity_title'] = '[article] ' . $variables['entity_title'];
  }
  return $variables;
}
```

After the alter, the module validates that `entity_id`, `entity_type`, `author`, `deleted`, and
`uid` are set (`_edl_get_failure_messages()`); if any are missing it aborts the insert and shows a
warning message instead of logging.

## `hook_entity_delete_log_post_process($entity, $type, array $variables)`

Called after a successful insert (return value ignored). `$variables` additionally contains
`entity_delete_log_id` (the new row's PK). Use it for side effects — notifications, external audit
systems, etc.

```php
function mymodule_entity_delete_log_post_process($entity, $type, $variables) {
  \Drupal::logger('audit')->notice('Deleted @t #@id (log @l)', [
    '@t' => $type, '@id' => $variables['entity_id'], '@l' => $variables['entity_delete_log_id'],
  ]);
}
```

There is no `entity_delete_log.api.php` file; these two hooks (documented in `README.txt`) are the
entire extension surface.
