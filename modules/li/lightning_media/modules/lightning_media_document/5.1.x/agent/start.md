<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Media Document (`lightning_media_document`) — agent index

Glue submodule of Lightning Media. **No routes, no permissions, no services, no settings
form (`configure` = null), no config schema, no Drush, no plugin types.** Depends only on
`lightning_media`.

## All of the code

```php
// lightning_media_document.module
function lightning_media_document_media_source_info_alter(array &$sources) {
  $sources['file']['input_match']['field_types'] = ['file'];
  Override::pluginClass($sources['file'], File::class);
}

// src/Plugin/media/Source/File.php
class File extends \Drupal\media\Plugin\media\Source\File implements InputMatchInterface {
  use \Drupal\lightning_media\FileInputExtensionMatchTrait;
}
```

`lightning_media_document.install` only declares `hook_update_last_removed(): 8002`.

## Configuration it installs (all `config/optional/`)

| Config | Value |
|---|---|
| `media.type.document` | label **Document**, source `file`, source field `field_media_document` |
| `field.storage.media.field_media_document` + `field.field.media.document.field_media_document` | file field; default extensions **`txt rtf doc docx ppt pptx xls xlsx pdf odf odg odp ods odt fodt fods fodp fodg key numbers pages`** |
| `field.field.media.document.field_media_in_library` | Lightning Media's "Show in media library" boolean |
| `core.entity_form_display.media.document.{default,media_library}` | form displays |
| `core.entity_view_display.media.document.{default,embedded,media_library,thumbnail}` | view displays |

```bash
drush config:get media.type.document
drush config:get field.field.media.document.field_media_document settings.file_extensions
drush config:set field.field.media.document.field_media_document settings.file_extensions 'pdf docx xlsx' -y
```

Create a Document media item programmatically:

```php
use Drupal\media\Entity\Media;
$media = Media::create(['bundle' => 'document', 'name' => 'Annual report']);
$media->set('field_media_document', ['target_id' => $file->id()]);
$media->save();
```

Gotcha: the extension list is very broad, so Document frequently competes with other
components for the same input. `MediaHelper::getBundleFromInput()` throws
`IndeterminateBundleException` when two media types both claim a file — narrow
`file_extensions` on one of them to disambiguate.

Input-matching contract and `MediaHelper` API:
[`../../../../5.1.x/agent/api/media-helper.md`](../../../../5.1.x/agent/api/media-helper.md).
