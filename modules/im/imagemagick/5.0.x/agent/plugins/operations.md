# Toolkit operation plugins

These are core `ImageToolkit` **operation** plugins (plugin type defined by Drupal core, not
by this module — so `provides_plugin_types` is empty). ImageMagick provides an ImageMagick
implementation of each standard operation in
`src/Plugin/ImageToolkit/Operation/imagemagick/`, all via the `#[ImageToolkitOperation]`
attribute and extending `ImagemagickImageToolkitOperationBase`:

| Operation | File |
|---|---|
| `convert` | `Convert.php` |
| `create_new` | `CreateNew.php` |
| `crop` | `Crop.php` |
| `desaturate` | `Desaturate.php` |
| `resize` | `Resize.php` |
| `scale` | `Scale.php` |
| `scale_and_crop` | `ScaleAndCrop.php` |

Each is invoked by core when an image style effect calls
`$image->apply('<operation>', [...])`; the plugin translates the arguments into
`convert` CLI flags on the shared `ImagemagickExecArguments`.

## Add your own operation
Create a plugin in your module at
`src/Plugin/ImageToolkit/Operation/imagemagick/MyOp.php`:
```php
#[ImageToolkitOperation(
  id: 'my_op',
  toolkit: 'imagemagick',
  operation: 'my_op',
  label: new TranslatableMarkup('My op'),
  description: new TranslatableMarkup('...'),
)]
class MyOp extends ImagemagickImageToolkitOperationBase {
  protected function arguments() { /* declare accepted args */ }
  protected function execute(array $arguments) {
    $this->getToolkit()->arguments()->add(['-flip']);  // add convert flags
    return TRUE;
  }
}
```
For a one-off tweak to an existing operation prefer an event subscriber instead
([../extend/events.md](../extend/events.md)).
