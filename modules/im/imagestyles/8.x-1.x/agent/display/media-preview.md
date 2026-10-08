<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# imagestyles — media-page preview mechanism

All rendering lives in `imagestyles.module` (procedural). Entry point:
`imagestyles_preprocess_media(&$variables)` (an implementation of `template_preprocess_media`).

## Guard conditions

The hook does nothing unless **both** hold:

1. Current route is `entity.media.canonical` (`\Drupal::routeMatch()->getRouteName()`), i.e. the
   standalone media page — hence the README requirement to enable Standalone media URLs.
2. The media entity's source plugin id is `image`
   (`$variables['elements']['#media']->getSource()->getPluginId() == 'image'`).

So it only acts on an image media entity's own page — a page whose access is already governed by
core media view access. It reads the media entity handed to it; nothing here consumes request
parameters, a user-supplied file path, or a user-supplied style name.

## What it builds

- `imagestyles_get_image_uri($media_entity)` walks the entity to the file: finds the image field
  via `imagestyles_get_image_field_name()` (first field whose `getType() == 'image'`), takes
  `->first()->get('entity')->getTarget()`, and returns that **file entity's own `uri`**. This URI
  is the source for every preview — it is the managed file, not an arbitrary path.
- `ImageStyle::loadMultiple()` loads all site image styles. For each (skipping a style literally
  named `original`), `imagestyles_render_image_style()` builds a `details` render array via
  `imagestyles_render_array()` using `#theme => 'image_style'` with `#style_name` +
  `#uri` — i.e. core generates/serves the derivative the normal way (lazily, access-checked by
  core's image-style route). Effect labels come from `$style->getEffects()` →
  `$effect->label()` + `$effect->getSummary()`.
- The **original** image is added with `#theme => 'image'` (no style) plus a `width x height`
  string from `$source->getMetadata($media_entity, 'width'|'height')`.
- Each `details` element is open when `!empty($config[$style_name])` where `$config` is
  `imagestyles.settings:expanded_styles` (see config/settings.md).
- The module then **unsets** the default field output —
  `unset($variables['content'][$field_name])` for the detected image field — and prepends an
  anchor-link index (`#theme => 'item_list'`, `#weight => -999`) built by
  `imagestyles_header_item()` (`Url::fromUserInput('#imagestyles-style-<name>')` →
  `Link::fromTextAndUrl`). Element ids come from `imagestyles_style_id()` →
  `imagestyles-style-<style_name>`.

## Operational notes

- **First-load cost:** because each style renders via `#theme => 'image_style'`, the first view of
  a media page triggers generation of any missing derivative for **every** image style, for that
  one image. Subsequent views serve cached derivatives. Many styles = a slow first render for that
  page only.
- **Assumptions that can break:** the code assumes the image field's first item has a resolvable
  file entity; a media item with an empty/broken image reference can raise
  `MissingDataException` (declared in the helper docblocks) during preprocess.
- **`original` collision:** a real image style whose machine name is `original` is skipped by the
  per-style loop and represented only by the synthetic original-image preview.
- No effect on non-image media, non-canonical routes, listings, or embeds.
