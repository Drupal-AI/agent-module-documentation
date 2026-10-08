<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# People listing: views, facets, blocks

All shipped as installed config under `config/optional/` (plus Site Studio view templates under
`config/pack_acquia_cms_person_search/`). These drive the People search/listing page.

## Views

| View | Base | Notes |
|------|------|-------|
| `people` | `search_api_index_content` (Search-API index) | Page display at path `people`; the primary faceted people listing. |
| `people_fallback` | `node_field_data` | Node-based fallback used when Search-API is unavailable. |

The `people` view expects the `content` Search-API index (from `acquia_cms_search` /
`acquia_cms_common`) to exist; without Search-API the `people_fallback` view is the working listing.

## Facets

Search-API facets, sourced from `facets.facet_source.search_api__views_page__people__page`:

- `people_category` — facet on the Categories field.
- `people_person_type` — facet on Person Type (the content type's `subtype` facet).
- `search_person_type` — Person Type facet for the global search results page.

## Blocks

`block.block.people_category`, `block.block.people_person_type`, `block.block.search_person_type` —
each a `facet_block:<facet>` plugin placed in the Site Studio **`dx8_hidden`** region (rendered
through Cohesion/Site Studio templates rather than a normal theme region).

## Site Studio templates

`config/pack_acquia_cms_person/` and `config/pack_acquia_cms_person_search/` ship Cohesion
(Site Studio) content and view templates (`node_person_*`, `view_tpl_people*`). They only take
effect when `acquia_cms_site_studio` is enabled; update hooks 8004/8005 maintain their enforced
dependencies and prune invalid entries (see [../hooks/install.md](../hooks/install.md)).
