<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
A config-only Drutopia base feature that installs a Blog content type and its supporting fields, displays, listing view, SEO and search configuration for personal or journal-like posts.

---

Drutopia Blog is one of the base "feature" modules of the Drutopia distribution. It ships no PHP — only configuration in `config/install/` and `config/actions/`. Enabling it creates the `blog` node type (with a required Summary, a paragraphs-based body, a media image, author references to People, tags and topics taxonomy terms, comments and Metatag fields), seven view displays (default, teaser, card, simple_card, media, full, search_index), a Search API index (`blog`), a Views listing (`view.blog`) served at `/blog` with a "Blog Topics" facet and an "Add blog" action link, a Pathauto pattern `blog/[node:title]`, and a block-visibility group scoped to `/blog`. Access is governed entirely by core node grant permissions; the module's `config/actions/` files additively grant blog create/edit permissions to the Drutopia `contributor`, `editor` and `manager` roles. It depends on a large chain of other Drutopia and contrib modules (drutopia_core, drutopia_seo, drutopia_people, drutopia_comment, ds, facets, field_group, paragraphs, pathauto, search_api and more), so it is normally installed as part of a Drutopia site rather than standalone.

---
- Add a distinct blog/journal content type to a Drutopia site
- Write journal-style posts with a required Summary shown on teasers
- Compose post bodies from Paragraphs (text/image/file) via `field_body_paragraph`
- Attach a responsive media image to a post (`field_media_image`, Media library)
- Reference one or more author People entities on a post (`field_authors`)
- Classify posts with free-tagging Tags (`field_tags`, auto-create)
- Categorize posts with shared Topics taxonomy terms (`field_topics`)
- Browse the blog listing view at `/blog` (12 per page, mini pager)
- Filter the listing by topic with the "Blog Topics" checkbox facet
- Show a "Add blog" action link on the listing for editors
- Enable threaded comments on posts (via drutopia_comment)
- Index posts in Search API (`search_api.index.blog`) for site search
- Auto-generate URL aliases as `blog/[node:title]` via Pathauto
- Emit per-post Metatag/SEO metadata (`field_meta_tags`)
- Place blog-listing-only blocks using the `blog_listing` visibility group
- Present posts in card / simple_card / media / teaser / full view modes
- Add blog posts to the main menu via menu_ui
- Grant blog authoring permissions to Drutopia contributor/editor/manager roles
- Use posts as related-content sources on a Drutopia site
- Extend the installed content type like any standard Drupal node bundle
