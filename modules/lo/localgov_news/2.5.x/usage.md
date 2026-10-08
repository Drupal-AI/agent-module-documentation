<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
LocalGov News provides a council newsroom: a **news article** content type, one or more **newsroom** landing pages that list and feature articles, and the search/facet blocks that let visitors filter the archive by date and category.

---

Two node types do the work. `localgov_news_article` carries a publication date (`localgov_news_date`), a category taxonomy reference (`localgov_news_categories`), a media image, related-article references and a required `localgov_newsroom` reference saying which newsroom it belongs to. `localgov_newsroom` is the landing page and has a `localgov_newsroom_featured` field holding up to three hand-picked articles; the featured block fills any remaining slots with the latest promoted articles, so the page never looks half-empty. Two views ship — `localgov_news_list` (10 articles per page, excluding the featured ones) and `localgov_news_search` — and `NewsExtraFieldDisplay` exposes them plus the search and facets blocks as pseudo-fields on the newsroom display (`localgov_newsroom_all_view`, `localgov_news_search`, `localgov_news_facets`), so a site builder positions them in *Manage display* rather than block layout. The module smooths several editorial edges: `hook_field_widget_complete_form_alter()` auto-selects the newsroom when only one exists (and warns, with a create link, when none do), restricts the featured-article picker to articles in that newsroom, and adds a *promote to newsroom* checkbox on the article form; `hook_tokens_alter()` strips commas out of category tokens so pathauto does not split them; an RSS view mode is handled in `nodeView()`; and `PageHeaderSubscriber` adapts the LocalGov page header for news pages. On install it grants anonymous users `use search_api_autocomplete for localgov_news_search` and registers both bundles with Simple XML Sitemap.

---

- Publish a council newsroom with categorised press releases.
- Feature up to three stories at the top of a newsroom page.
- Automatically backfill the featured slots with the latest promoted articles.
- Let visitors filter news by category and date with facet blocks.
- Provide a search box scoped to news articles.
- Run several newsrooms (e.g. per service area) on one site.
- Give each article a publication date independent of node creation time.
- Link related articles to keep readers on the site.
- Show a hero image on articles using media.
- Publish an RSS feed of news articles.
- Include news in the XML sitemap automatically.
- Let editors promote an article to its newsroom from the article form.
- Avoid asking editors to pick a newsroom when only one exists.
- Warn editors to create a newsroom before writing the first article.
- Restrict featured-article choices to the current newsroom.
- Keep category names intact in generated URL aliases.
- Use content moderation workflows on news articles.
- Place the news search and facet blocks anywhere via Manage display.
- Give the newsroom a menu link and clean path.
- Offer autocomplete on the news search for anonymous visitors.
- Style teaser, full and featured displays with the shipped CSS.
- Archive older news while keeping it searchable.
- Support a microsites setup where each group has its own newsroom.
- Build a "latest news" listing elsewhere on the site from the shipped view.
