# Blazy service API

Key services (from `blazy.services.yml`):

- `blazy.manager` (`Drupal\blazy\BlazyManager`) — main entry: build lazy-loaded render arrays,
  attach libraries, resolve settings. Prefer the helper `blazy()` in `blazy.module`.
- `blazy.formatter` (`Drupal\blazy\BlazyFormatter`) — build field-formatter output (grids,
  media switch, ratio) programmatically.
- `blazy.oembed` (`Drupal\blazy\Media\BlazyOEmbed`) / `blazy.media` — resolve remote video/oEmbed.
- `blazy.entity`, `blazy.file`, `blazy.svg` — entity, file, and SVG helpers.
- `blazy.libraries`, `blazy.config` — asset discovery and cached config access.
- `blazy.skin` (`SkinManager`) — the BlazySkin plugin manager (see plugins/skin.md).

Render an image or media item lazily:
```php
$build = \Drupal::service('blazy.manager')->getBlazy([
  'settings' => [
    'image_style' => 'large',
    'ratio' => 'fluid',
    'lazy' => 'blazy',
  ],
  'uri' => $file->getFileUri(),
]);
// or the shorthand service accessor:
$build = blazy()->getBlazy($data);
```

Build a grid of items:
```php
$elements = blazy()->build([
  'items' => $items,          // each an array with 'settings' + content
  'settings' => ['grid' => 4, 'style' => 'grid'],
]);
```

The `api/` reference example function `my_module_render_blazy()` in `blazy.api.php` documents the
expected `$build` structure. Interfaces: `BlazyManagerInterface`, `BlazyFormatterInterface`.
