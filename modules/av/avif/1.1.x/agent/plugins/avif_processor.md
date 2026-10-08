# AvifProcessor plugin type

Avif defines one plugin type so the actual AVIF encoding backend is pluggable. The `processor` config
key holds the chosen plugin id; the `Avif` service instantiates it and calls `convert()`.

| Piece | Value |
| --- | --- |
| Manager service | `plugin.manager.avif_processor` |
| Manager class | `Drupal\avif\Plugin\AvifProcessorManager` (extends `DefaultPluginManager`) |
| Plugin subdir | `Plugin/AvifProcessor` |
| Interface | `Drupal\avif\Plugin\AvifProcessorInterface` |
| Base class | `Drupal\avif\Plugin\AvifProcessorBase` |
| Annotation | `Drupal\avif\Annotation\AvifProcessor` (`@AvifProcessor` with `id`, `label`) |
| Alter hook | `avif_avif_processor_info` |
| Cache | `avif_avif_processor_plugins` |

The interface has a single method:

```php
// AvifProcessorInterface
public function convert($image_uri, $quality, $destination);
// Return TRUE / destination path on success, FALSE on failure.
```

## Shipped plugin: `imagemagick`

`Plugin/AvifProcessor/ImageMagick.php` (id `imagemagick`, label "ImageMagick"). Its `convert()`:

1. Rejects the job (logs, returns FALSE) unless the active image toolkit lists `avif` in
   `ImageFactory::getSupportedExtensions()` **and** the toolkit id is exactly `imagemagick`.
2. `$this->imageFactory->get($image_uri, 'imagemagick')->apply('convert', ['extension' => 'avif', 'quality' => $quality])`
   then `->save($destination)`.

So encoding is delegated to the contrib **`drupal/imagemagick`** toolkit's `convert` operation (which
shells out to the ImageMagick binary and does its own argument escaping). This module does **not** call
GD, ImageMagick, or any CLI encoder directly. GD and CAVIF-RS are mentioned on the project page but no
such plugin ships in this release.

## Add your own processor

Create a plugin in your module at `src/Plugin/AvifProcessor/`:

```php
namespace Drupal\my_module\Plugin\AvifProcessor;

use Drupal\avif\Plugin\AvifProcessorBase;

/**
 * @AvifProcessor(
 *   id = "my_encoder",
 *   label = @Translation("My encoder")
 * )
 */
class MyEncoder extends AvifProcessorBase {

  public function convert($image_uri, $quality, $destination) {
    // Encode $image_uri to AVIF at $destination; return TRUE / path on success.
  }

}
```

Implement `ContainerFactoryPluginInterface` (like the shipped plugin) if you need injected services.
Then select "My encoder" on `/admin/config/media/avif`, or set `avif.settings:processor` to `my_encoder`.
A working example is the test plugin `tests/modules/avif_test/src/Plugin/AvifProcessor/AvifTestProcessor.php`.
