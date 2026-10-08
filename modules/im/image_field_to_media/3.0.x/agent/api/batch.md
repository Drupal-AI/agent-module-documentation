# Batch / conversion API

Procedural functions in `image_field_to_media.batch.inc` (loaded via the batch `file` key). Usable from update
hooks to clone image fields to media programmatically (see d.o issue 3438068 — passing empty `$bundles` skips the
bundle condition).

## Functions

| Function | Role |
|---|---|
| `image_field_to_media_populate_media_field($entity_type_id, array $bundles, $image_field_name, $media_field_name, array &$context)` | Batch op. Processes one entity per invocation: loads the next entity of type/bundles that has the image field, and if it has the media field, converts each image item to a Media entity (find-or-create) and appends it, then saves. Sets `$context['finished']` (and mirrors to `$context['#finished']`). |
| `image_field_to_media_get_total_entities($entity_type_id, array $bundles, $image_field_name): int` | Counts entities with the image field (`accessCheck(TRUE)`), used as the sandbox max. |
| `image_field_to_media_get_media_entity(string $file_uri, array $image): EntityInterface` | Find-or-create the `image` Media for a file. Computes `sha1_file($file_uri)`; if the hash matches a stored one, returns that existing Media; else creates a new Media (`bundle = image`, `uid = 1`, `field_media_image = $image`), saves it, and stores `{media_id => hash}` in state. If `sha1_file()` returns FALSE (missing file), it creates a new Media without storing a hash. |
| `image_field_to_media_batch_finished($success, $results, $operations)` | Adds a status/error message with the processed count. |

## Dedup state

`\Drupal::state()` key `image_field_to_media.hashes_of_image_files` = `['<media_id>' => '<sha1 of file>']`.
- Populated by `image_field_to_media_get_media_entity()`.
- Entry removed in `hook_media_delete()` (`image_field_to_media_media_delete`) when a media is deleted.
- Whole key deleted on `hook_uninstall`.

## `type_key` handling

Entity queries key the bundle condition as `vid` for `taxonomy_term`, else `type`. `entity_type_id` is arbitrary —
the conversion works for any fieldable entity type that carries the image field.
