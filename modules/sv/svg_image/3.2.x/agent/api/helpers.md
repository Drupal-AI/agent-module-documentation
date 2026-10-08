# Helper functions & sanitization

Procedural helpers in `svg_image.module` (usable from any custom code/theme):

```php
// Is this file an SVG? (checks mime === 'image/svg+xml')
svg_image_is_file_svg(\Drupal\file\Entity\File $file): bool

// Best-effort dimensions for an image/SVG file. Reads the SVG's width/height
// attributes; falls back to 64x64. Returns ['width' => int, 'height' => int].
svg_image_get_image_file_dimensions(\Drupal\file\Entity\File $file): array
```

Preprocess hook:
- `svg_image_preprocess_image_style()` — forces access and adds a `no-image-style` class so
  an SVG still renders when a (raster-only) image style would otherwise hide it.

Sanitization:
- Inline SVG output always passes through `enshrined\svgSanitize\Sanitizer::sanitize()`
  (library `enshrined/svg-sanitize`) inside `SvgImageFormatterTrait::fileGetContents()`,
  removing scripts/unsafe nodes before the markup is printed. This is the module's core
  security guarantee for user-uploaded SVGs.

No services, no Drush commands, no permissions, no `.api.php` hooks are defined — the module
is entirely hook-alter + trait based.
