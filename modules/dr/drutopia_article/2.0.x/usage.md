<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Drutopia Article ships a ready-made "Article" content type plus its fields, displays, listing view, facets, URL patterns, taxonomy vocabulary, and role permission grants as installable configuration.

---

Drutopia Article is a config-only Features module (bundle `drutopia`, marked `required: true`) from the Drutopia distribution. It contains no PHP code, routes, services, hooks, or permission definitions of its own. Enabling it imports an `article` node type intended for time-sensitive content (news, press releases, blog posts) together with a full field set (body, required summary, deprecated image field, media image, tags, topics, authors, article type, paragraph body, meta tags, comments), a default form display, nine view displays (default, box, card, full, media, rss, search_index, simple_card, teaser), a Search API index (`article`, database server), a `views.view.article` listing (page at `/articles` titled "News", a promoted block, plus the master display) rendered through the `card` view mode, two Facets checkbox facets (Article Topics, Article Type), pathauto patterns for articles and article-type terms, an `article_type` taxonomy vocabulary, an "Add article" action link, a block visibility group, and an RDF mapping. Config actions grant article create/edit permissions to the Drutopia `contributor`, `editor`, and `manager` roles. It is installed here as a dev checkout tracking the 2.0.x branch and pulls in the whole Drutopia dependency chain, so it is normally deployed through the distribution rather than on its own.

---

- Add a fully structured Article/news/blog content type to a site without hand-building fields.
- Publish time-sensitive content such as press releases, news items, and blog posts.
- Give editors a required Summary field that drives teaser and listing displays.
- Attach a responsive Media-library image to articles via the `field_media_image` media reference.
- Migrate away from the legacy `field_image` file field (labelled "Image (deprecated)", use Media image instead).
- Categorize articles with free-tagging Tags terms (auto-created) for folksonomy-style labelling.
- Classify articles under cross-content-type Topics terms for site-wide grouping.
- Assign a site-defined Article Type term (from the shipped `article_type` vocabulary) to each article.
- Let visitors filter the article listing by Topic and by Article Type using checkbox facets.
- Credit one or more Authors by referencing existing Drutopia "people" nodes.
- Build rich article bodies from Paragraphs (text, image, file, video, FAQ) via `field_body_paragraph`.
- Manage per-article SEO metadata through the Metatag `field_meta_tags` field.
- Enable threaded commenting on articles through the core comment field (open by default).
- Provide a paginated `/articles` listing page (12 per page, titled "News") backed by Search API.
- Place a "Latest" promoted-articles block (four items) supplied by the view's block display.
- Present articles consistently across contexts using the shipped card, teaser, box, media, and full view modes.
- Produce an RSS-friendly display of articles with the `rss` view mode.
- Feed a dedicated `search_index` view mode into the Search API `article` index.
- Generate clean article URLs automatically (`articles/[node:title]`) via pathauto.
- Generate clean taxonomy URLs for Article Type terms (`[term:vocabulary]/[term:name]`) via pathauto.
- Grant contributors the ability to create and edit their own articles, and editors/managers to edit any article, through bundled config actions.
- Expose an "Add article" local action on the article listing page for quick content creation.
- Serve as the base article feature that other Drutopia site builds and features extend.
