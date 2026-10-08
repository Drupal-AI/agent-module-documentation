# The CSV query backend and its source settings

`ViewsCsvQuery` (`@ViewsQuery("views_csv_source_query")`, `src/Plugin/views/query/ViewsCsvQuery.php`)
replaces the SQL query plugin for views whose base table is `csv`. It builds an in-memory query
object (`src/Query/Select.php`) and runs it against a CSV parsed by `league/csv`, mediated by the
`views_csv_source.connection` service (`src/Query/Connection.php`).

## Creating a CSV view

1. Add a new View; in the **Show** ("View settings") select **CSV** as the base. `hook_views_data`
   (`ViewsCsvSourceViewsHooks::viewsData`) defines the `csv` base table with
   `query_id => views_csv_source_query`.
2. On save, `hook_ENTITY_TYPE_presave` (`ViewsCsvSourceHooks::viewPresave`) rewrites any display
   whose `query.type` is the default `views_query` to `views_csv_source_query` when
   `base_table === 'csv'`. `views_csv_source_post_update_ensure_views_csv_have_proper_query_type()`
   backfills the same on existing views.
3. Open **Advanced → Query settings → Settings** and fill the query options below.

## Query settings (options form)

Config schema: `views.query.views_csv_source_query`. Defaults from `defineOptions()`.

| Option | Default | Meaning |
|---|---|---|
| `csv_file` | `''` (required) | The CSV source URI. `entity_autocomplete` (`#target_type: file`, selection handler `default:views_csv_source_file_entity_selection`). Accepts a managed-file reference, an internal path, or an external URL — see "Source URI" below. `#maxlength` 2048. |
| `header_index` | `0` | Number of rows to skip before the header row (`setHeaderOffset`). |
| `headers` | `''` | JSON string of HTTP headers for the REST call, e.g. `{"Authorization":"Basic xxxxx","Content-Type":"application/csv"}`. Empty → `{"Content-Type":"application/csv"}`. |
| `request_method` | `get` | `get` or `post`. |
| `request_body` | `''` | POST body as Guzzle **multipart** JSON (shown only when method is `post`), e.g. `[{"name":"item_key","contents":"item value"}]`. |
| `show_errors` | `TRUE` | Surface CSV parse errors in the live preview / log. |

## Source URI forms

The value is normalised by `UriParserTrait`:

| Entered value | Stored URI | Resolves to |
|---|---|---|
| A file picked via autocomplete (`Label (12)`) | `entity:file/12` | the managed file's real path (`file_system->realpath`). |
| A path starting with `/` (e.g. `/sites/default/files/data.csv`) | `internal:/sites/default/files/data.csv` | `DRUPAL_ROOT` + the path. |
| Any scheme-less string | `internal:<string>` | same as above (form validation requires a leading `/`). |
| `http://…` / `https://…` | unchanged | fetched with Guzzle. |

The autocomplete file list is restricted to `text/csv` files by `CsvFileSelection`
(`@EntityReferenceSelection("default:views_csv_source_file_entity_selection")`, extends core
`FileSelection`, adds `condition('filemime', 'text/csv')`).

### Tokens and contextual arguments in the path

`applyTokenReplacements()` substitutes, in order: Drupal `[…]` tokens (via `globalTokenReplace` /
`\Drupal::token()`), Views `{{ arguments.X }}` / `{{ raw_arguments.X }}` tokens from
`build_info['substitutions']`, and each `%` in the URI is replaced positionally by the next view
argument. This lets one view target many files, e.g.
`/sites/default/files/my_file__{{ raw_arguments.value }}.csv`. When the path is tokenised the
Column Selector may not be able to preview headers — the column fields then fall back to a plain
text input (see handlers.md).

## How a query runs

- `build()` calls `query()` which does `connection->select($uri, $options)` to make a `Select`,
  adds fields (`compileFields`), order-by, group-by and the `where` condition
  (`buildCondition`), plus any relationships as joins (`addJoin`).
- `execute()` runs the `Select`: `Connection::createCsvReader()` streams a local file
  (`League\Csv\Reader::from`) or fetches a remote one (`fetchContent` → Guzzle → `Reader::fromString`).
  Filtering, sorting, grouping/aggregation, offset/limit and column projection all happen in PHP
  (`Select::getRecords` and helpers). Results become `ResultRow`s.
- **Aggregation / group by** is supported: `getAggregationInfo()` exposes group/count/sum/avg/min/max;
  `Select::applyGroupBy()` and `ViewsCsvQuery::aggregateWithConstant()` compute them in memory. The
  `csv_constant` field gives every row a shared value to group on.
- **Remote caching**: successful HTTP responses are cached in `cache.default` under
  `views_csv_source_<md5(uri)>` for `cache_ttl` seconds (`views_csv_source.settings`); a
  `PreCacheEvent` fires first (see events/pre_cache.md). Local files are never cached. See
  configure/settings.md.

## Relevant service / API surface

- `views_csv_source.connection` — `Drupal\views_csv_source\Query\Connection`
  (`select()`, `getCsvHeader()`, `getCsvColumnData()`, `createCsvReader()`).
- `ViewsCsvQuery::getCsvHeader()` / `getCsvColumnValues()` — used by the handlers to populate the
  Column Selector and the "options" filter's value list.
- Query tags added: `views`, `views_<view id>`.
