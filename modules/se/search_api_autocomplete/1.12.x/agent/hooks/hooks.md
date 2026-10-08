# Hooks (search_api_autocomplete.api.php)

- `hook_search_api_autocomplete_suggestions_alter(array &$suggestions, array $alter_params)` —
  add/remove/reorder the `SuggestionInterface[]` before they render. `$alter_params` includes
  the `SearchInterface $search`, the `user_input`, and the incomplete key.
- `hook_search_api_autocomplete_suggester_info_alter(array &$suggesters)` — alter the registry
  of suggester plugin definitions.
- `hook_search_api_autocomplete_search_info_alter(array &$searches)` — alter the registry of
  search plugin definitions.
- `hook_search_api_autocomplete_views_fulltext_fields_alter(array &$fields, SearchInterface $search, ViewExecutable $view)` —
  change which Views fulltext fields feed autocomplete for a Views-backed search.

Implement in `mymodule.module`. See `search_api_autocomplete.api.php` for signatures.
