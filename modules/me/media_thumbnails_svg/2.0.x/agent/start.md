# Media Thumbnails SVG — agent index

Adds one `MediaThumbnail` plugin that turns uploaded **SVG** media into **PNG** thumbnails
via the [Media Thumbnails](https://www.drupal.org/project/media_thumbnails) framework. No
config page, permissions, routes, Drush, or config schema of its own; settings come from the
parent `media_thumbnails.settings`.

- **The plugin: id, handled MIME types, rasterizer selection, output** →
  [plugins/svg-thumbnail.md](plugins/svg-thumbnail.md)
- **Where width / background color are configured (parent module settings)** →
  [configure/settings.md](configure/settings.md)

Key facts: plugin id `media_thumbnail_svg`, MIME `image/svg` + `image/svg+xml`. Rasterizer
priority GraphicsMagick → ImageMagick → GD (`meyfa/php-svg`). Output width/background read from
config object `media_thumbnails.settings` (`width`, `bgcolor_active`, `bgcolor_value`) at
`/admin/config/media/thumbnails`. Shipped defaults: `width: 500`, `bgcolor_active: false`,
`bgcolor_value: '#eeeeee'`.
