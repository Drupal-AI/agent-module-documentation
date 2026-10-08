<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Migrate generator — Drush & CSV format

## Generate migrations (base module, CLI-only)
```
drush migrate_generator:generate_migrations <absolute-csv-dir> [options]
```
Options: `--pattern` (default `*.csv`), `--delimiter` (`;`), `--enclosure` (`"`), `--values_delimiter` (`|`), `--date_format` (`d-m-Y H:i:s`), `--relative_filepath` (bool), `--update` (regenerate), `--tag` (default `mgg`). One migration per source file. Then run `drush migrate:import --tag=mgg`.

## CSV rules
- File name `{entity_type}-{bundle}.csv` or `{entity_type}.csv` identifies target type/bundle.
- First column = source row id (source key only, not the destination id).
- Other columns = exact field machine names; list fields use keys not labels; multi-value uses the values delimiter.
- Complex fields use `/` sub-property columns: `body/value`, `body/format`, `date/value`, `date/end_value`, `price/number`, `price/currency_code`, `image/alt`, `image/target_id`, etc.
- Files/images: `field/target_id` holds an absolute path, a relative path (`--relative_filepath`), or a URL.
- References: put the referenced source's id in the column; the referenced type needs its own CSV (migration dependency is generated).
- Translations: a `translation/` subfolder, same filename pattern, with an extra `langcode` column.

## Export submodule `migrate_generator_export`
UI: config export entities at `/admin/config/content/migrate-generator-export`; run export at `/admin/content/migrate-generator-export` (perm **access csv export**, restricted). Drush:
```
migrate_generator_export:export <type> <bundle> [id]      # one type
migrate_generator_export:export_related <type> <bundle>   # + referenced types
migrate_generator_export:create_configs <type> <bundle> [--fields=a,b]
```
Options: `delimiter, enclosure, values_delimiter, date_format, file_format (url|filepath_absolute|filepath_relative), folder, file_export`.
