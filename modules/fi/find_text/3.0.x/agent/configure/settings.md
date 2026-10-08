# Settings — `find_text.settings`

Form `\Drupal\find_text\Form\SettingsForm` at `/admin/config/find-text/settings`
(`administer find text configuration`, `restrict access: true`). Defaults in
`config/install/find_text.settings.yml`.

## Keys
- **`field_types`** — map of field type → `{ allowed: bool, value_columns: [suffix,…] }`. Only `allowed`
  types are searched. `value_columns` lists the storage column suffixes to search for multi-column
  fields; default per field is `<field>_value`. Shipped-on: `string`, `string_long`, `text_long`,
  `text_with_summary` (`_value`,`_summary`), `link` (`_uri`,`_title`), `heading` (`_text`).
- **`allow_all_entities`** (true) — when true, every entity type's matching fields are searched. When
  false, only entity types flagged `allowed` in `entity_types` are searched.
- **`entity_types`** — map of entity type → `{ allowed: bool, bundles: [..] }` (used only when
  `allow_all_entities` is false). Ships with `node` (page, article), `menu`, `taxonomy`, `block_content`,
  `paragraph`.
- **`tables_to_skip`** — table names excluded from the search (default skips several `*_revision` /
  `*_field_data` tables to avoid duplicate/revision hits).
- **`enable_search_results_cache`** (true) / **`search_results_cache_duration`** (3600 s) — cache repeated
  searches.
- **`save_as_csv`** (false) — offer CSV export of results.

## Search form behavior
Form `\Drupal\find_text\Form\SearchForm` at `/admin/find-text` (`access find text`, `restrict access:
true`). Options exposed to the searcher: the needle, **regexp** (use SQL `REGEXP` instead of `LIKE`),
**render markup** (render matched HTML for readability — tables/lists/headings display as such), and a
language filter. Results group by entity with the field name and highlighted match.

Set via Drush, e.g. disable caching:
`drush config:set find_text.settings enable_search_results_cache false`.
