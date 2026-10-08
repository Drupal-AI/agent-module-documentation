<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
- What: a Field formatter plugin (`AmpVideoEmbedFormatter`) that outputs AMP-valid video markup for `video_embed_field` fields.
- When: you serve AMP pages via the AMP module and need embedded videos to validate as AMP.

---

- Requires the AMP module (`amp`) and Video Embed Field (`video_embed_field`), plus core `field` and `image`.
- Enable the module, then on a `Video Embed Field` field's Manage Display, choose the AMP video formatter.

---

- Registers a `@FieldFormatter` plugin usable on any `video_embed_field` field.
- Renders provider-specific AMP components (e.g. `<amp-youtube>`, `<amp-vimeo>`) via Twig templates in `templates/`.
- Depends on Video Embed Field's provider plugins to resolve the video ID and provider.
- Only takes effect when the display is rendered in an AMP context/theme.
- Use it on article or media view modes that are exposed through AMP routes.
- Configure width/height defaults through the standard formatter settings where exposed.
- No routes, permissions, or services are added; it is display-layer only.
- Pair with the AMP theme so the emitted `<amp-*>` tags are allowed by the AMP validator.
- Falls back to Video Embed Field's normal rendering on non-AMP displays.
- Add the required AMP `<script>` component tags via the AMP module's library handling.
- Test with Google's AMP validator after assigning the formatter.
- Supports the providers that Video Embed Field itself supports (YouTube, Vimeo).
- Assign per view mode so canonical (non-AMP) pages keep the standard player.
- Clear caches after changing the formatter so the display config rebuilds.
- The module is packaged as `Other`; treat it as a thin bridge between AMP and video_embed_field.
- Version 2.0.x targets Drupal 9.3+ and 10.
