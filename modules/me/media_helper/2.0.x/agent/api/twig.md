<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Media Helper Twig API

Provided by `Drupal\media_helper\Service\TwigExtension`. All accept: a media reference field, its render array, a media entity, or a numeric media ID (normalised by `getMedias()`).

Filters:
- `|media_image(style = '', classes = '', attributes = {})` — render an `<img>` (or responsive image). `style` may be an image style OR a responsive image style machine name; omit it to use the media's default-display style. `classes` is a string or array; `attributes` is name=>value.
- `|media_image_url(style = '')` — render the image URL only.
- `|media_video(classes = '', settings = {}, attributes = {})` — render an uploaded `video_file`. Default settings: autoplay TRUE, controls FALSE, loop TRUE, muted TRUE, `multiple_file_display_type` 'sources'; autoplay adds `disablePictureInPicture` + `playsinline`.
- `|media_first_nonempty` — given an iterable, return the first item that resolves to media (useful for fallbacks).

Functions:
- `media_bundle(input)` — bundle id, or `'mixed'` across differing bundles, or NULL.
- `media_source(input)` — media source plugin id, or `'mixed'`, or NULL.

Examples:
```twig
{{ node.field_media_image|media_image('500x500', ['a','b']) }}
{{ content.field_media_image|media_image_url('thumbnail') }}
{{ node.field_media_video|media_video('', { width: 200, height: 300 }) }}
{{ [node.field_media_image, fallback]|media_first_nonempty|media_image }}
{% if media_bundle(node.field_media) == 'image' %}...{% endif %}
```

Supported image sources: `image` (+ `svg` when `svg_image_field` integration is enabled). Access: only media passing `view` access render; empty/denied fields return render arrays that still bubble cache tags. Settings (`media_helper.settings`) toggle `integrations.svg_image.enable`, `integrations.svg_image_field.enable` + `.override_dimensions`, and `integrations.responsive_image.img_tag_attributes`.