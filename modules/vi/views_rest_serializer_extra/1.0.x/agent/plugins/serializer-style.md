<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The serializer style plugin

Class `Drupal\views_rest_serializer_extra\Plugin\views\style\ResultsSerializer`
(`src/Plugin/views/style/ResultsSerializer.php`). It is a `@ViewsStyle` plugin —
**not** a new plugin type, just an implementation of core's `views_style` type:

```
id = "views_rest_serializer_extra"
title = "Serializer with pagination, facets, and extra metadata"
display_types = {"data"}
extends Drupal\rest\Plugin\views\style\Serializer
```

Because `display_types = {"data"}`, it is only offered on **REST Export** displays.

## Selecting it

In the view's REST Export display: **Format → Settings → choose "Serializer with pagination,
facets, and extra metadata"**. There is no admin config route on the module itself
(`configure` is null); all settings live in this style's per-display options form. It works
with whatever serializer formats (json/xml) the display's Accepted request formats allow.

## Style options (`defineOptions` / `buildOptionsForm`)

All are stored in the display's style `options` (no separate config entity). Inherits the core
Serializer's format options, and adds:

| Option key | Type | Default | Effect |
|---|---|---|---|
| `results_key` | textfield | `results` | Label of the key the serialized rows are placed under. |
| `current_page_key` | textfield | `current_page` | Label inside `pager` for the current page. |
| `total_results_key` | textfield | `total_results` | Label inside `pager` for the total item count. |
| `total_pages_key` | textfield | `total_pages` | Label inside `pager` for the total page count. |
| `items_per_page_key` | textfield | `items_per_page` | Label inside `pager` for the page size. |
| `typeahead_route` | textfield | `''` | If set, surfaced as `system.typeahead` (a Search API Autocomplete or custom path). |
| `show_facets` | checkbox | `FALSE` | Include Facets in the output. **The checkbox only appears if the `facets_rest` module is enabled.** |

Renaming keys is the mechanism for matching an existing front-end contract (e.g. set
`results_key` to `data`). Note: the module ships **no `config/schema/`**, so these options
have no schema definition — expect a config-schema notice under strict schema checking.

## Response envelope (`render()`)

`render()` calls `parent::render()` (the standard serializer output), `json_decode`s it, and
assembles a top-level array that is then `ksort()`ed and serialized in the display's content
type. Structure (key labels reflect the options above):

- **`results`** — the decoded serialized rows (the normal core Serializer output).
- **`pager`** — present when the view has a pager:
  - `current_page`, `total_results`, `total_pages`, `items_per_page` — ints read from the
    view's pager when it is a `SqlBase` pager; otherwise `current_page`/`total_pages` = 0 and
    counts fall back to `count($view->result)`.
  - `items_per_page_options` — array of ints, only when the items-per-page exposed control is
    in use (parsed from the pager's `expose.items_per_page_options`).
- **`filters`** — array of exposed filter keys that are actually present in `exposed_data`.
- **`sorters`** — array of `{label, identifier, selected}` for each exposed sort; plus a
  sibling **`sort_order`** (`ASC`/`DESC`) when an exposed sort order is active.
- **`system`** — `{page_key: "page"}`, plus `typeahead` when `typeahead_route` is set.
- **`facets`** and **`facets_metadata`** — only when `facets_rest` is enabled and
  `show_facets` is on (see below).

## Facets integration (optional)

Guarded by `moduleHandler->moduleExists('facets_rest') && options['show_facets']`. It derives
the facet source id `search_api:views_rest__{view_id}__{display_id}`, loads facets via
`facets.manager`, updates and builds each, and emits:

- `facets` — array of built facet render structures (empty `[[field_id => []]]` when a facet
  has no results).
- `facets_metadata` — map keyed by facet id: `{label, weight, field_id, url_alias,
  has_results}`, sorted by weight.

This targets Search API–backed views exposed over REST; it has been used with Search API Solr.

## Extending / subclassing

Standard Views style subclassing: create your own `@ViewsStyle` plugin extending
`ResultsSerializer`, override `defineOptions()` / `buildOptionsForm()` to add keys, and
override `render()` (call `parent::render()` and augment) to add envelope sections. The class
grabs `module_handler` via `create()`; add more services the same way. No hooks or public API
are exposed by the module beyond this plugin.
