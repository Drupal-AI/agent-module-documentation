<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Extending the summary (alter hooks)

The area handler invokes a family of alter hooks (declared in `views_filters_summary.api.php`) so
other modules can teach it about custom filter plugins or tweak output. This is how the 11
submodules integrate. Implement them in your own module's `.module` (or a `#[Hook]` class).

| Hook | Signature / purpose |
|---|---|
| `hook_views_filters_summary_plugin_alias($filter)` | Return a string alias so a custom filter plugin id is processed like a known one (e.g. `administrative_area` → `list_field`, `commerce_entity_bundle` → `bundle`, `search_api_term` → `taxonomy_index_tid`). |
| `hook_views_filters_summary_valid_index($index, $filter)` | Return TRUE to accept an array index value the default validator would reject (e.g. string keys for `administrative_area` / `search_api_options`). |
| `hook_views_filters_summary_info_alter(array &$info, FilterPluginBase $filter)` | Replace the whole `{id,label,value}` definition for a filter — e.g. load referenced entities and set `$info['value']` to `[{id,raw,value}]` (used by eref/verf/vsf). |
| `hook_views_filters_summary_filter_value_alter(mixed &$value, FilterPluginBase $filter)` | Fix/replace a filter's raw value before processing (the module itself uses it for `user_permissions`). |
| `hook_views_filters_summary_filter_value_label_alter(string &$label, string &$value, FilterPluginBase $filter)` | Change the label shown for one value (e.g. BEF single-checkbox boolean label; VCER entity_reference → entity label). |
| `hook_views_filters_summary_item_alter(&$item)` | Alter a built summary item's render array — e.g. the a11y submodule rewrites the remove link markup with `aria-hidden`/`visually-hidden` spans. |
| `hook_views_filters_summary_replacements_alter(&$replacements, ViewExecutable $view)` | Add/adjust `@token` replacements available in the `content` string (e.g. search_api adds `@search_api_fulltext`). |
| `hook_views_filters_summary_exposed_form_id_alter(string &$exposed_form_id, ViewExecutable $view, DisplayPluginBase $display_handler)` | Change the DOM form id the remove/reset JS targets (e.g. Entity Browser embeds → `entity-browser-`). |

## Processing pipeline (where hooks fire)

`ViewsFiltersSummary::render()` → `buildReplacements()` → `defineReplacements()`
(`_replacements_alter`) → `buildFilterSummaryMarkup()` → `buildFilterSummary()` →
`getFilterDefinitions()` → `buildFilterDefinition()` (`_filter_value_alter`, `_plugin_alias`,
`_info_alter`) → `buildFilterSummaryItem()` (`_item_alter`). Value labels go through
`getFilterValueLabel()` (`_filter_value_label_alter`); index validation through `isValidIndex()`
(`_valid_index`); the DOM form id through `getExposedFormId()` (`_exposed_form_id_alter`).

The module provides a Views **area plugin**, not a plugin *type*: to add behaviour you implement
these hooks, you do not create new plugins.
