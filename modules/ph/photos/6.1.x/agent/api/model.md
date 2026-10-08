<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Data model & upload API

## An album is a node

Enabling Photos installs the **`photos` node type** ("Photo album", enforced by the module).
An album is just a node of type `photos`; its pictures are separate `photos_image` entities that
reference the album node. Uploading is done via the node's *Add Photos* tab
(`/node/{node}/photos`, route `photos.node.management`) or the standalone add form
(`/photos/image/add`).

## The `photos_image` entity

`Drupal\photos\Entity\PhotosImage` — a `ContentEntityType`:

- `id: photos_image`, base table `photos_image`, data/revision tables
  `photos_image_field_data` / `photos_image_revision` / `photos_image_field_revision`.
- Revisionable (`show_revision_ui`), translatable, publishable (`EditorialContentEntityBase`).
- entity keys: `id`, `revision_id`, label = `title`, `uid`/`owner`, `status`.
- Handlers: storage `PhotosImageStorage` (+`PhotosImageStorageSchema`), access
  `PhotosAccessControlHandler`, list builder `PhotosImageListBuilder`, views data
  `PhotosViewsData`, route provider `PhotosRouteProvider`.
- Forms: `add` (`PhotosImageAddForm`), `edit` (`PhotosImageEditForm`), `delete`.
- Links: canonical `/photos/{node}/{photos_image}`, add-form `/photos/image/add`, collection
  `/admin/content/photos`.
- `admin_permission = administer nodes`; default image field `field_image` on bundle
  `photos_image`.

Load/create in code:

```php
$storage = \Drupal::entityTypeManager()->getStorage('photos_image');
$photos = $storage->loadByProperties(['album_id' => $nid]);   // photos in an album
```

## Extra tables

`hook_schema()` (in `photos.install`) adds:

- `photos_album` — per-album metadata (cover id, counts, display settings).
- `photos_count` — cached photo/visit counters (updated on cron;
  `photos_user_count_cron`).

## The upload service `photos.upload`

`Drupal\photos\PhotosUpload` (service id `photos.upload`, interface `PhotosUploadInterface`) is
the ingestion pipeline — it validates files, creates `photos_image` entities, handles ZIP
extraction (`photos_upzip`), applies image styles, transliterates/cleans titles, and records
file usage. It is injected with config, database, current user, entity managers, file
repository/system/usage/validator, image factory, logger, token and transliteration services.
Use it (not raw file APIs) to add images programmatically so albums, counts and file usage stay
consistent.

## Helpers

- `Drupal\photos\PhotosAlbum` — album helper (cover, counts, links).
- `Drupal\photos\PhotosImageFile` — file/image helpers.
- Tokens: `hook_token_info()` / `hook_tokens()` expose photo & album tokens.
- Node integration: `hook_node_insert/update/delete`, `hook_node_view`, per-user counts on
  `hook_user_insert/load/view`.
