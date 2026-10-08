<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Instagram provider plugin

The whole module is this one plugin. It adds Instagram to Video Embed Field's set of providers
(YouTube, Vimeo, …); it does **not** define a plugin type of its own.

- Class: `Drupal\video_embed_instagram\Plugin\video_embed_field\Provider\Instagram`
  (`src/Plugin/video_embed_field/Provider/Instagram.php`).
- Plugin id: `instagram`. Annotation: `@VideoEmbedProvider(id="instagram", title=@Translation("Instagram"))`.
- Plugs into Video Embed Field's provider plugin type: discovery dir
  `Plugin/video_embed_field/Provider`, manager service `video_embed_field.provider_manager`
  (`Drupal\video_embed_field\ProviderManager`).
- Base class: `Drupal\video_embed_field\ProviderPluginBase`. This module overrides three methods and
  inherits everything else (construction, thumbnail download, title formatting, caching).

## URL recognition — `Instagram::getIdFromInput($input)` (static)

```php
preg_match('/^https?:\/\/(www)?\.instagram\.com\/(p|reel|tv)\/(?<id>[a-zA-Z0-9]*)\/?/', $input, $matches);
return $matches['id'] ?? FALSE;
```

Captures the post shortcode (named group `id`, `[a-zA-Z0-9]`) from the three Instagram path forms
`/p/`, `/reel/`, `/tv/` and returns it, or `FALSE` when there is no match. The base class'
`isApplicable()` calls this and treats a non-empty id as "this provider handles the URL", so an
editor selects Instagram simply by pasting a recognised URL into a Video Embed Field field
(`http` and `https` both accepted).

Functional quirk to be aware of: `(www)?\.instagram\.com` requires a literal dot **before**
`instagram.com`, so a bare `https://instagram.com/p/…` (no `www.`) does not match — only
`https://www.instagram.com/…` (or a URL that happens to have a leading dot) is recognised. See
`tests/src/Unit/ProviderUrlParseTest.php` (group `video_embed_instagram`) for the covered cases.

## Embed markup — `renderEmbedCode($width, $height, $autoplay, $title_format = NULL, $use_title_fallback = TRUE)`

Returns a render array of `#type => 'video_embed_iframe'`:

- `#provider => 'instagram'`
- `#url => sprintf('https://instagram.com/p/%s/embed', $this->getVideoId())` — always the `/p/…/embed`
  form, even for `reel`/`tv` inputs (the shortcode is the same).
- `#attributes => width, height, frameborder=0, allowfullscreen`, plus a `title` attribute when
  `getName($title_format, $use_title_fallback)` (base class) yields one — added for iframe
  accessibility.

The `video_embed_iframe` render element lives in Video Embed Field
(`src/Element/VideoEmbedIFrame.php`) and themes to `<iframe{{ attributes }} src="{{ url }}">` via
`templates/video-embed-iframe.html.twig`. `$autoplay` is accepted but unused (Instagram's embed
endpoint has no autoplay parameter).

**Deprecation on the horizon.** In `video_embed_field:3.1.0` (the installed version) the provider
API moved from `renderEmbedCode()` to `renderEmbed(array $options)`; `renderEmbedCode()` is
deprecated and slated for removal in `video_embed_field:3.2.0`. This module still overrides only
`renderEmbedCode()`. VEF's base `ProviderPluginBase::renderEmbed()` delegates back to it as a
backward-compatibility shim, so embeds render correctly today, but the module will need to implement
`renderEmbed()` before VEF 3.2.0 drops the shim.

## Thumbnail — `getRemoteThumbnailUrl()`

Returns `sprintf('https://instagr.am/p/%s/media/?size=l', $this->getVideoId())`. The base class
(`downloadThumbnail()` / `getLocalThumbnailUri()`) fetches it once and stores it at
`{default_scheme}://video_thumbnails/{id}.jpg` for use as the teaser image; retrieval is best-effort
(failures are swallowed).

## Consuming from code

There is nothing module-specific to call — use Video Embed Field's provider manager:

```php
/** @var \Drupal\video_embed_field\ProviderManagerInterface $manager */
$manager = \Drupal::service('video_embed_field.provider_manager');
$provider = $manager->loadProviderFromInput('https://www.instagram.com/p/BDAtHPYSeO4/');
// $provider is an Instagram instance; render via the field formatter as usual.
```
