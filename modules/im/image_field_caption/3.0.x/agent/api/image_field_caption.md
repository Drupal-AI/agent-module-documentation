# API

## Storage service

`image_field_caption.storage` → `Drupal\image_field_caption\ImageCaptionStorage`
(constructed with `@cache.data`, `@cache_tags.invalidator`, `@database`).

Captions are stored **outside** the field's own tables, in two DB tables defined in
`image_field_caption.install`:

- `image_field_caption` — current captions. Primary key:
  `(entity_type, field_name, entity_id, language, delta)`.
- `image_field_caption_revision` — revision table (same shape, revision_id in PK). **Present
  but effectively unused**: the module's revision insert/delete calls are commented out, so
  captions are current-revision only.

Columns: `entity_type`, `bundle`, `field_name`, `entity_id`, `revision_id`, `language`,
`delta`, `caption` (text), `caption_format` (varchar). When `revision_id` is unknown the code
falls back to the entity id.

### Public methods (all take positional args)

```php
$s = \Drupal::service('image_field_caption.storage');

// Returns ['caption' => string, 'caption_format' => string] or [].
$s->getCaption($entity_type, $bundle, $field_name, $entity_id, $revision_id, $language, $delta);

// TRUE/FALSE convenience wrapper around getCaption().
$s->isCaption($entity_type, $bundle, $field_name, $entity_id, $revision_id, $language, $delta);

// Write a caption row.
$s->insertCaption($entity_type, $bundle, $field_name, $entity_id, $revision_id, $language, $delta, $caption, $caption_format);

// Delete all captions for an entity+field+language (NOTE: no delta/revision args).
$s->deleteCaption($entity_type, $bundle, $field_name, $entity_id, $language);

// Revision-table variants (module does not call these itself).
$s->insertCaptionRevision(...); // same 9 args as insertCaption
$s->deleteCaptionRevision($entity_type, $bundle, $field_name, $entity_id, $revision_id, $language);
$s->deleteCaptionRevisions($entity_type, $bundle, $field_name, $entity_id, $language);
$s->deleteCaptionRevisionsByRevisionId($revision_id);

// Cache helpers.
$s->clearCache($field_name);                 // invalidate tags [$field_name, 'image_field_caption']
$s->getCacheKey($entity_type, $entity_id, $revision_id, $language, $field_name, $delta);

// Distinct column values across stored captions, e.g. list('entity_type') / list('bundle').
$s->list($key = 'entity_type');
```

Caching: `getCaption()` uses `drupal_static` + the `cache.data` backend, keyed by
`caption:{entity_type}:{entity_id}:{revision_id}:{language}:{field_name}:{delta}`, tagged
`[$field_name, 'image_field_caption']`.

## Widget value shape

When the caption is enabled, the image widget gains an element `image_field_caption`
(a `text_format`). On submit its value is `['value' => ..., 'format' => ...]`, read by the
entity hooks as `$value['image_field_caption']['value']` / `['format']`.

## Loaded field item value

`hook_entity_storage_load()` merges the stored caption back onto each image item value, so a
loaded `image` field item carries extra keys `caption` and `caption_format` alongside the
normal image keys (`target_id`, `alt`, `title`, `width`, `height`, `fids`). The formatter's
preprocess reads `$item->getValue()['caption']` / `['caption_format']`.

## Item class & formatter

- Field item class (via `hook_field_info_alter`): `ImageCaptionItem extends ImageItem` —
  adds settings `caption_field`, `caption_field_required`, `default_image.caption`.
- Formatter plugin id `image_caption` (`ImageCaptionFormatter extends ImageFormatter`),
  label "Image with caption"; only difference is it sets `#theme` to
  `image_caption_formatter`.
