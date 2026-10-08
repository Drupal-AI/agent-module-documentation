<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Migrate generator automatically builds Drupal migration configurations from source CSV files, mapping columns to entity fields, driven entirely from Drush.
---
The module scans a directory of CSV files named `{entity_type}-{bundle}.csv` (or `{entity_type}.csv`) and, for each, generates a `migrate_plus` migration config using `migrate_source_csv` as the source. Its Drush command `migrate_generator:generate_migrations <dir> [options]` accepts pattern, delimiter, enclosure, multi-value delimiter, date format, relative-filepath flag, update flag and a migration tag (default `mgg`). A `Scanner` inspects entity types/bundles and fields; a `Generator` writes migration configs; and a set of `GeneratorProcessPlugin`s handle complex/typed fields — formatted text, link, datetime_range, date_recur, address, price, geolocation, entity/entity-revision references (with migration dependencies), files/images (absolute, relative or URL), booleans, timestamps, IP addresses and more. Column names use a `/` separator for field sub-properties (e.g. `body/value`, `price/number`), and references carry the source row's id so dependent migrations resolve.

Setup: enable the module and its dependencies (`migrate`, `migrate_plus`, `migrate_source_csv`, `migrate_skip_on_404`), place CSV files (first column = source row id, other columns = exact field machine names) in a folder, then run the Drush command and execute the generated migrations with `drush migrate:import`. Security posture: the base module is **Drush/CLI-only — it has no routes, permissions, forms or config entities**, so there is no web endpoint by which a non-admin could run or generate migrations. The companion **migrate_generator_export** submodule (which exports content to CSV) does add UI: routes `/admin/content/migrate-generator-export` and its download route are both gated by the *access csv export* permission (`restrict access: true`), and the download controller validates a CSRF token (or a `state`-stored token for Drush-initiated downloads via `hash_equals`) before streaming a temporary file. No raw SQL, disabled TLS or unverified callbacks were observed.
---
- Enable the module and its four migration dependencies.
- Name source files `{entity_type}-{bundle}.csv` (e.g. `node-article.csv`) or `{entity_type}.csv`.
- Put the source row id in the first CSV column; name other columns as field machine names.
- Generate migrations: `drush migrate_generator:generate_migrations /path/to/csv`.
- Set a custom migration tag with `--tag=mytag` (default `mgg`).
- Override the CSV delimiter/enclosure/multi-value delimiter via options.
- Set the CSV date format with `--date_format`.
- Map complex fields with `/`-separated columns (`body/value`, `link/uri`, `price/number`).
- Import files/images by absolute path, relative path (`--relative_filepath`) or URL.
- Wire entity-reference fields by matching source ids across CSV files.
- Handle datetime_range, date_recur, address, geolocation, key/value and price fields.
- Import IP address / IP range values (`field_ipaddress`).
- Add multilingual translations via a `translation/` subfolder with langcode columns.
- Update previously generated migrations with `--update`.
- Run the generated migrations with `drush migrate:import --tag=mgg`.
- Extend field handling by writing a custom `GeneratorProcessPlugin`.
- Enable `migrate_generator_export` to export existing content to compatible CSVs.
- Configure per-type export at `/admin/config/content/migrate-generator-export`.
- Export content at `/admin/content/migrate-generator-export` (permission-gated).
- Export via Drush: `migrate_generator_export:export <type> <bundle> [id]`.
