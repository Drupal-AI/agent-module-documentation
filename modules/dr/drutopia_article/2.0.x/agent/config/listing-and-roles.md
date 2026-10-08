<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Listing view, facets, indexing, URLs, vocabulary, and role grants

All items are shipped config. This is a config feature installed via the Drutopia distribution;
enabling the module imports the objects below.

## Search API index — `search_api.index.article.yml`

- `id: article`, `server: database`, datasource `entity:node` limited to bundle **article**.
- Indexes a `search_index` rendered item plus fields including `field_article_type` and
  `field_topics` (the two facet sources). Uses the `search_index` view mode for the rendered item.

## Listing view — `views.view.article.yml`

- `base_table: search_api_index_article` (a Search API view). Description "Various displays for
  the article content type." Access: **permission `access content`** (standard public listing).
- **Displays:**
  - `default` (Master): title "Articles", row = `search_api` rendered entity in the **`card`**
    view mode, mini pager 12/page, basic exposed form (sort by).
  - `page_listing` (Page): **path `/articles`**, title "News", added to the `main` menu.
  - `block_promoted` (Block): title "Latest", pager `some` with **4 items**, filtered to promoted
    content — a promoted-articles block.

## Facets — `facets.facet.article_topics.yml`, `facets.facet.article_type.yml`

Both facets attach to facet source `search_api:views_page__article__page_listing` (the `/articles`
page), checkbox widget, `show_numbers: true`, soft limit 10, `query_operator: or`,
`only_visible_when_facet_source_is_visible: true`.

- **article_topics** → field `field_topics` (name "Article Topics").
- **article_type** → field `field_article_type` (name "Article Type").

## Pathauto patterns

- `pathauto.pattern.node_article.yml` — id `node_article`, type `canonical_entities:node`, pattern
  **`articles/[node:title]`**, restricted to bundle `article`.
- `pathauto.pattern.article_type.yml` — id `article_type`, type
  `canonical_entities:taxonomy_term`, pattern **`[term:vocabulary]/[term:name]`**, restricted to
  the `article_type` vocabulary.

## Taxonomy vocabulary — `taxonomy.vocabulary.article_type.yml`

`vid: article_type`, name "Article type", description "For categorizing articles." (Empty by
default; the site adds terms.) This is the only vocabulary shipped by the module; `tags` and
`topics` come from Drutopia dependencies.

## Other config

- `block_visibility_groups.block_visibility_group.article_listing.yml` — a block visibility group
  named for the article listing (controls where article-related blocks show).
- `rdf.mapping.node.article.yml` — RDF mapping for the article node type.

## Role permission grants — `config/actions/user.role.<role>.yml`

These use the Drutopia config-actions mechanism (each file `add`s a `node.type.article` config
dependency and `add`s permission strings to the role's `permissions` list). They modify existing
Drutopia roles rather than defining new ones. Grants are article-scoped only — **no delete,
admin, bypass, or other privileged permissions**:

| Role | Permissions granted |
|---|---|
| `contributor` | `create article content`, `edit own article content` |
| `editor` | `create article content`, `edit any article content` |
| `manager` | `create article content`, `edit any article content` |

The `contributor` role is the most limited (own-content only); `editor` and `manager` can edit
any article. All three are standard per-bundle node permissions.
