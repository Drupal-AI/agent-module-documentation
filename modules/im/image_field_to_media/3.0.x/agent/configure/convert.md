# Converting an Image field to Media

No settings page — the feature is an entity operation on Image fields. All routes require the permission
`create media fields based on existing image fields` (see permissions doc).

## Prerequisite

An `image` Media type with a field named `field_media_image` must exist. `ImageFieldToMediaController::validate()`
(route `image_field_to_media.image_media_type_validator`) checks this; if the media type or field is missing it
sets an error message and redirects back to *Manage fields*.

## Steps (UI)

1. *Manage fields* for the bundle → on the Image field's operations, click **Clone to media**
   (added by `image_field_to_media_entity_operation()`, only shown to permitted users on `image`-type fields).
2. The validator passes you to `ImageFieldToMediaForm` (route `image_field_to_media.field_settings_form`).
3. Choose **Create a new Media Image field** (enter Label + machine name) or **Reuse an existing Media field**
   (select an existing entity-reference field targeting the `image` media bundle).
4. Click **Proceed** → a batch runs and you are redirected to the bundle's Manage fields page.

## What submit does (`ImageFieldToMediaForm::submitForm`)

- Create path: `createMediaField()` creates a `field_storage_config` (`entity_reference` → `media`, same
  cardinality as the image field) and a `field_config` per bundle (handler `default:media`, target bundle
  `image`), then applies core's preconfigured `media` widget/formatter to the default form and view displays;
  `setDisplaySettings()` copies the source image field's weight/label (and image formatter settings) onto the new
  field for every view/form mode that has the image field.
- Reuse path: uses the selected existing media field name as-is.
- Enqueues a batch operation `image_field_to_media_populate_media_field($entity_type_id, $bundles,
  $image_field_name, $media_field_name)` with finish callback `image_field_to_media_batch_finished`.

## Backfill (batch)

For each entity of the affected bundles that has the image field (query uses `accessCheck(TRUE)`), each image
item is turned into a Media entity via `image_field_to_media_get_media_entity()` and appended to the media field;
the entity is saved. Existing images are matched by `sha1_file()` and reuse the already-created Media (dedup). The
original Image field is not modified. See [../api/batch.md](../api/batch.md) for the callable functions.
