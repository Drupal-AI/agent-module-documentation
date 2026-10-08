<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `media_directories_image_resize` filter

`Drupal\media_directories_image_resize\Plugin\Filter\ImageResize` — the module's only class.

```php
#[Filter(
  id: "media_directories_image_resize",
  title: new TranslatableMarkup("Resize images"),
  description: new TranslatableMarkup("Resizes images that have width and height attributes set. Place this filter after other filters that may add images."),
  type: FilterInterface::TYPE_TRANSFORM_REVERSIBLE,
  weight: 20,
)]
final class ImageResize extends FilterBase implements ContainerFactoryPluginInterface {
  const DERIVATIVE_DIRECTORY = 'public://resize';
}
```

Injected services: `image.factory`, `file_system`, `file_url_generator`,
`stream_wrapper_manager`. **No settings** — the plugin declares none, so there is no
settings form and no `filter_settings.*` schema.

## Algorithm (exactly what `process()` does)

1. Return unchanged unless `stripos($text, '<img ') !== FALSE`.
2. `Html::load()` + XPath `//img[@width and @height and @src]`.
3. Per element: cast `width`/`height` to `int`; skip if either is `<= 0` or `src` is empty.
4. `resolveUri($src)`:
   - `parse_url($src, PHP_URL_PATH)` (drops query/fragment); skip if unparsable.
   - Get the public wrapper; it must be a `LocalStream`.
   - The path must contain `/{public directory path}/` (e.g. `/sites/default/files/`);
     the part after it becomes `public://{relative}`.
   - The file must exist. Otherwise return `NULL` → element skipped.
   → **External URLs, private:// and missing files are never touched.**
5. Skip when the URI (lowercased) ends in `.svg` — vector images cannot be bitmap-resized.
6. `getDerivativeUri()`:
   `public://resize/{width}x{height}/` + the source's directory (if not `.`) + filename.
   `public://subdir/pic.png` at 50×50 → `public://resize/50x50/subdir/pic.png`.
7. If the derivative does not exist, `createDerivative()`:
   - `prepareDirectory(dirname, CREATE_DIRECTORY)`,
   - `image.factory->get($source)`; return FALSE when `!isValid()`,
   - **return FALSE when the source is already exactly `width`×`height`** (no derivative,
     `src` unchanged),
   - `$image->resize($w, $h)` then `$image->save($derivative_uri)`.
   A FALSE result means the element is left alone.
8. On success: `src` = `file_url_generator->generateString($derivative_uri)`.
   `width`/`height` attributes are **not** removed.
9. `setProcessedText()` only if at least one element changed.

Note `resize()` here is a plain resize to the exact box — it does **not** preserve aspect
ratio. Whatever the editor put in `width`/`height` is what you get.

## Enabling it

UI: *Configuration → Content authoring → Text formats and editors* → edit a format → tick
**Resize images** → drag it **after** any filter that inserts images (media embed,
`media_directories_legacy_embed`, etc.) → Save.

```bash
drush php:eval '
  $f = \Drupal\filter\Entity\FilterFormat::load("full_html");
  $f->setFilterConfig("media_embed", ["status" => TRUE, "weight" => 10]);
  // Higher weight = runs later.
  $f->setFilterConfig("media_directories_image_resize", ["status" => TRUE, "weight" => 50, "settings" => []]);
  $f->save();'

# Confirm.
drush cget filter.format.full_html filters.media_directories_image_resize
```

## Running it manually / debugging

```bash
drush php:eval '
  $f = \Drupal\filter\Entity\FilterFormat::load("full_html");
  $plugin = $f->filters()->get("media_directories_image_resize");
  $html = "<p><img src=\"/sites/default/files/pic.png\" width=\"60\" height=\"40\" /></p>";
  print $plugin->process($html, "en")->getProcessedText() . "\n";
  print "derivative exists: " . var_export(file_exists("public://resize/60x40/pic.png"), TRUE) . "\n";'
```

Nothing happened? Check, in order: both `width` and `height` present and `> 0`; `src`
resolves under the public files path and the file exists; not an `.svg`; the source is not
already exactly that size; GD/ImageMagick can open the file.

Purge every generated derivative:

```bash
drush php:eval '\Drupal::service("file_system")->deleteRecursive("public://resize");'
```

## Not provided

No settings form, no config object, no schema, no permissions, no services, no hooks, no
Drush commands, no theming. The module ships exactly `*.info.yml`, the filter class and a
kernel test.
