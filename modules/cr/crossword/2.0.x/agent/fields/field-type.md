<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `crossword` field type, widget & validation

## Install & enable

```bash
composer require drupal/crossword
drush en crossword -y
```

Only dependency is core **`file`** (`masterminds/html5` comes in via Composer). No permissions, no
routes, no Drush in the base module.

## Field type — `CrosswordItem`

`src/Plugin/Field/FieldType/CrosswordItem.php`, `@FieldType(id = "crossword")`, **extends core
`FileItem`**. `default_widget = "file_generic_crossword"`, `default_formatter =
"file_default_crossword"`, `cardinality = "1"`. It carries four constraints:
`ReferenceAccess`, `FileValidation` (both inherited behavior), plus the module's own `CrosswordFile`
and `CrosswordDimensions`.

`defaultFieldSettings()` adds to core file settings:

| Setting | Default | Meaning |
|---|---|---|
| `file_extensions` | `txt puz xml ipuz` | Allowed upload extensions. |
| `allowed_parsers` | `[]` | Checkbox list; restrict which `crossword_file_parser` plugins may parse this field. Empty = all parsers allowed. |
| `max_columns` / `min_columns` | `NULL` | Grid width limits (ignored when blank/zero). |
| `max_rows` / `min_rows` | `NULL` | Grid height limits (ignored when blank/zero). |

`fieldSettingsForm()` renders the parser checkboxes (options from
`crossword.manager.parser::getInstalledParsersOptionList()`) and four `number` fields for the limits.
Schema for all of this is in `config/schema/crossword.schema.yml`
(`field.field_settings.crossword` / `field.storage_settings.crossword`).

## Widget — `CrosswordFileWidget`

`src/Plugin/Field/FieldWidget/CrosswordFileWidget.php`, `@FieldWidget(id =
"file_generic_crossword")`. It is `class CrosswordFileWidget extends FileWidget {}` — a plain rename of
the core file widget so the field gets its own default widget id. No added behavior.

## Validation constraints (run at upload / entity validation)

Both constraints are `type = "file"` and only act on the integer file-reference items
(`get_class($item) == "Drupal\Core\TypedData\Plugin\DataType\IntegerData"`).

- **`CrosswordFile`** (`Plugin/Validation/Constraint/CrosswordFile.php` +
  `CrosswordFileValidator.php`): loads the file, restricts to the field's `allowed_parsers`
  (`loadDefinitionsFromOptionList()`), finds an applicable parser
  (`filterApplicableDefinitions()`), and actually **calls `parse()`**. If no parser matches →
  violation `noParser` ("That does not appear to be a supported Crossword Puzzle file format."). If a
  parser matches but throws `CrosswordException` → violation `corrupted` (message includes the parser
  title and exception message), and the failure is logged to the `crossword` channel. This is what
  blocks corrupted/unsupported uploads.
- **`CrosswordDimensions`** (`CrosswordDimensions.php` + `CrosswordDimensionsValidator.php`): runs
  after `CrosswordFile`, so it trusts the data service. Reads the field's `max/min_columns` and
  `max/min_rows`, gets the parsed grid size via
  `crossword.data_service::getDimensionAcross()/getDimensionDown()`, and adds `tooManyColumns` /
  `tooFewColumns` / `tooManyRows` / `tooFewRows` violations as needed.

## Field icon library

`crossword_field_type_category_info_alter()` (in `crossword.module`) attaches the
`crossword/crossword.crossword-icon` library to the `general` field-type category so the field's icon
shows on the *Add field* screen.

## Add a Crossword field (config equivalent)

Create a `crossword` field on a bundle via *Manage fields*, then set the display format on *Manage
display* (see [formatters.md](formatters.md)). Example view-display switch:

```bash
drush cset core.entity_view_display.node.puzzle.default \
  content.field_crossword.type crossword -y   # the "Crossword Puzzle" formatter
drush cr
```
