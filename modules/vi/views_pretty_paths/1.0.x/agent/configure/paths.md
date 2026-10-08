<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring pretty paths

Config form: **Admin → Configuration → System → Views Pretty Path** (`/admin/config/views-pretty-path`), permission *access administration pages*. Stored in `views_pretty_paths.config`.

## Per-path rows (`paths`)
Each row sets:
- **Path to Rewrite** — begin with `/` (e.g. `/blog`). Validated to exist as a path alias, or to match the selected view display's own `path`.
- **View** — the view whose exposed filters are used.
- **Display** — the display whose `display_options.filters` (merged with `default`) supply the exposed filters.

Add/remove rows with the AJAX buttons. Deleting a view auto-removes its rows (`hook_ENTITY_predelete`).

## Filter identifier → name map (`views_filter_name_map`)
One rule per line, `filter_identifier|name`, e.g.:
```
field_topic_target_id|topics
field_start_date_value|date
```
This makes `/blog/filter/field_topic_target_id/…` read as `/blog/filter/topics/…`.

## Filter subpath (`filter_subpath`)
The segment that introduces filter pairs; default `/filter` (so `/blog/filter/topics/technology`).

## Runtime behaviour
- **Inbound** (`processInbound`): if the request URI matches a configured path + subpath and the alias resolves to a system path, segments are translated (via filter handlers) into query params and merged with `request->query->replace()`; routing then targets the real view path.
- **Outbound** (`processOutbound`): matching view URLs are rewritten to the pretty form.
- **Exposed form submit** (`handleViewsExposedFormSubmit`): redirects (`TrustedRedirectResponse`) to the pretty URL built from submitted filter values.
- Pager links are rewritten in `preProcessPager()`.

## Supported filters out of the box
`search_keywords` / `search_api_fulltext` / `combine` (Text), `bundle` (Bundle), date (Date), `taxonomy_index_tid` (Taxonomy).
