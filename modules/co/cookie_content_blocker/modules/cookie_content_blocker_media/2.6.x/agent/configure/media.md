<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure media blocking

## Settings form

Route `cookie_content_blocker_media.settings` →
`/admin/config/user-interface/cookie-content-blocker/media` (perm
`administer cookie content blocker`, borrowed from the parent). `MediaSettingsForm` enumerates every
media-source plugin that declares `providers` and renders a fieldset per provider. Config object:
`cookie_content_blocker_media.settings`, key `providers` (default `null`), a tree keyed by provider
name with per-provider values: `blocked` (bool), `blocked_message` (text format value),
`show_preview` (bool), `preview_style` (image style, default `blocked_media_teaser`), `category`
(cookie category id).

## The formatter

`cookie_content_blocker_oembed` (`OEmbedFormatter`) extends core media's `OEmbedFormatter` for field
types `link`, `string`, `string_long`. In `viewElements()` it:

1. Renders the embed via the parent (core oEmbed) formatter.
2. Reads the media entity's `provider_name` from the oEmbed source metadata.
3. Looks up `providers.<provider>` in `cookie_content_blocker_media.settings`; if `blocked` is empty,
   leaves the embed untouched.
4. Otherwise sets `#cookie_content_blocker` with `blocked_message`, `original_content` (the rendered
   embed), and `category`; when `show_preview`, adds a `preview` render array (`image_style` with
   `preview_style` and the media's `thumbnail_uri`).
5. Adds the config object as a cacheable dependency.

Enable it on a Media reference / oEmbed field's **Manage display** by choosing the
"Cookie Content Blocker - oEmbed content" formatter. Blocking/message/preview then come from the
per-provider settings above. The consent-reveal behaviour is the parent module's (see
`../../../../2.6.x/agent/api/blocking.md`).
