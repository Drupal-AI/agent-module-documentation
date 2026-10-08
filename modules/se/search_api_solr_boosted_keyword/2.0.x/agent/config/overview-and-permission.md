<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Overview form, CSV export, permission and routing

There is **no settings form and no config entity** for this module — keyword/boost data lives in
the field values on each entity. The only admin surface is a read/export overview.

## Route and menu
`search_api_solr_boosted_keyword.routing.yml`:
- Route `search_api_solr_boosted_keyword.keywords_overview`, path
  **`/admin/config/search/keywords`**, form
  `\Drupal\search_api_solr_boosted_keyword\Form\BoostedKeywordsOverviewForm`, `_admin_route: TRUE`.
- Requirement: `_permission: 'administer boosted keywords overview'`.

`search_api_solr_boosted_keyword.links.menu.yml` adds a "Boosted keywords overview" link under
`system.admin_config_search` (weight 99).

Note: `search_api_solr_boosted_keyword.info.yml` declares **no `configure:` key**, so the module
has no "Configure" link on the Extend page — reach the overview via the Configuration › Search menu.

## Permission
`search_api_solr_boosted_keyword.permissions.yml`:
- `administer boosted keywords overview` — "Allows to view and extract an overview of all boosted
  keywords." This is the only permission. It gates both viewing and CSV export.

## Overview form — `BoostedKeywordsOverviewForm`
`src/Form/BoostedKeywordsOverviewForm.php` (extends `FormBase`). Injects the keywords manager,
`language_manager` and `entity_type.manager`.

- **Filters** (inline fieldset): Content type (only bundles that actually use a boosted-keyword
  field), Language, Status (Published / Unpublished / Any, default Published). Filtering redirects
  with the filters as query-string parameters; "Reset" redirects with none.
- Warns "Currently there is no boosted keywords field added in your content types." when no bundle
  uses the field.
- **Table** columns: Keyword, Page, Boost, Last update. Each keyword row groups every node that
  uses it into ordered sub-lists of page links, boost values and last-update dates. Paged at 100.
- **Export to CSV** button (disabled when there are no results): writes a `temporary://` CSV
  (`;`-delimited, header `Keyword;Page;Boost;Last update`) via `fputcsv`, one row per page, saves a
  status=0 file entity owned by the current user, and shows a status message with a download link.
  Passing limit `0` to the manager skips the pager so the export covers all matches.

## Data source — `BoostedKeywordsManager`
`src/BoostedKeywordsManager.php`, service `search_api_solr_boosted_keyword.keywords_manager`
(args `@database`, `@entity_field.manager`).

- `whereUsed($return_type, $entity_type = 'node')` — via
  `EntityFieldManager::getFieldMapByFieldType('search_api_solr_boosted_keyword')`, returns the
  `bundle`s or `field_name`s where the field is used. **Node-only** by default (the entire overview
  is node-scoped).
- `fetchAllKeywords($filters, $limit)` — for each boosted-keyword field builds a `SELECT` on
  `node__<field>` joined to `node_field_data`, selecting `<field>_value` as `keyword` and a
  `GROUP_CONCAT(CONCAT_WS(',', nid, changed, langcode, <field>_boost) …)` of the pages, grouped by
  keyword; combines the per-field selects with `UNION ALL`; orders by keyword; applies the pager
  when `$limit > 0`. Filters (`type`/`language`/`status`) are applied with parameterised
  `->condition()`.

### Caveats for agents
- The overview and manager are **hard-coded to nodes** (`node__*`, `node_field_data`,
  `entity.node.canonical`). Boosted-keyword fields on other entity types are indexed and boosted
  normally by the event subscriber but will **not** appear in this overview or export.
- The `GROUP_CONCAT` expression is MySQL/MariaDB-specific; the overview may not run on other
  databases.
- Field/column names in the raw SQL come from real field machine names discovered via the entity
  field map (not from request input), and filter values are parameterised.
