<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Content Feed: plugin, bundle, queries, AJAX

## Plugin & bundle

- WidgetType plugin **`content_feed`** — `@WidgetType(id="content_feed",
  label="Content Feed")`, `src/Plugin/WidgetType/ContentFeed.php`, extends
  `WidgetTypeBase`. Its `modifyRenderArray()` runs the node query and builds the list;
  it also serves AJAX responses (pagination/filtering).
- Installed widget bundle **`contentfeed`** (`stacks.widget_entity_type.contentfeed`,
  `plugin: content_feed`). Grouped under the `contentfeed` widget type group (README shows
  adding `widget_type_groups: {contentfeed: 'Content Feed'}` to `stacks.settings`).

## `contentfeed` bundle fields (editor options → `grid_options`)

| field | role |
|-------|------|
| `field_cfeed_content_types` | content types to query |
| `field_cfeed_vocabulary` | pull all terms of a vocabulary as a filter |
| `field_cfeed_taxonomy_terms` | specific terms to filter by |
| `field_cfeed_order` | sort (e.g. `created_desc`; `<field>_(asc|desc)`) |
| `field_cfeed_limit_by` | total result cap |
| `field_cfeed_results_per_page` | page size |
| `field_cfeed_pagination` | pager style (default / mini / load-more) |
| `field_cfeed_enable_filtering` | expose front-end filters |
| `field_cfeed_sticky` | sticky handling |
| `field_cfeed_description`, `field_title` | label/description |

## Query backends (`src/StacksQuery/`)

- `StacksQueryBase` — abstract; `getNodeResults($options)`; `getNodeResultsSort()` parses
  `<field>_(asc|desc)`.
- `StacksDatabaseQuery` — default entity/SQL query.
- `StacksSolrQuery` — Search API / Solr backend. Selected via `stacks.settings` keys
  `content_feed_search_api_index` (default `widgets`) and
  `content_feed_search_api_fulltext_field` (default `rendered_item`).

The plugin picks the backend based on those settings/availability. Alter results with
`hook_widget_node_results_alter(&$query, $group, &$context)` (`$context` carries
`widget_bundle` + `options`).

## AJAX

- Route `stacks_content_feed.content_feed_ajax` → `/ajax/grid`
  (`GridController::gridAjax`, permission `access content`). Reads POST
  `widgetid`, `typeofgrid`, `theme`, `isentity` (+ filters), re-runs the feed, returns an
  AJAX response that replaces results / appends pages. JS: `js/grid.ajax.js`; library
  `stacks_content_feed/grid.ajax`. Errors via `ContentFeed::postAjaxErrorMessage()`.

## Templates (author in theme)

- `stacks/contentfeed/templates/contentfeed--<variation>.html.twig` — top-level wrapper,
  filters, pager placement.
- `stacks/contentfeed/ajax/ajax_contentfeed--<variation>.html.twig` — per-page results +
  pagination markup (choose the node view mode here).
- `templates/pager/pager*.html.twig` — pager variants (default, mini, load-more); copy to
  the theme's `templates/` dir.

Also ships optional `views.view.stacks_content_feed_preview` (admin preview) and a
`field_ui`-managed `contentfeed` view display.
