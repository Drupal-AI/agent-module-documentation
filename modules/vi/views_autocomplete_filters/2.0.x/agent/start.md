# views_autocomplete_filters — agent start

Adds an autocomplete (typeahead) dropdown to Views **exposed text-field filters**. Suggestions
come from re-executing the view with the typed string, so they reflect the view's own results.
Extends four core/contrib filter handlers — `string`, `combine`, `search_api_text`,
`search_api_fulltext` — via `hook_views_plugins_filter_alter()`. Requires core **Views** only
(Search API filters supported when that module is present). No admin settings page, no
permissions — configuration lives per-filter inside the Views UI.

- Enable & tune autocomplete on an exposed filter (options, operators, results-based suggestions, the autocomplete route) → [configure/views_autocomplete_filters.md](configure/views_autocomplete_filters.md)
