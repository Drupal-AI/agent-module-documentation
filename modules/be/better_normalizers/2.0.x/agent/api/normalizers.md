# Better Normalizers — the normalizers

All three are registered on the container by
`Drupal\better_normalizers\BetterNormalizersServiceProvider::alter()` with a `normalizer` tag and
a priority higher than the equivalent `hal.services.yml` service, so they take over for the
**`hal_json`** format. There is no config and no plugin type.

## 1. `FileEntityNormalizer` — file contents as base64

- Service `serializer.normalizer.entity.file_entity`, priority **30**, supports
  `Drupal\file\FileInterface`. Extends HAL `ContentEntityNormalizer`.
- **normalize()**: appends `data => [['value' => base64_encode(file_get_contents($uri))]]` to the
  HAL output (unless `included_fields` excludes `data`). So the file's bytes travel inside the
  serialized document.
- **denormalize()**: reads `data[0][value]`, base64-decodes it, ensures the target directory
  exists, and writes the bytes to the entity's file URI (throws `\RuntimeException` on write
  failure). This makes a File entity re-creatable from its HAL JSON alone.

```php
$json = \Drupal::service('serializer')->serialize($file, 'hal_json');
// $json now contains "data":[{"value":"<base64>"}]
$restored = \Drupal::service('serializer')->deserialize($json, 'Drupal\file\Entity\File', 'hal_json');
```

## 2. `FileItemNormalizer` — keep file-field metadata

- Service `serializer.normalizer.entity_reference_item.file_entity`, priority **20**, supports
  `Drupal\file\Plugin\Field\FieldType\FileItem`. Extends HAL `EntityReferenceItemNormalizer`.
- **normalize()**: after the parent produces the reference, it merges the item's own values
  (e.g. `description`, `display`) into the embedded relation data (dropping `target_id`).
- **denormalize()** (`constructValue`): copies those extra properties back onto the field value
  (dropping `_links`/`uuid`). Without this, core would serialize a file field down to a bare
  reference and lose the description/display.

## 3. `MenuLinkContentNormalizer` — embed link targets

- Service `serializer.normalizer.menu_link_content.hal`, priority **30**, supports
  `Drupal\menu_link_content\MenuLinkContentInterface`. Registered **only when
  `menu_link_content` is enabled**. Extends HAL `ContentEntityNormalizer`.
- **normalize()**: for each `link` whose URI is an `entity:` URI, it loads the target entity and
  embeds it under the pseudo-field `menu_link_content_target_entity`, adding `target_uuid` to the
  link. If the link has a `menu_link_content` parent, it embeds that under
  `menu_link_content_parent_entity`.
- **denormalize()**: resolves each embedded `target_uuid` back to a live entity id, rewriting the
  link URI to `entity:<type>/<id>`.

## Using / extending

- These fire through the normal `serializer` service and REST resources for the `hal_json`
  format — you do not call them directly. Configure REST/HAL as usual; enabling this module just
  upgrades the output.
- To add more file metadata, subclass `FileEntityNormalizer` or `FileItemNormalizer` and register
  your service at a **higher priority** in your module's `*.services.yml` (tag `normalizer`).
- `EntityStub` (in `src/Normalizer`) is a small helper used by the menu-link normalizer to parse
  `entity:` URIs into an entity-type id + id.
