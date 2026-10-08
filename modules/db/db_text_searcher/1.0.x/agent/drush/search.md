<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `db-text-searcher:search` Drush command

## Install & enable

```bash
composer require drupal/db_text_searcher
drush en db_text_searcher -y
```

info.yml declares a dependency on `embed:embed`, so `drush en` will also pull in the **Embed**
module (the command code itself never calls Embed). There is no `composer.json` in the module,
no permissions, no config form, and nothing to set up — enabling the module is enough to expose
the command.

## Run it

```bash
drush db-text-searcher:search "sample text"
# alias:
drush db-text-search "sample text"
```

One required argument, `searchText` (the string to look for). No options are defined by the
command; Drush's own `-v` / `-vv` verbosity flags change how much it prints (see Output).
The command has no Drupal permission gate — anyone with shell/Drush access can run it.

## What it searches (from `SearchTextCommands::searchPartialMatch()`)

1. **Table inventory:** selects `table_name` from `information_schema.tables` where
   `table_schema` = the current DB and
   `t.table_name NOT REGEXP 'batch|revision|cache|tmgmt'` — so tables whose names contain
   `batch`, `revision`, `cache`, or `tmgmt` are skipped.
2. **Per-table columns (`getTableColumnData()`):** from `information_schema.columns`, marks
   primary-key columns (`column_key = 'PRI'`) and textual columns
   (`data_type IN ('char','varchar','text','longtext')`), **excluding** columns whose names match
   `%deleted%`, `%delta%`, or `%langcode%` (bound `NOT LIKE` with `escapeLike`). Unknown tables
   throw `InvalidArgumentException`.
3. **Charset adaptation (`getColumnCharacteristics()`):** reads `character_set_name`; for non-utf8
   columns the term is run through `iconv('UTF-8','ASCII//IGNORE', …)`. It also searches a
   JSON-escaped variant of the term so hits inside JSON-encoded field values are found.
4. **The match query:** `db->select($table,'t')->fields('t', primaryKeys + [column])` with an
   `orConditionGroup()` of two conditions:
   `condition($column, '%'.escapeLike($term).'%', 'LIKE')` and the same for the JSON-escaped term.
   Executed in pages of 1000 rows via `clone` + `range($offset, 1000)` until exhausted.
   **The search term is passed as a bound placeholder value** (via `escapeLike` + the query
   builder), never concatenated into the SQL string; table/column identifiers come from
   `information_schema`, not from the argument.

Results are de-duplicated by `"{table}-{entityId}-".md5(matchedContent)`; each kept result stores
`table`, `column`, `entity` (dash-joined primary key values), and `matched_value`.

### Match context (`extractMatchContext()`)

For each row's column value it: html-entity-decodes, strips backslashes and control chars,
lowercases, extracts URLs via a regex (keeping only URLs containing the term), then collects up to
`±100` characters of context around each occurrence of the (lowercased) term, adding `...`
ellipses at truncated ends. Returns the unique set of context snippets and matched URLs.

## Output (`printAndSaveResults()`)

- Prints `Search results for "<term>":` to the console. With `-v` (verbose) it prints one line per
  match (table, column, entity id, URL, truncated value); with `-vv` (very verbose) it also prints
  per-column/table batch counts.
- Writes a CSV with header `Table, Column, Entity, URL, Matched Value`. It is first written to
  `temporary://temp_csv_file.csv` with `fputcsv`, then moved (via `file_system->move(...,
  FileExists::Replace)`) to
  `public://text_search_results_<Y-m-d_H-i-s>_<6-hex>.csv` — where `<6-hex>` is the first 6 chars
  of `sha1(rand())`.
- Prints `Results saved to: <baseUrl><relative web path>` — the base URL comes from the current
  request's `getSchemeAndHttpHost()`.

### Entity URL resolution (`resolveEntityUrl()`)

Maps a table-name fragment to a front-end path and substitutes the entity id:

| Table fragment | URL pattern |
|---|---|
| `node_` | `/node/{entity_id}` |
| `taxonomy_term_` | `/taxonomy/term/{entity_id}` |
| `user_` | `/user/{entity_id}` |
| `menu_link_content` | `/admin/structure/menu/item/{entity_id}` |
| `block_content_` | `/block/{entity_id}` |
| `media_` | `/media/{entity_id}/edit` |
| `redirect` | `/admin/config/search/redirect/edit/{entity_id}` |

Special case: for `cohesion_layout_field_data` it first looks up `parent_id` and uses that as the
id (returns null if no row). Tables that match no fragment get `[No direct URL]` in the CSV.

## Gotchas / operating notes

- **Heavy on large databases:** it scans the textual columns of nearly every table with
  `LIKE '%term%'` (non-sargable, full scans) in 1000-row pages. Run it off-peak; expect load.
- **Excludes are name-based, not semantic:** any table whose name happens to contain `batch`,
  `revision`, `cache`, or `tmgmt` is skipped even if you wanted it; conversely most user/content/
  config tables are included.
- **Errors are swallowed:** `searchPartialMatch()` wraps everything in try/catch and, on any
  exception, logs the message and returns `[]` — a run can report "No results found." after an
  internal error. Check logs (`drush watchdog:show`) if results look empty unexpectedly.
- **The `information_schema` REGEXP/`table_schema` logic assumes MySQL/MariaDB**; behaviour on
  other database drivers is not accounted for.
- The written CSV lands in the site's public files directory and is not cleaned up afterwards —
  delete old `text_search_results_*.csv` files when you are done with them.
