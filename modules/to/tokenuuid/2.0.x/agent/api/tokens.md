# Token UUID — tokens & alter hook

## Tokens provided
- `[current-user:uuid]` — UUID of the active user.
- `[<entity-type-group>:uuid]` — one per content entity type, e.g. `[node:uuid]`, `[user:uuid]`,
  `[media:uuid]`, `[comment:uuid]`, `[term:uuid]` (taxonomy, see mapping below), and any custom
  `ContentEntityType`.

Resolution: `hook_tokens()` returns `$data[$entity_group]->uuid()` for the `uuid` token when the
entity is present in the token data. Registration (`hook_token_info()`) iterates
`\Drupal::entityTypeManager()->getDefinitions()` and adds a `uuid` token to every
`ContentEntityTypeInterface`.

## Token group vs entity type id — the mapping
The token group used is derived from the entity type id but passed through
`tokenuuid_get_contententitytype_id()`, which runs the alter hook below. The shipped default
implementation (`tokenuuid_tokenuuid_entity_type_mapping_alter`) renames `taxonomy_term` → `term` so
the token matches pathauto's group. So use `[term:uuid]`, not `[taxonomy_term:uuid]`.

## Extending: `hook_tokenuuid_entity_type_mapping_alter(&$entity_types)`
`$entity_types` is a map of `entity_type_id => label`. Rename or remove keys to change which token
group a UUID token appears under. Example — expose a custom entity under a shorter group:
```php
function MYMODULE_tokenuuid_entity_type_mapping_alter(array &$entity_types) {
  if (!empty($entity_types['my_long_entity_id'])) {
    $entity_types['myent'] = $entity_types['my_long_entity_id'];
    unset($entity_types['my_long_entity_id']);
  }
}
```
The key becomes the token group; the value is the human label shown at `/admin/help/tokenuuid`.
