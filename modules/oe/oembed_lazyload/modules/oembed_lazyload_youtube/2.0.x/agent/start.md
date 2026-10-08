<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# oEmbed lazy load YouTube enhancer — agent index

Submodule of **oEmbed lazy load**. Adds a `youtube` ProviderEnhancer plus YouTube player
options (stored as third-party settings on the `lazyload_oembed` formatter). Requires
`oembed_lazyload`. No permission, route, service or config entity of its own.

- **The YouTube enhancer + the third-party player-option settings and where they're stored** →
  [configure/youtube.md](configure/youtube.md)

Key facts:
- Enhancer: `@ProviderEnhancer(id: youtube, providers: {YouTube})` extending
  `ProviderEnhancerBase` — parses the video/playlist/shorts id, adds a JS library, and rewrites
  the iframe URL with player params in `alterOembedResponse()`.
- Player options are third-party settings on the formatter component, keyed
  `oembed_lazyload_youtube`: `autoplay`, `modestbranding`, `enablejsapi`, `origin`, `hideinfo`
  (deprecated), `rel` (all boolean). Added via
  `hook_field_formatter_third_party_settings_form()` on the `lazyload_oembed` formatter.
- Stored at `core.entity_view_display.<entity>.<bundle>.<mode>` →
  `content.<field>.third_party_settings.oembed_lazyload_youtube.<option>`.
  Schema: `field.formatter.third_party.oembed_lazyload_youtube`.
- Template suggestion `oembed_lazyload_placeholder__youtube`; settings-summary theme hook.
- See the parent's [ProviderEnhancer plugin type](../../../../2.0.x/agent/plugins/provider-enhancer.md).
