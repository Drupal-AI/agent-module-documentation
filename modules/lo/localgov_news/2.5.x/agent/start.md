<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# LocalGov News (localgov_news) — agent index

Newsroom + news article content types, listing/search views, and facet blocks for LocalGov Drupal.
No `configure` route, no permissions of its own, no config schema, no Drush.

- **The two bundles, their fields, the views and blocks, and how to place them** →
  [configure/setup.md](configure/setup.md)
- **Extra-field display, form alters and the editorial behaviours** →
  [api/behaviours.md](api/behaviours.md)

Key facts:
- Bundles: **`localgov_news_article`** (fields `localgov_news_date`,
  `localgov_news_categories`, `field_media_image`, `localgov_news_related`, `localgov_newsroom`,
  `body`) and **`localgov_newsroom`** (field `localgov_newsroom_featured`, up to 3 articles).
- Views: `localgov_news_list` (the article listing, 10/page, excludes featured) and
  `localgov_news_search`.
- Pseudo-fields registered by `NewsExtraFieldDisplay::entityExtraFieldInfo()` — position these in
  *Manage display* for the **newsroom** bundle:
  - `localgov_newsroom_all_view` → embeds the `all_news` display of `localgov_news_list`
  - `localgov_news_search` → the news search block
  - `localgov_news_facets` → the facets block
  Plus a **form** pseudo-field on articles: `localgov_news_newsroom_promote`.
- Theme hooks: `node__localgov_news_article__teaser`, `node__localgov_news_article__full`,
  `field__localgov_newsroom_featured`, each with its own template and CSS library.
- `hook_field_widget_complete_form_alter()`:
  - `localgov_newsroom` field — when exactly one newsroom exists it is preselected and the widget
    becomes `#type: value` (hidden); when none exist a warning with a create link is shown
    (microsites-aware via `localgov_microsites_group`).
  - `localgov_newsroom_featured` — the reference query is restricted to articles in that newsroom.
    Note the source comment: this restricts the **search query only, not the field itself**, so a
    programmatically set value outside the newsroom is not rejected.
- `hook_tokens_alter()` strips commas from `[node:localgov_news_categories:0:entity]` so pathauto
  does not split category names into extra path segments.
- `hook_install($is_syncing)` (skipped while syncing): grants **anonymous**
  `use search_api_autocomplete for localgov_news_search`, and registers both bundles with
  `simple_sitemap` (`index: TRUE`, `priority: 0.5`) — the `config/optional` route does not work
  for sitemap settings (drupal.org issue 3156080).
- Service `localgov_news.page_header` (`PageHeaderSubscriber`) adjusts the LocalGov page header on
  news pages.
- RSS: `nodeView()` special-cases `view_mode === 'rss'` for articles.
