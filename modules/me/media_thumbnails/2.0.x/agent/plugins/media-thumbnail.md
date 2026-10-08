<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Plugin type `media_thumbnail`

| | |
|---|---|
| Manager service | `plugin.manager.media_thumbnail` (`Drupal\media_thumbnails\Plugin\MediaThumbnailManager`) |
| Subdirectory | `Plugin/MediaThumbnail` |
| Annotation | `Drupal\media_thumbnails\Annotation\MediaThumbnail` (`@MediaThumbnail`) |
| Interface | `Drupal\media_thumbnails\Plugin\MediaThumbnailInterface` |
| Base class | `Drupal\media_thumbnails\Plugin\MediaThumbnailBase` |
| Alter hook | `hook_media_thumbnails_media_thumbnail_info_alter(&$definitions)` |
| Cache key | `media_thumbnails_media_thumbnail_plugins` |

Annotation properties: `id`, `label`, `mime` (array of MIME type strings). The manager
flattens every definition into a `mime => plugin_id` map at construction, so **one plugin
wins per MIME type** — if two plugins claim `application/pdf`, the last definition loaded
wins. Use the alter hook to force a winner.

## Minimal plugin

`my_module/src/Plugin/MediaThumbnail/MyFormatThumbnail.php`

```php
<?php

namespace Drupal\my_module\Plugin\MediaThumbnail;

use Drupal\file\Entity\File;
use Drupal\media_thumbnails\Plugin\MediaThumbnailBase;

/**
 * @MediaThumbnail(
 *   id = "my_format_thumbnail",
 *   label = @Translation("My format thumbnail"),
 *   mime = {
 *     "application/x-my-format"
 *   }
 * )
 */
class MyFormatThumbnail extends MediaThumbnailBase {

  /**
   * {@inheritdoc}
   */
  public function createThumbnail($sourceUri) {
    // $this->configuration is the whole media_thumbnails.settings array:
    $width = $this->configuration['width'] ?? 500;

    $destination = 'public://media-thumbnails/' . basename($sourceUri) . '.png';
    $dir = dirname($destination);
    $this->fileSystem->prepareDirectory($dir, \Drupal\Core\File\FileSystemInterface::CREATE_DIRECTORY);

    // ... render $sourceUri into $destination at $width px wide ...

    $file = File::create(['uri' => $destination, 'status' => 1]);
    $file->save();
    return $file;   // must be a saved managed file, or NULL to give up
  }

}
```

`MediaThumbnailBase` is a `ContainerFactoryPluginInterface` and already injects
`config.factory` (`$this->config`), `file_system` (`$this->fileSystem`) and the
`logger.media_thumbnails` channel (`$this->logger`). Extend `create()` if you need more.

Register nothing else — no `*.services.yml` entry, no info.yml key. Just `drush cr` and the
plugin is discovered.

## Manager API

```php
/** @var \Drupal\media_thumbnails\Plugin\MediaThumbnailManager $m */
$m = \Drupal::service('plugin.manager.media_thumbnail');

$m->getDefinitions();              // all plugin definitions
$m->getPluginId($media);           // plugin id for this media entity, or NULL
$m->hasPlugin($media);             // bool
$m->isLocal($media);               // source field is a FileFieldItemList?
$m->getSource($media);             // File entity of the source field
$m->getThumbnail($media);          // File entity currently in the 'thumbnail' field
$m->createThumbnail($media);       // generate + assign (does not save the media)
$m->updateThumbnail($media);       // delete + create
$m->deleteThumbnail($media);       // unset + delete the file, with guards
```

`getPluginId()` returns NULL when the media source is not a local file
(`isLocal()` is FALSE — e.g. oEmbed/remote video), when there is no target file, or when no
plugin claims the file's MIME type.

`deleteThumbnail()` refuses to delete a file that is used more than once
(`file.usage` count > 1) or whose URI is under `media.settings:icon_base_uri` (the generic
media icons).

## When the manager runs (`media_thumbnails.module`)

- `hook_ENTITY_TYPE_presave()` on `media`, only if `hasPlugin($entity)`:
  - **new entity** → `createThumbnail()` when the bundle is `image` **or** the current
    thumbnail filename still equals the source plugin's `default_thumbnail_filename`;
  - **existing entity, `no_thumbnail_update` TRUE** → `updateThumbnail()` only if the current
    thumbnail URI is under `media.settings:icon_base_uri`;
  - **existing entity, otherwise** → `updateThumbnail()`.
- `hook_ENTITY_TYPE_delete()` on `media` → `deleteThumbnail()`.
- `hook_entity_base_field_info_alter()` → makes `thumbnail` form-display-configurable when
  `allow_thumbnail_edit` is TRUE.

Because generation is hooked to media **save**, the way to (re)generate in bulk is simply to
re-save every media entity — which is exactly what the refresh batch does.

## Overriding a MIME mapping

```php
function my_module_media_thumbnails_media_thumbnail_info_alter(array &$definitions) {
  // Take PDFs away from the contributed plugin.
  $definitions['media_thumbnail_pdf']['mime'] = [];
  $definitions['my_pdf_thumbnail']['mime'] = ['application/pdf'];
}
```
