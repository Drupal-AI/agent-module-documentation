<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Database Text Searcher (db_text_searcher) — agent index

A **developer/CLI** module that adds one **Drush command** to search a text string across (almost)
every table and column of the site database and export the matches to CSV. No web UI, no routes,
no permissions, no config, no plugins. Package: none set in info. Core requirement
`^10 || ^11`. License GPL-2.0-or-later. On-disk version `1.0.3-alpha1`.

- **The Drush command, how it searches, options, output** → [drush/search.md](drush/search.md)

## What it actually is

- One class: `SearchTextCommands` (final), in
  `src/Drush/Commands/SearchTextCommands.php`, extending `Drush\Commands\DrushCommands`.
- One command: `db-text-searcher:search` (alias `db-text-search`), one required argument
  `searchText`.
- Constructor-injected services: `file_system`, `database`, `request_stack` (via `create()`).
- **Dependencies:** info.yml declares `embed:embed`, but no code path uses Embed; there is no
  `composer.json`, no `.services.yml`, no `.routing.yml`, no `.permissions.yml`, no `config/`,
  no `.install`, no submodules. The whole module is the README, LICENSE, info.yml and this one
  command class.

## Mechanism (from source)

- `search()` calls `searchPartialMatch()`, then `printAndSaveResults()` (or prints
  "No results found.").
- `searchPartialMatch()` reads eligible tables from `information_schema.tables` filtered by
  `t.table_name NOT REGEXP 'batch|revision|cache|tmgmt'`, gets each table's primary keys +
  text columns from `information_schema.columns` (`getTableColumnData()`, excluding column names
  matching `deleted`/`delta`/`langcode`), checks each column's charset
  (`getColumnCharacteristics()`), and runs a batched (`range`, 1000/page) `SELECT` with an
  OR group of two `LIKE '%…%'` conditions (the raw term and a JSON-escaped form). Both use
  `$this->database->escapeLike(...)` and are passed as bound placeholder values by Drupal's
  query builder — the search term is **not** concatenated into SQL.
- `extractMatchContext()` builds a ~100-char snippet around each hit and harvests URLs via regex.
- `resolveEntityUrl()` maps table-name fragments (`node_`, `user_`, `taxonomy_term_`, `media_`,
  `block_content_`, `menu_link_content`, `redirect`) to a front-end path; special-cases
  `cohesion_layout_field_data` (looks up `parent_id`).
- `printAndSaveResults()` writes a CSV (`Table, Column, Entity, URL, Matched Value`) to a
  timestamped file under `public://`, then prints a download URL.

## Operating it

- CLI only: `drush db-text-search "sample text"`. `-v` prints each result line; `-vv` prints
  batch progress. Requires shell/Drush access (no Drupal permission gate).
