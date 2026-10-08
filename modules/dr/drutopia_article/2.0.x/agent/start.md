<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drutopia Article (drutopia_article) — agent index

A **config-only Features module** from the **Drutopia distribution** that installs an `article`
content type and all its supporting configuration. Package `Drutopia`. Features file marks it
`bundle: drutopia`, `required: true`. Core `^10.2 || ^11 || ^12`. License GPL-2.0-or-later.

**Dev checkout:** `drutopia_article.info.yml` has **no `version:` line**, so this is a dev-branch
checkout; the version dir `2.0.x` tracks the 2.0.x dev branch. It normally installs via the
Drutopia distribution, and enabling it standalone requires its full dependency chain
(drutopia_core/comment/people/seo/site, ds, facets, field_group, paragraphs, pathauto, metatag,
search_api, media, entity_reference_revisions, focal_point, block_visibility_groups, and more —
see the info.yml / `data.json`). On this site it did not enable because those deps are absent;
that is expected and does not affect the docs, which are source-grounded.

## What it actually is

- **No `src/`, no routes, no services, no hooks, no `*.permissions.yml`, no `config/schema/`.**
  Everything is shipped YAML config under `config/install/` and `config/actions/`.
- Provides an **Article node type** (`node.type.article`) with 11 fields, one form display, and
  **nine view displays**.
- Provides a **Search API index** (`article`, database server) and a **`views.view.article`**
  listing (page `/articles` "News", promoted block "Latest", master display).
- Provides **two Facets** (Article Topics, Article Type), **two pathauto patterns**, the
  **`article_type` taxonomy vocabulary**, an **"Add article"** action link, a
  **block visibility group**, and an **RDF mapping**.
- Ships **three config actions** that grant article permissions to Drutopia roles
  (contributor / editor / manager).

## Solution docs

- **The Article content type — fields, form display, and the nine view displays** →
  [config/article-content-type.md](config/article-content-type.md)
- **The listing view, facets, Search API index, pathauto, taxonomy vocabulary, and the role
  permission grants** →
  [config/listing-and-roles.md](config/listing-and-roles.md)

## Dependencies (info.yml)

Core: block, comment, field, image, media, media_library, node, path, responsive_image, system,
taxonomy, text, user, views, rdf. Drutopia: drutopia_core, drutopia_comment, drutopia_people,
drutopia_seo, drutopia_site. Contrib: block_visibility_groups, ds, entity_reference_revisions,
facets, field_group, focal_point, media_library_media_modify, media_responsive_thumbnail,
metatag, paragraphs, pathauto, search_api. Composer also requires `drupal/token`.
