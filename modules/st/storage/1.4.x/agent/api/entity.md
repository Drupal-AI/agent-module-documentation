<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# API — the `storage` entity, hook, tokens, Views

## Entity type `storage`

`ContentEntityType` id **`storage`** (`Entity\Storage`), fieldable, revisionable,
translatable, `permission_granularity = bundle`, `admin_permission = administer storage
entities`, bundle entity key `type`. Base tables: `storage` / `storage_field_data` (+ revision
tables). Links include `add-form` (`/storage/add/{storage_type}`), `edit-form`
(`/storage/{storage}/edit`), `collection` (`/admin/content/storage`); a `canonical`
(`/storage/{storage}`) exists but redirects to edit unless the type's `has_canonical` is TRUE.

### Base fields / interface (`StorageInterface`)

`getName()/setName()`, `getCreatedTime()/setCreatedTime()`, revision user/time getters,
`getStringRepresentation()`, `applyNamePattern()`. The `name` field is the entity label.

### Create an entity in code

```php
$s = \Drupal::entityTypeManager()->getStorage('storage')->create([
  'type' => 'api_log',
  'name' => 'Example',
  // ... your fields ...
]);
$s->save();
```

## Alter hook — customise the label

`hook_storage_get_string_representation(StorageInterface $storage, string $string): string`
lets a module supply/override an entity's string representation (used by
`getStringRepresentation()` and available to the `name_pattern`). Returning an empty string
falls back to the default. Example in `storage.api.php`:

```php
function hook_storage_get_string_representation(StorageInterface $storage, $string) {
  return $storage->get('my_custom_field')->value;
}
```

## Tokens

The module implements `hook_token_info()` / `hook_tokens()` (via `StorageTokensHooks`) to
provide `storage` tokens, including `[storage:string-representation]` used by name patterns.

## Views

Views integration ships with the module: base table `storage_field_data`, a default
`views.view.storage` (the `/admin/content/storage` listing), plus custom fields/filters/args
(status, revision links, bulk form, storage id/type arguments). Build custom reports over
storage data by adding a view on the `storage` entity / `storage_field_data` table.

## Bulk actions

Shipped `system.action.*`: `storage_publish_action`, `storage_unpublish_action`,
`storage_save_action`, `storage_delete_action` (usable from the overview's bulk form).
