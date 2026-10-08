<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Markup, theme hooks and the URL alter

## Theme hooks

`glightbox_media_video_theme()` registers two, both with their preprocessors in
`glightbox_media_video.theme.inc`:

| Hook | Template | Variables |
|---|---|---|
| `glightbox_media_remote_video_formatter` | `glightbox-media-remote-video-formatter.html.twig` | `remote_video`, `thumb`, `entity`, `settings` |
| `glightbox_media_file_video_formatter` | `glightbox-media-file-video-formatter.html.twig` | `file_video`, `thumb`, `entity`, `settings` |

Override either in your theme by copying the template into `mytheme/templates/`.

## What the preprocessors build

Both start from `$classes_array = ['glightbox', 'glightbox-media-video']` and assemble an anchor:

```php
$variables['attributes']['title']         = $caption;                 // when a caption resolves
$variables['attributes']['data-glightbox'] = "title: $caption";
$variables['attributes']['data-glightbox'] = "description: $caption_description";  // see note
$variables['attributes']['data-gallery']  = $gallery_id;              // when grouping is on
$variables['attributes']['class']         = $classes_array;
```

Remote video `href`:

```php
$variables['attributes']['href'] = $variables['entity']->field_media_oembed_video->value;
if ($youtube_id = _glightbox_media_video_extract_youtube_video_id($href)) {
  $variables['attributes']['href'] = 'https://www.youtube-nocookie.com/embed/' . $youtube_id;
}
\Drupal::moduleHandler()->alter('url', $variables['attributes']['href']);
```

Local video `href` is the absolute file URL via
`file_url_generator->generateAbsoluteString()`. The local-video preprocessor runs the caption
through `Xss::filter()`; the remote-video one assigns it raw (still safe — it goes through
Drupal's attribute escaping).

**Caption/description caveat:** both branches write to the *same* `data-glightbox` key, so
configuring a caption **and** a description leaves only `description: …` on the element — the
title is overwritten. Set one or the other, or override the template if you need both.

## The URL alter hook — read before implementing

`glightbox_media_video.api.php` documents:

```php
function hook_glightbox_media_video_url_alter(string &$video_url) { … }
```

but the actual call is `\Drupal::moduleHandler()->alter('url', $href)`, which Drupal resolves to
**`hook_url_alter()`**, not the documented name. So to change the video URL today you implement:

```php
/**
 * Implements hook_url_alter().
 *
 * NOTE: glightbox_media_video calls alter('url', …) despite documenting
 * hook_glightbox_media_video_url_alter(). Guard your implementation — this hook name is
 * generic and any other module calling alter('url') will reach you too.
 */
function mymodule_url_alter(&$url) {
  if (is_string($url) && str_contains($url, 'vimeo.com/')) {
    $id = basename(parse_url($url, PHP_URL_PATH));
    $url = 'https://player.vimeo.com/video/' . $id;
  }
}
```

Because the hook name is unqualified there is no context parameter — you cannot tell which entity
or formatter triggered it. If that matters, prefer a template override or a preprocess hook:

```php
function mytheme_preprocess_glightbox_media_remote_video_formatter(&$variables) {
  // $variables['entity'] is the media entity; full context available here.
  $variables['attributes']['data-glightbox'] = 'title: ' . $variables['entity']->label();
}
```

Providers other than YouTube get no rewriting at all (there is a `@todo` in the source about
adding a prepare-alter for them), so Vimeo and friends open whatever the oEmbed field contains
unless you alter it.

## Library

```yaml
glightbox-media-video:
  css:
    theme:
      css/glightbox-media-video.css: {}
  js:
    js/glightbox-media-video.js: {}
  dependencies:
    - system/drupal.system
    - glightbox/glightbox
    - core/once
```

`js/glightbox-media-video.js` initialises the popups over the `.glightbox-media-video` elements
(guarded with `once`). To restyle the trigger, override the CSS in your theme via
`libraries-override`; to change initialisation options, override the JS file the same way.
