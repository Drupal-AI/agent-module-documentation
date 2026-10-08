<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CKEditor Media Embed — agent index

Adds CKEditor 5's **Media Embed** to Drupal. An author inserts a media URL; CKEditor stores
an `<oembed url="…">` tag; a text-format filter converts it to embed HTML on render, resolving
each URL through a configurable oEmbed provider (Iframely by default). The CKEditor JS is
**downloaded**, not bundled. Depends on core `ckeditor5`.

Three moving parts must all be in place: (1) the CKEditor plugin JS in `libraries/ckeditor5/plugins/`,
(2) the **Insert media** toolbar button on the editor, (3) the **filter** enabled on the format.

- **Set the oEmbed provider / where config lives / Drush install & update** →
  [configure/settings.md](configure/settings.md)
- **The CKEditor 5 plugin, toolbar button, and the `filter_ckeditor_media_embed` filter (how it renders)** →
  [plugins/media-embed.md](plugins/media-embed.md)
- **`drush ckeditor_media_embed:install` / `:update` (download the plugin JS)** →
  [drush/commands.md](drush/commands.md)
- **Programmatic embed service + the link field formatter + object-alter hook** →
  [api/embed-service.md](api/embed-service.md)

Key facts: config object `ckeditor_media_embed.settings` (`embed_provider`, `ckeditor_version`,
`plugins_version_installed`); configure route `ckeditor_media_embed.ckeditor_media_embed_settings_form`
at `/admin/config/media/ckeditor-media-embed/settings` (permission `administer filters`); filter id
`filter_ckeditor_media_embed`; formatter id `ckeditor_media_embed_link_formatter`; service id
`ckeditor_media_embed`. No permissions of its own; no plugin *types* defined.
