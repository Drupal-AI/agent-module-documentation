<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# URL Embed — agent index

Turns a plain URL pasted into a rich text field (or a Link field) into a rendered oEmbed /
Open Graph embed. Built on the `embed` module's `<drupal-url>` tag convention and the
`oscarotero/embed` (`embed/embed`) PHP library. Two filter plugins do the work in text
formats; a CKEditor 5 plugin gives editors a paste dialog; a field formatter does the same
for Link fields.

- **Enable it on a text format, the `<drupal-url>` tag, filter settings, the CKEditor 5
  toolbar button, and the settings form (Facebook/Instagram credentials)** →
  [configure/text-format-and-toolbar.md](configure/text-format-and-toolbar.md)
- **Fetch embed data programmatically — the `url_embed` service, `UrlEmbedHelperTrait`, and
  the `url_embed` Link field formatter** → [api/service.md](api/service.md)
- **Alter the URL/adapter options before a fetch (`hook_url_embed_options_alter`)** →
  [hooks/options-alter.md](hooks/options-alter.md)
- **The `administer url_embed` permission and what it gates** →
  [permissions/administer-url-embed.md](permissions/administer-url-embed.md)

Key facts: filter plugin ids are `url_embed` (renders `<drupal-url>` tags) and
`url_embed_convert_links` (auto-converts bare URLs into `<drupal-url>` tags). Settings config
is `url_embed.settings` (`facebook_app_id`, `facebook_app_secret`) — no other keys exist. The
admin form route is `url_embed.admin` at `/admin/config/media/url_embed`. The module defines
no plugin type of its own (`provides_plugin_types: []`); it only *implements* Filter,
EmbedType, FieldFormatter, and CKEditor5Plugin plugins.
