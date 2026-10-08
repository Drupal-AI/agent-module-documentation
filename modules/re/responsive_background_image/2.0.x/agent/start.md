# Responsive Background Image — agent index

Developer helper: generate a `<style>` tag of media queries that apply a Responsive Image Style as a
responsive `background-image`. No UI, no config, no permissions. Depends on core `responsive_image`.

- **The one static method, its parameters, return shape, and preprocess usage** →
  [api/generate.md](api/generate.md)

Key facts:
- Only public API: `\Drupal\responsive_background_image\ResponsiveBackgroundImage::generateMediaQueries()`.
- Call it from `hook_preprocess_HOOK()`; assign the result to `$vars['#attached']['html_head'][]`.
- Supports classic Image fields, Media image fields, or a `File` entity; requires a Responsive Image Style
  using the single-image-style-per-breakpoint option.
