<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Autocomplete endpoint & form integration

## The endpoint
- **Route**: `suggestion.autocomplete` → `SuggestionController::autoComplete()`
- **Path**: `/suggestion/autocomplete`
- **Method**: GET, `_format: json`
- **Access**: `_access: 'TRUE'` — intentionally public so anonymous visitors receive completions.
- **Input**: query arg `q` (the partial the user typed). Core's autocomplete widget sends this
  automatically as `?q=<field value>`.
- **Output**: JSON array of `{"value": "<ngram>", "label": "<ngram>"}` objects, ordered by
  `density DESC, ngram ASC, atoms ASC`. Empty array `[]` when the trimmed query is shorter than
  the configured `min` (default 4).

### Request handling (what the controller does)
1. `q` is lowercased and `preg_replace` strips leading non-`[a-z]` and trailing non-`[a-z]`
   characters (so only lowercase words/spaces reach the query).
2. If `strlen(txt) < min` → return `[]` (cache max-age 0).
3. Word count drives an `atoms` ceiling (`count+2`, or `atoms_min+2` when below `atoms_min`).
4. `SuggestionStorage::like($txt)` escapes LIKE wildcards; the term becomes `escaped . '%'`
   (prefix match). If fewer than `limit` rows come back, a second pass with `'%' . escaped . '%'`
   (substring match) fills the remainder.
5. Rows are read from `{suggestion}` where `ngram LIKE :ngram AND src AND atoms <= :atoms`.
   `src` being truthy excludes disabled (src=0) entries.

### Query construction (security-relevant)
`SuggestionStorage::getAutocomplete()` uses a **bound parameter** for `:ngram` and `:atoms` and
`db->queryRange(...)`; the user input is additionally passed through `escapeLike()`. Input is not
concatenated into SQL. See also the admin `{ngram}` route args, constrained by `^[a-z ]{3,60}$`.

### Caching
`CacheableJsonResponse` with cache context `url.query_args:q`, cache tags
`suggestion:table` (invalidated on any index write) + `config:suggestion.config`, max-age 3600
(0 for below-min queries).

## Attaching autocomplete to a form
Any text/search field can use the endpoint by setting its `#autocomplete_route_name`. Three ways:

### 1. The provided search block
Place the **"Suggestion Search"** block (`suggestion_block`, `SuggestionBlock` →
`SuggestionBlockForm`). It renders a GET search form whose `keys` field already has
`'#autocomplete_route_name' => 'suggestion.autocomplete'`, with the form `#action` taken from
`suggestion.config:action` (default `/search/node`).

### 2. Config-driven attach (no code)
On `/admin/config/suggestion`, map a form to a field:
- **Simple** mode: one `form_key` + `field_name` pair (defaults `search_form` / `keys`).
- **Advanced** mode: many `form_id:field_name` lines.

`suggestion_form_alter()` looks up `autocomplete[$form_id]`, and `Helper::alterElement()`
recursively (max depth 4) finds a `search`/`textfield` element named `field_name`, sets its
`#autocomplete_route_name`, and appends `suggestion_surfer_submit` to `#submit` so submitted
searches feed the "surfer" source.

### 3. Your own hook (developer)
```php
function mymodule_form_FORM_ID_alter(&$form, FormStateInterface $form_state, $form_id) {
  $form['FIELD_NAME']['#autocomplete_route_name'] = 'suggestion.autocomplete';
  // Optional: record submitted searches as surfer suggestions.
  $form['#submit'][] = 'suggestion_surfer_submit';
}
```

## Notes for callers
- Suggestions are **lowercase-letter/space n-grams**, not entity IDs — selecting one fills the
  search box with text; it does not link to a node. The search itself is performed by whatever the
  form action points to (core search, a Views page, etc.).
- The index must be populated first (select content types, then index) or the endpoint returns `[]`.
