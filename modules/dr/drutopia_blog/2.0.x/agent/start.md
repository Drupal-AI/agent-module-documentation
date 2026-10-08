<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drutopia Blog (drutopia_blog) — agent index

Config-only **Drutopia** base feature. Installs a **`blog`** node type plus its fields, displays,
listing view, Search API index, topics facet, Pathauto pattern and SEO config, and additively
grants blog permissions to Drutopia roles. **No `src/`, no routes, services, hooks or
`permissions.yml`, no config schema, no Drush.**

- **Version:** 2.0.x — **dev checkout** (`.git` branch `2.0.x`; `info.yml` has no `version:` line,
  so no packaged release string).
- **Core:** `^10.2 || ^11 || ^12`. Package **Drutopia**. License GPL-2.0-or-later.
- **Distribution context:** part of the Drutopia distribution; heavy dependency chain
  (drutopia_core/seo/people/comment/site, ds, facets, field_group, paragraphs, pathauto,
  search_api, media stack, entity_reference_revisions, block_visibility_groups, metatag).
- **Did not enable on this site** — the full Drutopia dependency chain is absent. **Expected**;
  this documentation is derived from the on-disk source, not from a running instance.

## Solution docs

- **The `blog` content type, all fields, view displays, the view + facet, Pathauto, and the
  three role grants** → [config/blog-feature.md](config/blog-feature.md)

## What it ships (from `config/install/` + `config/actions/`)

- **Node type:** `node.type.blog` — "Blog", `preview_mode: 1`, `display_submitted: true`,
  main-menu enabled via `menu_ui` third-party settings. No new revision by default.
- **Fields on `node.blog`:** `body` (text_with_summary), `field_summary` (**required** text_long),
  `field_body_paragraph` (paragraphs: text/image/file), `field_media_image` (Media, image bundle),
  `field_image` (**DEPRECATED** image field), `field_authors` (ref → `people` nodes),
  `field_tags` (ref → `tags` vocab, auto-create), `field_topics` (ref → `topics` vocab),
  `field_meta_tags` (metatag), `comment` (comment). The `tags`/`topics`/`people` targets are
  provided by other Drutopia modules, not by this one.
- **Displays:** form `default`; view displays `default`, `teaser`, `card`, `simple_card`,
  `media`, `full`, `search_index` (all use `ds` + `field_group`).
- **View:** `views.view.blog` (id `blog`, base table `search_api_index_blog`) with displays
  `default`, `block_promoted`, `page_listing` (path **`/blog`**, mini pager 12/page, `card` rows).
- **Search/facet:** `search_api.index.blog` (server `database`); `facets.facet.blog_topics`
  (checkbox, field `field_topics`, source `search_api:views_page__blog__page_listing`).
- **Other:** `pathauto.pattern.node_blog` = `blog/[node:title]`;
  `block_visibility_groups...blog_listing` scoped to path `/blog`;
  action link `drutopia_blog.add_blog` → `node.add/blog`, shown on `view.blog.page_listing`.
- **Role grants (`config/actions`, additive via config_actions):** `contributor`, `editor`,
  `manager` each get blog permissions — see the solution doc for the exact per-role list.

Enable with the Drutopia dependencies present (`drush en drutopia_blog -y`); it is a feature
module, so operation is via standard node/Views/config UIs, not a settings form of its own.
