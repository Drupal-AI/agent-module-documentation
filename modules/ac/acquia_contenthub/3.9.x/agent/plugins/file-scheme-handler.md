# FileSchemeHandler plugin type

The one plugin type the module defines. It teaches Content Hub how to export/import a file
depending on its stream-wrapper scheme (public, private, http, https, s3, …). The plugin id is
the **scheme name**; the correct handler is selected from a file's URI scheme.

- Manager: `acquia_contenthub.file_scheme_handler.manager`
  (`\Drupal\acquia_contenthub\Plugin\FileSchemeHandler\FileSchemeHandlerManager`).
- Discovery: annotation `@FileSchemeHandler` (`src/Annotation/FileSchemeHandler.php`), subdir
  `Plugin/FileSchemeHandler`, interface `FileSchemeHandlerInterface`, alter hook
  `hook_file_scheme_handler_info_alter`.
- Shipped handlers: `public`, `private`, `http`, `https`, plus an empty/fallback handler;
  the deprecated `acquia_contenthub_s3` submodule adds an `s3` handler.

## Interface (`FileSchemeHandlerInterface`)
```php
public function addAttributes(CDFObject $object, FileInterface $file); // write file data into the CDF on export
public function getFile(CDFObject $object);                            // materialize the file on import
```

## Implement one
```php
namespace Drupal\mymodule\Plugin\FileSchemeHandler;

use Drupal\acquia_contenthub\Plugin\FileSchemeHandler\FileSchemeHandlerInterface;
use Acquia\ContentHubClient\CDF\CDFObject;
use Drupal\file\FileInterface;
use Drupal\Core\Plugin\PluginBase;

/**
 * @FileSchemeHandler(
 *   id = "myscheme",
 *   label = @Translation("My scheme file handler")
 * )
 */
class MySchemeFileSchemeHandler extends PluginBase implements FileSchemeHandlerInterface {
  public function addAttributes(CDFObject $object, FileInterface $file) { /* … */ }
  public function getFile(CDFObject $object) { /* … */ }
}
```
`id` must equal the stream-wrapper scheme so the manager matches files with URIs like
`myscheme://…`. Look at `PublicFileSchemeHandler` / `PrivateFileSchemeHandler` for reference
implementations.
