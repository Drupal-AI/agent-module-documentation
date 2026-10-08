<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Media Embed Extra — agent index

Adds **Width/Height override** fields to the core media embed dialog and honours them at
render time by overriding the embedded image's dimensions. No settings form, no
`configure` route, no permissions, no Drush, no config schema, no plugin types. It relies
entirely on the text format having the core **Embed media** (`media_embed`) filter enabled
and (if HTML is limited) the `<drupal-media>` tag plus `data-width`/`data-height` attributes
allowed.

- **Enable dimension overrides on a text format (which filters / allowed HTML)** →
  [configure/text-format.md](configure/text-format.md)
- **How the override actually works (hooks, the media_embed class swap, proportional scaling)** →
  [api/mechanism.md](api/mechanism.md)

Key facts:
- Editor dialog fields are added by `hook_form_editor_media_dialog_alter()`, **only for image
  media** (it checks for an `alt` field), and stored as `data-width` / `data-height` on `<drupal-media>`.
- `hook_filter_info_alter()` replaces the `media_embed` filter class with
  `Drupal\media_embed_extra\Plugin\Filter\MediaEmbed`, which reads those attributes in
  `applyPerEmbedMediaOverrides()`. Supplying only one dimension scales the other proportionally.
