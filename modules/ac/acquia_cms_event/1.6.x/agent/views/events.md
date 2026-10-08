<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Events listing: views, facets, blocks

Shipped as installed config to give Events browseable/searchable listings. The primary `events` view is
Search-API-backed and therefore only works once the family's search stack (`acquia_cms_search` /
Search API index `content`) is present; the node-based views cover sites without it and the
upcoming/past card blocks.

## Views

| View id | Label | Base table | Displays |
|---------|-------|-----------|----------|
| `events` | Events | `search_api_index_content` | `page` at path `/events` (the intended listing). |
| `event_cards` | Event Cards | `node_field_data` | `upcoming_events_block` + `past_events_block` (block displays). |
| `events_fallback` | Events (Fallback) | `node_field_data` | `default` only — plain node query for sites without the search index. |

## Facets (module `facets`)

- `events_category` — filters the listing by `field_categories`.
- `events_event_type` — filters by `field_event_type` (the content type's `subtype` facet).
- `search_event_type` — Event-type facet for the shared search results page
  (`facet_source: search_api__views_page__events__page`).

## Blocks

Placed in the Site Studio hidden region (`cohesion_theme` / `dx8_hidden`), rendered by Site Studio
templates rather than core block placement:

- `block.block.events_category` → `facet_block:events_category`
- `block.block.events_event_type` → `facet_block:events_event_type`
- `block.block.search_event_type` → `facet_block:search_event_type`
- `block.block.views_block__event_cards_upcoming_events_block` → `views_block:event_cards-upcoming_events_block`
- `block.block.views_block__event_cards_past_events_block` → `views_block:event_cards-past_events_block`

## Site Studio templates

`config/pack_acquia_cms_event/` and `config/pack_acquia_cms_event_search/` hold Site Studio (Cohesion)
content/view templates for the Event displays and the Events views, including an "Events slider"
component (`cohesion_component.cpt_events_slider`). They are only meaningful when
`acquia_cms_site_studio` is enabled (see the update hooks in [../hooks/install.md](../hooks/install.md));
on a non-Site-Studio site they are inert.
