# Service, token, alter hook and D7 migration (API)

## Service — `representative_image.picker`

`Drupal\representative_image\RepresentativeImagePicker` (args: `@entity_field.manager`,
`@entity_type.manager`, `@entity.repository`, `@module_handler`). This is the module's public PHP API —
call it to obtain an entity's representative image from code.

```php
/** @var \Drupal\representative_image\RepresentativeImagePicker $picker */
$picker = \Drupal::service('representative_image.picker');

// Convenience: get the image file URI + fill width/height/alt/title by reference.
$attributes = [];
$uri = $picker->getImageFromEntity($node, $attributes); // e.g. "public://hero.jpg" or NULL
```

Public methods (`RepresentativeImagePicker.php`):

| Method | Returns | Notes |
|---|---|---|
| `getImageFromEntity(FieldableEntityInterface $entity, array &$attributes = [])` | `?string` | The resolved image's **file URI** (e.g. `public://…`), or `NULL`. Populates `$attributes['width'|'height'|'alt'|'title']` by reference when empty. `:339`. |
| `getImageFieldItems(FieldableEntityInterface $entity)` | `?FieldItemListInterface` | The resolved image field item list, or `NULL` if the bundle has no representative image field. `:314`. |
| `getImageFieldItemList(FieldItemListInterface $items)` | `?FieldItemListInterface` | Core resolver (source field → behavior → alter → follow reference). Throws `\LogicException` if `$items` is not a `representative_image` field. `:84`. |
| `getRepresentativeImageField(FieldableEntityInterface $entity)` | `FieldItemListInterface` | The bundle's `representative_image` field. Throws `RepresentativeImageFieldNotDefinedException` if none. `:291`. |
| `hasRepresentativeImageField(FieldableEntityInterface $entity)` | `bool` | Whether the bundle defines a representative image field. `:271`. |
| `getSupportedFields($entity_type, $bundle)` | `array` | field id ⇒ label for image/entity_reference (content-entity) fields eligible as a source. `:165`. |

## Token — `[<entity_type>:representative_image]`

`representative_image.module` implements `hook_token_info()` and `hook_tokens()` and registers a
`representative_image` token **on every entity type** (it loops all entity type definitions). The token
resolves to the representative image's **URL** — the module views the representative image field in the
`default` view mode, takes item `[0]['#item']->entity` (the file), and returns
`File::createFileUrl(FALSE)` (a root-relative path). If the bundle has no representative image field or
nothing resolves, the token yields nothing (`representative_image.module:34-68`).

```
[node:representative_image]     → /sites/default/files/hero.jpg
[media:representative_image]    → …
```

The intended use is social/OG meta: feed this token into a Metatag `og:image` pattern so the shared
image is chosen once per bundle rather than guessed by each consumer.

## Alter hook — `hook_representative_image_alter()`

Declared in `representative_image.api.php`; invoked inside `getImageFieldItemList()` via
`$this->moduleHandler->alter('representative_image', $image_field_items, $field_definition, $entity)`
(`RepresentativeImagePicker.php:116`) after the source item list is resolved and **before** entity
references are followed.

```php
/**
 * Implements hook_representative_image_alter().
 */
function mymodule_representative_image_alter(
  \Drupal\Core\Field\FieldItemListInterface $items,
  \Drupal\Core\Field\FieldDefinitionInterface $representative_image_field,
  \Drupal\Core\Entity\FieldableEntityInterface $entity,
): void {
  // Backfill alt text from another field when the image has none.
  if ($entity->hasField('field_alt_text') && empty($items[0]->alt)) {
    $items[0]->alt = $entity->get('field_alt_text')->getString();
  }
}
```

## Drupal 7 migration

For upgrades from D7 the module provides two migrate **source** plugins and matching migration configs
(under `migrations/`). They read D7 `variable` rows named
`representative_image_field_{entity_type}_{bundle}` and create a `field_representative_image` field
(type `representative_image`).

| Migration / source id | Class | Role |
|---|---|---|
| `d7_representative_image_field_storage_config` | `Plugin/migrate/source/FieldStorageConfig` | Selects the non-empty `representative_image_field_%` variables; creates field storage. |
| `d7_representative_image_field_config` | `Plugin/migrate/source/FieldConfig` | Extends the storage source; derives entity type + bundle from the variable name, `unserialize()`s the stored source-field name into the instance `settings`, creates field instances. |

Run with the standard `migrate_drupal` / Migrate Upgrade tooling; both carry `Drupal 7` +
`Configuration` migration tags.
