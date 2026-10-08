<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Video Embed Panopto (video_embed_panopto) — agent index

Adds **Panopto** as a provider for [Video Embed Field](https://www.drupal.org/project/video_embed_field),
so a Panopto viewer/embed URL pasted into a `video_embed_field` renders as an embedded Panopto
player. The entire module is one plugin class — `src/Plugin/video_embed_field/Provider/Panopto.php`
(a `@VideoEmbedProvider`, id `panopto`) — plus `.info.yml` and `LICENSE.txt`. It implements the
three provider hooks Video Embed Field calls: `getIdFromInput()` recognises Panopto URLs and stores
an internal `<host>|<sessionId>` string, `renderEmbedCode()` returns the `<iframe>` render array
pointing at `…/Panopto/Pages/Embed.aspx`, and `getRemoteThumbnailUrl()` returns the Panopto Public
API preview-image URL. There is no UI, config, route, service, or permission of its own — install
it, then use Video Embed Field's own field, widget and formatters.

- Depends on: `video_embed_field:video_embed_field` (the only dependency; installed here at 3.1.0).
- Core: `^8 || ^9 || ^10 || ^11`. Package: `Media`. No `configure` route, no permissions, no drush,
  no config schema, no services, no hooks.
- Provides one **plugin instance** (a Video Embed Field provider), not a plugin type.
- Because Panopto embeds carry the institution's Panopto server hostname, both the player iframe and
  the thumbnail request are per-video (the host comes from the pasted URL, not a fixed CDN).
- Panopto content is frequently **restricted to authenticated members of an institution**, so an
  embed that plays for a signed-in staff member may render nothing for an anonymous visitor — that is
  Panopto's own access control, not Drupal's. Establish which folders are public before assuming
  embeds display for the intended audience.

## What you'd do → where

- **Understand the provider plugin — accepted URL formats, the `host|id` encoding, the iframe/
  thumbnail output, and how Video Embed Field calls it** → [plugins/provider.md](plugins/provider.md)
- **Configure the field, widget, formatters (Video / Video URL / Thumbnail), autoplay, dimensions,
  responsive, media integration** → these are all Video Embed Field's, documented under that module.

## Key facts (real machine names)

- Provider plugin id: `panopto` (annotation `@VideoEmbedProvider`, class
  `Drupal\video_embed_panopto\Plugin\video_embed_field\Provider\Panopto`, extends
  `Drupal\video_embed_field\ProviderPluginBase`).
- Accepted input URLs (case-insensitive):
  `//<host>/Panopto/Pages/Viewer.aspx?id=<id>` and `//<host>/Panopto/Pages/Embed.aspx?id=<id>`.
- Stored field value (the "video id"): `<host>|<id>` (pipe-delimited).
- Iframe `src` built at render: `//<host>/Panopto/Pages/Embed.aspx?id=<id>&v=1&autoplay=<true|false>`.
- Remote thumbnail URL: `https://<host>/Panopto/PublicAPI/SessionPreviewImage?id=<id>`.
- Provider methods implemented: `getIdFromInput($input)`, `renderEmbedCode($width, $height,
  $autoplay, $title_format = NULL, $use_title_fallback = TRUE)`, `getRemoteThumbnailUrl()`.
- No routes, permissions, services, config keys, libraries, or drush commands.
