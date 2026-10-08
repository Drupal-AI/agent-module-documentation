<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# YouTube enhancer + player options

## The enhancer

`YoutubeEnhancer` — `@ProviderEnhancer(id: youtube, providers: {YouTube})`, extends
`ProviderEnhancerBase`. It:
- parses the video id from `watch?v=`, `youtu.be/`, `/v/`, `playlist?list=`, `shorts/` URLs
  (`getEmbedCode()`), stripping query/fragment;
- adds `oembed_lazyload_youtube/youtube` to `getLibraries()`;
- sets the placeholder's `#third_party_settings['embed_code']`;
- in `alterOembedResponse()` appends YouTube player params to the iframe URL based on the
  formatter's third-party settings (and, for `origin`, uses `media.settings:iframe_domain` or the
  request host).

## Player options (third-party settings on the `lazyload_oembed` formatter)

Added by `hook_field_formatter_third_party_settings_form()`; shown as a **YouTube settings**
section on *Manage display* when the field uses the Lazy load oEmbed formatter. All boolean:

| Key | Effect |
|---|---|
| `autoplay` | attempt to auto-play |
| `modestbranding` | hide the YouTube logo |
| `enablejsapi` | allow control via the YouTube IFrame API |
| `origin` | restrict IFrame API to the oEmbed iframe host (only meaningful with `enablejsapi`) |
| `hideinfo` | hide title/uploader (**deprecated** YouTube param) |
| `rel` | only show related videos from the same channel |

## Where they are stored

```
core.entity_view_display.<entity>.<bundle>.<view_mode>
  content:
    <field_name>:
      type: lazyload_oembed
      third_party_settings:
        oembed_lazyload_youtube:
          autoplay: true
          modestbranding: false
          enablejsapi: false
          origin: false
          hideinfo: false
          rel: false
```

Schema: `field.formatter.third_party.oembed_lazyload_youtube`.

## Programmatic (drush php:eval)

```php
$vd = \Drupal::entityTypeManager()->getStorage('entity_view_display')
  ->load('node.article.default');
$c = $vd->getComponent('field_video_url');          // must already use lazyload_oembed
$c['third_party_settings']['oembed_lazyload_youtube']['autoplay'] = TRUE;
$vd->setComponent('field_video_url', $c)->save();
```

Read back with `$vd->getComponent($field)['third_party_settings']['oembed_lazyload_youtube']`.
Theme the YouTube placeholder via the `oembed_lazyload_placeholder__youtube` suggestion (see the
parent's [theming doc](../../../../../2.0.x/agent/theming/templates.md)).
