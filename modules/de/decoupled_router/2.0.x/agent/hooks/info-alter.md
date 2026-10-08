<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Hooks

## `hook_decoupled_router_info_alter(array &$output, array $context)`

Alter the resolved payload just before it is returned (invoked with `invokeAll`, so every
module's implementation runs). Use it to add or change fields on the `entity` block or add
top-level keys.

- `$output` — the response array being built. Contains `resolved`, `isExternal`,
  `isHomePath`, `entity` (`canonical`, `type`, `bundle`, `id`, `uuid`), optional `label`,
  and (JSON:API on) `jsonapi`.
- `$context` — `['entity' => <the resolved EntityInterface>]`.

Example (`mymodule.module`):

```php
/**
 * Implements hook_decoupled_router_info_alter().
 */
function mymodule_decoupled_router_info_alter(array &$output, array $context) {
  /** @var \Drupal\Core\Entity\EntityInterface $entity */
  $entity = $context['entity'];
  if ($entity->getEntityTypeId() === 'node') {
    $output['entity']['langcode'] = $entity->language()->getId();
  }
}
```

The signature is declared in `decoupled_router.api.php`. No other hooks are provided; cache
invalidation on alias changes is handled internally via core `hook_path_*` /
`hook_path_alias_insert` in `decoupled_router.module`.
