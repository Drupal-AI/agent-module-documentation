# Hooks

`webform_score.api.php` documents one invited hook.

## `hook_webform_score_info_alter(array &$definitions)`
Alter the discovered `webform_score` scoring plugin definitions (keyed by machine name). Use it to
tweak an existing plugin, e.g. widen the data types it can score:

```php
function mymodule_webform_score_info_alter(array &$definitions) {
  if (isset($definitions['equals'])) {
    $definitions['equals']['compatible_data_types'][] = 'email';
  }
}
```

Invoked by `WebformScoreManager` via `->alterInfo('webform_score_info')`.

(The module itself also implements standard core hooks — `hook_entity_base_field_info`,
`hook_entity_field_access`, `hook_ENTITY_TYPE_presave`, `hook_token_info`/`hook_tokens` — but those
are core extension points, documented under api/score.md and permissions/, not module-specific
invited hooks.)
