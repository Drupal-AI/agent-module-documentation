<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views Entity Embed — agent index

Embeds a View inside CKEditor rich text. Provides an `embed_views` EmbedType, a **Views Embed**
button (`embed.button.views`), a dialog, and a `views_embed` text filter that renders
`<drupal-views>` tags. Depends on Views + Embed + Entity Embed. No settings page, no
permissions, no Drush, no config schema of its own.

- **Set it up: enable the filter, allow the tag, create/place the embed button** →
  [configure/setup.md](configure/setup.md)
- **The moving parts: `embed_views` EmbedType, `views_embed` filter, the `<drupal-views>` tag,
  routes** → [plugins/embed-and-filter.md](plugins/embed-and-filter.md)

Key facts:
- Filter id **`views_embed`** ("Display embedded views"); it processes `<drupal-views>` elements
  that have both `data-view-name` and `data-view-display`.
- Embedded element: `<drupal-views data-view-name="…" data-view-display="…"
  data-view-arguments="{json}">`; the JSON holds `override_title`, `title`, `filters`.
- Embed button entity type id **`embed_views`** (default button id `views`, config
  `embed.button.views`); its `type_settings` can restrict `views_options` / `display_options`.
- To work: on the text format enable `views_embed`, and if `filter_html` limits tags allow
  `<drupal-views data-view-name data-view-display data-view-arguments data-embed-button>`.
