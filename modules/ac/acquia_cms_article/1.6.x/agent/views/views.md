# Views, blocks and search config (optional)

All of these ship as **optional config** — they install only when their dependencies (Views, Search
API, Facets, Site Studio) are enabled. On a plain site without those modules they are simply skipped.

## Views (`config/optional/views.view.*`)

| View ID | Label | Base table | Purpose |
|---------|-------|-----------|---------|
| `articles` | Articles | `search_api_index_content` | Search-API-backed listing page (`page__articles`), the source for the facets below. |
| `article_cards` | Article Cards | `node_field_data` | Card grid; provides the `recent_articles_block` display used by the Recent Articles block. |
| `articles_fallback` | Articles (Fallback) | `node_field_data` | Node-table fallback listing for when the Search API index is unavailable. |

## Facets (`config/optional/facets.facet.*`)

Facet source: `search_api__views_page__articles__page` (the `articles` view page display).

| Facet ID | Label | Field |
|----------|-------|-------|
| `articles_article_type` | Article Type | `field_article_type` |
| `articles_category` | Category | `field_categories` |
| `search_article_type` | Article Type | (global search facet) |

`articles_article_type` is also referenced by the node type's `third_party_settings.acquia_cms_common.subtype.facet`.

## Blocks (`config/optional/block.block.*`)

All are placed in the `dx8_hidden` region (Site Studio manages their real placement).

| Block ID | Plugin |
|----------|--------|
| `articles_article_type` | `facet_block:articles_article_type` |
| `articles_category` | `facet_block:articles_category` |
| `search_article_type` | `facet_block:search_article_type` |
| `views_block__article_cards_recent_articles_block` | `views_block:article_cards-recent_articles_block` |

## Site Studio packages

`config/pack_acquia_cms_article/` and `config/pack_acquia_cms_article_search/` hold Acquia Site Studio
(Cohesion) templates and a component (`cpt_articles_slider`) plus content/view templates for the
Article displays. They install only when `acquia_cms_site_studio` is present; update hooks `_8007`/`_8008`
(see [../hooks/integration.md](../hooks/integration.md)) maintain their enforced dependencies and prune
invalid entries.
