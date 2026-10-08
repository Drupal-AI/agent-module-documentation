# FileMetadata plugin type

file_mdm defines the **FileMetadata** plugin type — each plugin parses one kind of
metadata for a file.

- Namespace: `Plugin/FileMetadata`
- Attribute: `Drupal\file_mdm\Plugin\Attribute\FileMetadata` (id, title, help);
  legacy annotation `@FileMetadata` also supported.
- Interface: `Drupal\file_mdm\Plugin\FileMetadataPluginInterface`
- Base class: `Drupal\file_mdm\Plugin\FileMetadata\FileMetadataPluginBase`
- Manager: `Drupal\file_mdm\Plugin\FileMetadataPluginManagerInterface`
  (discovery cache `file_metadata_plugins`, alter hook `file_metadata_plugin_info`).
- Built-in plugin: `GetImageSize` (id `getimagesize`).

```php
namespace Drupal\mymodule\Plugin\FileMetadata;

use Drupal\Core\StringTranslation\TranslatableMarkup;
use Drupal\file_mdm\Plugin\Attribute\FileMetadata;
use Drupal\file_mdm\Plugin\FileMetadata\FileMetadataPluginBase;

#[FileMetadata(
  id: 'my_meta',
  title: new TranslatableMarkup('My metadata'),
  help: new TranslatableMarkup('Parses my custom metadata.'),
)]
class MyMeta extends FileMetadataPluginBase {
  public function getSupportedKeys(?array $options = NULL): array { /* keys */ }
  protected function doGetMetadataFromFile(): mixed { /* parse temp file */ }
  // Optionally implement isSaveToFileSupported()/doSaveMetadataToFile() to write back.
}
```

Key methods to implement/override: `getSupportedKeys()`, metadata get/set/remove,
`loadMetadataFromFile()`, and (if writable) `saveMetadataToFile()`. `defaultConfiguration()`
is merged with the plugin's config entity by the manager
([../configure/settings.md](../configure/settings.md)). See `file_mdm_exif` (`exif`) and
`file_mdm_font` (`font`) for real examples.
