<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Video Embed Instagram (video_embed_instagram) — agent index

Adds **Instagram** as a provider for **Video Embed Field**, so an Instagram post/reel/tv URL pasted
into a Video Embed Field field renders as an embedded iframe alongside YouTube and Vimeo. The entire
module is a single provider plugin (`src/Plugin/video_embed_field/Provider/Instagram.php`, id
`instagram`) that extends VEF's `ProviderPluginBase`: it extracts the post shortcode from the URL
with a regex, builds an `https://instagram.com/p/{id}/embed` iframe, and offers a remote thumbnail
URL. There is no configuration, route, permission, service, hook or drush command of its own —
width/height, image style and title options all come from Video Embed Field's field formatter.

- **Depends on:** `video_embed_field:video_embed_field` (Composer `drupal/video_embed_field:^3`;
  installed VEF is 3.1.0).
- **Core:** `^10.3 || ^11`. **Package:** Video Embed Field.
- **Release:** `3.0.0-beta1` — beta.
- **Settings page / configure route:** none. **Permissions:** none. **Drush:** none.
  **Plugin types defined:** none (it provides one plugin *instance* of VEF's provider type).
- Non-code adoption caveats (platform, not this code):
  - Instagram's embed rules and API terms have changed repeatedly; a beta module tracking them
    deserves version pinning and periodic re-testing.
  - Embeds require the source post to stay **public** — a private post breaks the embed with no
    signal in Drupal.
  - Rendering loads Meta's embed script into the visitor's browser. On a site with a consent
    manager (e.g. `simple_klaro`) that script should be gated behind consent, not loaded
    unconditionally.
  - The provider still implements only `renderEmbedCode()`, deprecated in VEF 3.1.0 and removed in
    3.2.0 (VEF's base class shims it today). See the plugin topic.

## What you'd do → where
- Understand/extend the provider (URL patterns, embed & thumbnail URLs, deprecation) →
  [plugins/instagram-provider.md](plugins/instagram-provider.md)
- Change how embeds look (size, image style, autoplay, title) → configure Video Embed Field's field
  formatter; this module adds no settings.
- Debug rendering/thumbnails → start in Video Embed Field; this module only supplies URLs.

## Key facts (real machine names)
- Provider plugin: id `instagram`, class
  `Drupal\video_embed_instagram\Plugin\video_embed_field\Provider\Instagram`, annotation
  `@VideoEmbedProvider`.
- Recognised URL forms: `https?://www.instagram.com/{p|reel|tv}/{shortcode}` →
  `Instagram::getIdFromInput()` (shortcode is `[a-zA-Z0-9]`).
- Embed URL: `https://instagram.com/p/{id}/embed` via render `#type => video_embed_iframe`
  (`#provider => instagram`).
- Thumbnail URL: `https://instagr.am/p/{id}/media/?size=l`.
- Extends `Drupal\video_embed_field\ProviderPluginBase`; consumed through VEF's
  `video_embed_field.provider_manager` service.
- Tests: `tests/src/Unit/ProviderUrlParseTest.php` (group `video_embed_instagram`).
