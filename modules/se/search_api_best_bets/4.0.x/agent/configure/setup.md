# Set up Search API Best Bets

Two-part setup: (1) an editorial field on entities, (2) a processor on the Search API index. No global admin
page (`configure` is null).

## 1. The best-bets field

Add a field of type **`search_api_best_bets`** ("Search API Best Bets") to each bundle that should support best
bets (Structure → the bundle → Manage fields). Storage columns: `query_text` (varchar 360) and `exclude`
(tinyint boolean).

Widget `search_api_best_bets_widget` ("Search API Best Bets form") — `multiple_values: TRUE`, rendered as a
`details` group. Two textareas:
- **elevate** — comma-separated queries that elevate this entity.
- **exclude** — comma-separated queries that exclude this entity (hidden if the `disable_exclude` widget
  setting is on).

`massageFormValues()` splits on commas, trims, lowercases each `query_text`, and stores one row per query with
the `exclude` flag. Widget settings customize the label/placeholder/description of each textarea and the
`disable_exclude` toggle. Formatter `search_api_best_bets_formatter` renders stored rows (query text + Yes/No
exclude) via template `search-api-best-bets-formatter.html.twig`.

### Permissions (field access)

`Hook/SearchApiBestBetsHooks::entityFieldAccess` forbids `view`/`edit` on any `search_api_best_bets` field
unless the account holds `view search_api_best_bets keywords` / `edit search_api_best_bets keywords`
respectively (`search_api_best_bets.permissions.yml`; not `restrict access: true`). Grant these to the roles
that curate search results.

## 2. The Search API processor

On the index: **Processors** tab → enable **Search API Best Bets** (`search_api_best_bets_processor`). Settings
(schema `plugin.plugin_configuration.search_api_processor.search_api_best_bets_processor`):

| Setting | Meaning |
|---|---|
| `fields` | per-datasource checkboxes of available `search_api_best_bets` fields to use (at least one required) |
| `query_handler` | which query-handler plugin to use (options filtered to those supporting the index's backend) |
| `result_elevated_flag` | `query_handler` (read elevated flag from backend) or `local` (set it in Drupal from the ids sent) |
| `elevated_score` | float; if > 0, overrides the score of elevated items (e.g. 100 to force them first) |

### Query-time behavior (`BestBetsProcessor`)

- `preprocessSearchQuery()`: only simple/scalar keys are handled; keys are urldecoded, trimmed of quotes,
  lowercased. `getBestBets()` runs an entity query `condition($field.'.query_text', $keys)` +
  `condition($field.'.exclude', 0|1)` with `accessCheck()` and `currentRevision()`, loads each entity, checks
  `access('view')`, and collects Search API item ids (`entity:<type>/<id>:<lang>`). Matched elevate/exclude id
  sets are passed to the handler's `alterQuery()`.
- `postprocessSearchResults()`: calls the handler's `alterResults()` (or sets flags locally), then applies
  `elevated_score` to items whose `elevated` extra-data is set.
- Matching is **exact equality** of the whole search string against a stored `query_text` (both lowercased) —
  not substring/token matching.

## Theming — elevated markers

`Hook/SearchApiBestBetsThemeHooks`:
- `preprocess_search_api_page_result`: sets `elevated` (bool) and adds class `search-api-elevated` to title and
  content attributes for elevated items.
- `preprocess_views_view_unformatted` / `preprocess_views_view_list`: adds `search-api-elevated` to elevated
  rows when the view uses a Search API query.
- Read elevation elsewhere via `$item->getExtraData('elevated')`.

## Solr specifics

Bundled handler `solr` supports backends `search_api_solr` and `acquia_search`. It sets Solr options
`forceElevation`/`enableElevation` and `elevateIds` / `excludeIds` (comma-joined Solr document ids built from
site hash + index + item id), requests `fl=id,[elevated]`, and reads `[elevated]` back in `alterResults()`.
Requires Apache Solr 4.7+ (for `elevateIds`/`excludeIds`); it does NOT generate `elevate.xml`.
