<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views Google News — agent index

Provides a Views **style** and **row** plugin that render a view as a Google News sitemap
XML feed. No settings form (`configure: null`), no permissions, no Drush, no services — all
config lives inside the view.

- **Build the feed: style/row plugin ids, the field-mapping options, feed path, filters** →
  [configure/feed.md](configure/feed.md)
- **`hook_views_googlenews_item_alter()`** → [hooks/alter.md](hooks/alter.md)
- **The two XML templates and their variables** → [theming/templates.md](theming/templates.md)

Key facts:
- Views **style** plugin id `google_news` (title "Google News Feed", `display_types: {feed}`).
- Views **row** plugin id `google_news_fields` (title "Google News fields").
- Row options (config `views.row.google_news_fields`): `loc_field`,
  `news_publication_name_field`, `news_publication_language_field`, `news_access_field`,
  `news_genres_field`, `news_publication_date_field`, `news_title_field`,
  `news_keywords_field`, `news_stock_tickers_field`. Required: loc, publication_date, title.
- Only usable on a **Feed** display. Name & language default to the site name / default
  language when not mapped.
