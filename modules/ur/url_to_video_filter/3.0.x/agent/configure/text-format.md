# Configure — enable the filter on a text format

The filter has no admin route of its own; you configure it inside a text format at
`/admin/config/content/formats/manage/<format>`. Tick **"Convert URLs to embedded videos"** in the
filter list, then set the per-format options in that filter's settings vertical tab.

## Settings (config schema `filter_settings.filter_url_to_video`)

| Key | Type | Default | Effect |
|---|---|---|---|
| `youtube` | boolean | `FALSE` | Recognise YouTube URLs (`youtube.com/watch`, `youtube.com/embed/…`, `youtu.be/…`). |
| `vimeo` | boolean | `FALSE` | Recognise Vimeo URLs (`vimeo.com/…`). |
| `youtube_webp_preview` | boolean | `FALSE` | Use a WebP thumbnail (`i.ytimg.com/vi_webp/…`) instead of JPG. UI note warns it is not compatible with some browsers; the settings-form element is only shown when `youtube` is on and `autoload` is off. Sets `drupalSettings.urlToVideoFilter.youtubeWebp`. |
| `autoload` | boolean | `FALSE` | Load the player `<iframe>` on page load instead of showing a click-to-play thumbnail. Sets `drupalSettings.urlToVideoFilter.autoload`. |

All four default to `FALSE`, so a freshly-enabled filter converts nothing until you turn on
`youtube` and/or `vimeo`. `settingsSummary()` shows `YouTube: On/Off` and `Vimeo: On/Off` in the
format's filter list (`youtube_webp_preview`/`autoload` are not summarised).

## Filter order (important)

- The filter emits raw `<span>…</span>` placeholder markup. If the format also runs **"Limit
  allowed HTML tags and correct faulty HTML"** (`filter_html`), that filter must run **before**
  this one, otherwise the placeholder spans/attributes get stripped and no video renders. The
  module's default weight is `0`, and `filter_html` runs at `-10`, so the default order is already
  correct.
- If the format also runs core's **"Convert URLs into links"** (`filter_url`), put
  `filter_url_to_video` **before** it, or the video URL is turned into an `<a>` first and no longer
  matches.

## Enable programmatically

```php
$f = \Drupal\filter\Entity\FilterFormat::load('basic_html');
$f->setFilterConfig('filter_url_to_video', [
  'status' => TRUE,
  'weight' => 0,
  'settings' => [
    'youtube' => TRUE,
    'vimeo' => TRUE,
    'youtube_webp_preview' => FALSE,
    'autoload' => FALSE,
  ],
]);
$f->save();
```

Then `drush cr`. Editors embed a video by pasting its URL on its own line (or preceded by a space /
a closing `]` or `>`); URLs inside HTML attributes are deliberately skipped so markup is not broken.
