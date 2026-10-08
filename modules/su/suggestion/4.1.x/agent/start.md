<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Suggestion (suggestion) — agent index

Self-contained autocomplete/typeahead engine. Builds an **n-gram index** from published node
titles (plus admin "priority" phrases and visitor "surfer" searches) into a dedicated
`{suggestion}` table, and serves ranked completions as JSON. No dependencies beyond core
`^10.2 || ^11`; no Search API/Solr required.

## What it actually does
- **Index (`\Drupal\suggestion\SuggestionHelper`)**: `tokenize()` lowercases, strips non-`[a-z ]`,
  drops words shorter than `min`, removes stopwords; `atomize()` splits into words; `ngrams()`
  builds forward + reversed word-windows of `atoms_min`..`atoms_max` words; each n-gram is
  MERGE-ed into `{suggestion}` with an `atoms` count, `qty`, `src` bitmap, and a `density` score
  (`calculateDensity()`).
- **Sources / `src` bitmap** (`SuggestionStorage`): `1` content (node titles), `2` surfer
  (submitted searches), `4` priority (admin keywords), `0` disabled.
- **Serve (`\Drupal\suggestion\Controller\SuggestionController::autoComplete`)**: route
  `suggestion.autocomplete` at `/suggestion/autocomplete`, `_format: json`,
  **`_access: 'TRUE'`** (open by design — anonymous visitors need completions). Reads `?q=`,
  lowercases/trims it, prefix-LIKE then substring-LIKE against the index, returns
  `[{value,label},…]`. Returns `[]` when `strlen(q) < min`.
- **Live sync**: `hook_node_insert/update/delete` add/remove title n-grams for published nodes of
  selected types; `hook_cron` reindexes when config is not `synced`.

## Wiring autocomplete onto a form
Three ways, all pointing a field at route `suggestion.autocomplete`:
1. Place the **"Suggestion Search" block** (`suggestion_block`) — a search form pre-wired to the route.
2. Settings form: add a `form_id:field_name` pair (simple or advanced mode). `hook_form_alter()`
   → `Helper::alterElement()` sets `#autocomplete_route_name` and appends `suggestion_surfer_submit`.
3. Your own `hook_form_FORM_ID_alter()`: set
   `$form['FIELD']['#autocomplete_route_name'] = 'suggestion.autocomplete';`.

## Routes & access
| Route | Path | Access |
|---|---|---|
| `suggestion.autocomplete` | `/suggestion/autocomplete` | `_access: 'TRUE'` (public, JSON) |
| `suggestion.admin` | `/admin/config/suggestion` | `administer suggestion` |
| `suggestion.index` | `/admin/config/suggestion/index` | `administer suggestion` |
| `suggestion.list` / `.search` | `/admin/config/suggestion/search[/{ngram}]` | `administer suggestion` |
| `suggestion.edit` | `/admin/config/suggestion/edit/{ngram}` | `administer suggestion` |

Admin `{ngram}` params are constrained by `^[a-z ]{3,60}$`. Only permission provided:
`administer suggestion`.

## Storage & caching
- Table `{suggestion}` (see `suggestion.install`): PK `ngram varchar(65) binary`; columns
  `src`, `atoms`, `qty`, `density` + supporting indexes.
- Config objects `suggestion.config` (indexing/serving settings) and `suggestion.stopword`
  (stopword list + hash). Defaults: `min 4`, `max 45`, `atoms_min 1`, `atoms_max 6`, `limit 20`,
  `entry_style simple`, `form_key search_form`, `field_name keys`, `action /search/node`.
- Responses are `CacheableJsonResponse` with context `url.query_args:q`, tags
  `suggestion:table` + `config:suggestion.config`, max-age 3600 (0 for too-short queries).

## Detail docs
- `api/autocomplete-endpoint.md` — the JSON endpoint contract + how to attach it to any form.
- `config/indexing-and-settings.md` — settings, the three index sources, and the indexing workflow.

## Notes
- New install indexes nothing until content types are selected and suggestions are indexed
  (cron or the "Index Suggestions" batch form). The `{suggestion}` table starts empty.
- Query parsing is alpha-only: non-`[a-z]` characters are stripped from `q` before matching, so
  suggestions are lowercase-letter/space phrases.
