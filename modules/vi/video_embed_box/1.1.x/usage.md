<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Video Embed Box provides a Box.com provider plugin for the Video Embed Field module, rendering Box shared-link videos in an iframe.
---
The module ships a single `@VideoEmbedProvider` plugin (`Box`) extending `ProviderPluginBase`. It matches Box shared-link URLs of the form `https://{custom_domain}.app.box.com(/embed)/s/{id}` with a regex, extracting the custom subdomain and the share id. `renderEmbedCode()` returns a `video_embed_iframe` render element pointing at `https://{domain}.app.box.com/embed/s/{id}` with the requested width/height and standard iframe attributes. It provides no remote thumbnail (returns an empty string).

It depends on `video_embed_field` and has no routes, permissions, services, or configuration of its own — behaviour comes entirely from being registered as a provider plugin. The embed URL is built only from the regex-captured `domain` and `id` (restricted to `[a-zA-Z0-9]`), so arbitrary hosts cannot be injected through the field value. There is no server-side fetching, TLS handling, or user input beyond the field's URL value.

Typical setup: enable alongside Video Embed Field, then paste Box share URLs into any video_embed_field-enabled field.
---
- Embed a Box.com shared video in a node field.
- Add Box as an option to an existing video_embed_field.
- Render Box videos in an iframe at a configured size.
- Support custom Box subdomains in share URLs.
- Accept both `/s/` and `/embed/s/` Box URL forms.
- Display corporate Box-hosted training videos on a site.
- Reuse video_embed_field formatters/widgets with Box sources.
- Validate Box URLs via the provider's URL pattern.
- Provide a Box alternative to YouTube/Vimeo providers.
- Show Box videos with fullscreen enabled.
- Set iframe width/height via the field formatter settings.
- Embed Box videos inside a Views listing of media.
- Use Box videos in a Layout Builder block.
- Reference Box videos from a paragraph or content type.
- Restrict a field to only accept valid Box share URLs.
- Migrate existing Box links into a video_embed_field.
- Display Box videos responsively within a theme region.
