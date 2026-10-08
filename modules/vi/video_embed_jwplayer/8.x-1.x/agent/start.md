<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Video Embed JW Player (video_embed_jwplayer) — agent index

Adds **JW Player / JW Platform** as a provider to **Video Embed Field** (`drupal/video_embed_field`).
An editor pastes a JW Player embed/preview URL into a `video_embed_field` field; this module's one
plugin, `JwPlayer`, recognises the URL, extracts the `MEDIAID-PLAYERID` combined id from it, and
renders an `<iframe>` pointing at `//content.jwplatform.com/players/<id>.html`. It also derives the
poster/thumbnail URL (`https://cdn.jwplayer.com/thumbs/<mediaid>-720.jpg`) that the parent module
downloads and caches. That is the entire module — one class,
`src/Plugin/video_embed_field/Provider/JwPlayer.php`, extending `ProviderPluginBase`.

Everything else — the field type/widget, the "Video" formatter/thumbnail formatter, the WYSIWYG and
media-source integration, and the iframe render element — comes from `video_embed_field`. Provider
plugins are deliberately tiny: they only answer "is this my URL?", "what is the id?", and "what
markup/thumbnail?".

- Depends on: `video_embed_field:video_embed_field`. No other libraries.
- Core: `^8 || ^9 || ^10 || ^11`. Package: `Video Embed Field`. Version `8.x-1.4`.
- **No** settings page / `configure` route, **no** routes, **no** services, **no** permissions,
  **no** hooks, **no** drush, **no** config schema, **no** `.module`/`.install` file.
- Defines **no** plugin type; it supplies one **instance** of the parent's `VideoEmbedProvider`
  plugin type (id `jwplayer`).

## What you'd do → where

- **Understand/extend the JW Player provider plugin — URL formats it accepts, the id/thumbnail
  extraction, the iframe it emits, and how to add your own provider like it** →
  [plugins/provider.md](plugins/provider.md)

## Key facts (real machine names)

- Plugin: `VideoEmbedProvider` id **`jwplayer`**, title "JW Player", class
  `Drupal\video_embed_jwplayer\Plugin\video_embed_field\Provider\JwPlayer`, annotation
  `@VideoEmbedProvider`, discovery dir `src/Plugin/video_embed_field/Provider/`.
- Base class: `Drupal\video_embed_field\ProviderPluginBase`.
- Methods: `renderEmbedCode($width, $height, $autoplay)`, `getRemoteThumbnailUrl()`,
  `getRemoteThumbnailWidth()`, `getJwPlayerMediaId()`, `getJwPlayerPlayerId()`, static
  `getIdFromInput($input)`.
- Constant: `REMOTE_THUMBNAIL_WIDTH = 720`.
- Render element emitted: `video_embed_iframe` (parent), `#provider => 'jwplayer'`,
  `#url => '//content.jwplatform.com/players/<id>.html'`.
- Thumbnail template: `https://cdn.jwplayer.com/thumbs/<mediaid>-<width>.jpg`.
- URL-match regex: `@\/\/\w+\.(jwplayer|jwplatform)\.com\/[^\/]+\/(?<id>[\_\-a-zA-Z0-9]+)@i`.
- Combined id format: `MEDIAID-PLAYERID` (media id = before the first `-`, player id = after).
