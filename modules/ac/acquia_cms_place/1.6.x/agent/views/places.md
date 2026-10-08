<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Places listing: views, facets, blocks

Shipped as installed config to give Places a browseable/searchable listing. The primary view is
Search-API-backed and therefore only works once the family's search stack (`acquia_cms_search` /
Search API index `content`) is present; a node-based fallback covers sites without it.

## Views

| View id | Label | Base table | Notes |
|---------|-------|-----------|-------|
| `places` | Places | `search_api_index_content` | Page display at path `places`; the intended listing. |
| `places_fallback` | Places (Fallback) | `node_field_data` | Plain node query for sites without the search index. |

## Facets (module `facets`)

- `places_category` — filters the listing by `field_categories`.
- `places_place_type` — filters by `field_place_type` (the content type's `subtype` facet).
- `search_place_type` — Place-type facet for the shared search results page
  (`facet_source: search_api__views_page__places__page`).

## Blocks

Facet blocks placed in the Site Studio hidden region (`dx8_hidden`), rendered by Site Studio
templates rather than core block placement:

- `block.block.places_category` → `facet_block:places_category`
- `block.block.places_place_type` → `facet_block:places_place_type`
- `block.block.search_place_type` → `facet_block:search_place_type`

## Site Studio templates

`config/pack_acquia_cms_place/` and `config/pack_acquia_cms_place_search/` hold Site Studio
(Cohesion) content and view templates for the Place displays and the Places views. They are only
meaningful when `acquia_cms_site_studio` is enabled (see the update hooks in
[../hooks/install.md](../hooks/install.md)); on a non-Site-Studio site they are inert.
