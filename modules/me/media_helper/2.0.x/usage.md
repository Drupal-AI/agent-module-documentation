<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Media Helper adds Twig filters and functions (plus a "Rendered image" field formatter) that make it easy to render Media image and video entities — with image styles, classes, and attributes — directly in templates.
---
The Twig extension exposes filters `media_image`, `media_image_url`, `media_video`, and `media_first_nonempty`, and functions `media_bundle` and `media_source`. Each accepts flexible input — a media reference field, its render array, a media entity object, or a media ID — normalised by `TwigExtension::getMedias()`. The backing `media_helper` service resolves the media's source field and default-display image style, then builds a render array through the core image/responsive_image/file_video formatters, transparently supporting the Responsive Image module (pass a responsive style machine name) and optional `svg_image` / `svg_image_field` integrations configured at `/admin/config/media/media-helper`. Crucially, `renderMediaImage()`/`renderVideo()` call `$media->access('view')` and attach the media plus the access result as cacheable dependencies, so entity access is respected and cache metadata bubbles correctly.

There are no mutating routes: the only route is the settings form, gated by `administer site configuration`. SVG dimension reading uses `file_get_contents()` on the media's own file field URI (not user-supplied input). Typical setup: enable the module, optionally toggle SVG integrations on the settings page, then call the filters in your Twig templates. A `RenderedImage` field formatter is also provided for configuring the same rendering through the display UI.
---
- Render a media image in Twig: `{{ node.field_media_image|media_image('500x500') }}`.
- Render with the media's default-display image style by omitting the style argument.
- Add CSS classes to a rendered image: `|media_image('style', 'my-class')`.
- Add arbitrary HTML attributes to the rendered image tag.
- Output just the image URL with `|media_image_url('thumbnail')`.
- Render an uploaded video with `|media_video` and sensible autoplay defaults.
- Override video widget settings (autoplay/controls/loop/muted) inline.
- Pick the first non-empty media/field with `|media_first_nonempty`.
- Get a media entity's bundle in Twig via `media_bundle(...)`.
- Get a media entity's source plugin id via `media_source(...)`.
- Use a Responsive Image style name transparently in `media_image`.
- Enable `svg_image` integration to size SVGs from image-style effects.
- Enable `svg_image_field` integration and optionally override SVG dimensions.
- Configure integrations at `/admin/config/media/media-helper`.
- Apply the "Rendered image" field formatter in a display mode.
- Pass a media ID directly (e.g. `{{ 6|media_image }}`) in templates.
- Render a mixed set of media and detect "mixed" bundles/sources.
- Rely on built-in `view` access checks so unauthorised media are not rendered.
- Benefit from correct cache-tag bubbling for rendered media.
- Keep template logic minimal by delegating media rendering to the service.