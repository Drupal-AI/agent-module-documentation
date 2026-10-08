<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Listing view, facets, indexing, URLs, vocabulary, block group, and role grants

All items are shipped config. This is a config feature installed via the Drutopia distribution;
enabling the module imports the objects below. No PHP.

## Search API index — `search_api.index.event.yml`

- `id: event`, `server: database`, `read_only: false`, `index_directly: true`.
- Datasource `entity:node` limited to bundle **event**.
- Indexes: `rendered_item` (using the **`search_index`** view mode), `title` (boost 8), `created`,
  `changed`, `uid`/`name`, `status`, `sticky`, `promote`, `field_summary`, `field_tags`,
  `field_topics`, `field_event_type`, and the event date as both `field_event_date` and its
  `end_value` (`field_event_date:end_value`).
- Processors include `content_access` and `node_grants` (node access is enforced in the index) plus
  tokenizer/stopwords/ignorecase/transliteration/html_filter on the text fields.

## Listing view — `views.view.event.yml`

- `base_table: search_api_index_event` (a Search API view). Description "Displays for event
  content type." Access: **permission `access content`** (standard public listing); query
  `bypass_access: false`, `skip_access: false`.
- **Displays:**
  - `default` (Master): title "Events", row = `search_api` rendered entity in the **`teaser`** view
    mode, **mini pager 10/page**, basic exposed form (sort by), default sorts sticky DESC then
    `field_event_date` DESC.
  - `page_listing` (Page): **path `/events`**, added to the `main` menu as "Events" ("See a
    listing of our events."). This is the facet source page.
  - `block_upcoming` (Block): title **"Upcoming events"**, row in the **`micro`** view mode, pager
    `some` **5 items**, `block_hide_empty: true`, "More" link on. Filtered on `field_event_date`
    with operator **`>=` value `now`** (offset type) and sorted `field_event_date` **ASC** — i.e.
    only current/future events, soonest first.

## Facets — `facets.facet.event_type.yml`, `facets.facet.event_topics.yml`

Both attach to facet source `search_api:views_page__event__page_listing` (the `/events` page),
checkbox widget, `show_numbers: true`, soft limit 10, `query_operator: or`,
`only_visible_when_facet_source_is_visible: true`.

- **event_type** (name "Event type") → field `field_event_type`.
- **event_topics** (name "Event Topics") → field `field_topics`.

## Pathauto patterns

- `pathauto.pattern.node_event.yml` — id `node_event`, type `canonical_entities:node`, pattern
  **`events/[node:title]`**, restricted to bundle `event`.
- `pathauto.pattern.event_type.yml` — id `event_type`, type `canonical_entities:taxonomy_term`,
  pattern **`[term:vocabulary]/[term:name]`**, restricted to the `event_type` vocabulary.

## Taxonomy vocabulary — `taxonomy.vocabulary.event_type.yml`

`vid: event_type`, name "Event type", description "For categorizing events." Empty by default;
the site adds terms. This is the only vocabulary shipped by the module; `tags` and `topics` come
from Drutopia dependencies.

## Other config

- `block_visibility_groups.block_visibility_group.event_listing.yml` — id `event_listing`, label
  "Event Listing", condition `request_path` pages **`/events`** (controls where event-related
  blocks show).
- `drutopia_event.links.action.yml` — an **"Add event"** action link (`node.add` for node_type
  `event`) that appears on `view.event.page_listing`.

## Role permission grants — `config/actions/user.role.<role>.yml`

These use the Drutopia config-actions mechanism (`plugin: add`, `path: [permissions]`), which
**adds** event permission strings to the `permissions` list of pre-existing Drutopia roles rather
than defining new roles. Grants are event-scoped only — **no delete, admin, bypass, full-html
format, or other privileged permissions**:

| Role | Permissions granted (exact strings) |
|---|---|
| `contributor` | `create event content`, `edit own event content` |
| `editor` | `create event content`, `edit any event content` |
| `manager` | `create event content`, `edit any event content` |

`contributor` is the most limited (own content only); `editor` and `manager` may edit any event.
All three are standard per-bundle node permissions.
