<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Output formats & the TomlFormatter utility

`ApiLoader::load()` maps the requested format to one `document_loader` Output value object. All six
Output classes come from `Drupal\document_loader\DocumentLoaderType\Output\*`. Each is constructed
with `(string $content, array $metadata)`.

| Format     | Output class     | How the content is produced |
|------------|------------------|-----------------------------|
| `json`     | `JsonOutput`     | `json_encode($data, JSON_UNESCAPED_UNICODE \| JSON_UNESCAPED_SLASHES \| JSON_PRETTY_PRINT)` |
| `yaml`     | `YamlOutput`     | `Symfony\Component\Yaml\Yaml::dump($data, 4, 2)` |
| `markdown` | `MarkdownOutput` | `dataToMarkdown()` (default format) |
| `text`     | `TextOutput`     | `dataToText()` |
| `csv`      | `CsvOutput`      | `dataToCsv()` |
| `toml`     | `TomlOutput`     | `TomlFormatter::format($data)` |

Any other value → `\InvalidArgumentException` with message
`"Output format '<f>' is not implemented. Supported formats are: json, yaml, markdown, text, csv, toml"`
(`getUnsupportedFormatMessage()` reads `output_types` from the plugin definition).

## Inline converters (in `ApiLoader`)

- `dataToText($data, $indent)` — recursive 2-space indented `key: value` tree; scalars cast to string.
- `dataToMarkdown($data, $depth)` — if `$data` is a sequential array of objects, renders a Markdown
  table (`| col | ... |` + `---` rule + rows; nested arrays inside a cell → `json_encode`). Otherwise
  a key/value list: nested objects/tables get an `#`-level heading (capped at `######`), simple arrays
  become `- ` bullet lists, scalars become `**key:** value`.
- `dataToCsv($data)` — a sequential array of objects → header row + record rows. Otherwise it calls
  `findRecordArray()` to locate the first nested sequential-array-of-objects; if found it emits a
  combined header from `collectAllKeysIncludingMetadata()` and rows from `flattenDataWithMetadata()`
  (top-level scalars become a leading "metadata" row). Fallback: treat the whole thing as one
  key/value record. Array/object cell values are `json_encode`d; every field is quoted and
  `"`→`""` escaped by `csvEscapeLine()`.
- Helpers: `isSequentialArray()`, `findRecordArray()`, `collectAllKeys()`,
  `collectAllKeysIncludingMetadata()`, `flattenDataWithMetadata()`.

## `TomlFormatter` (`src/Utility/TomlFormatter.php`)

Static utility, usable independently: `TomlFormatter::format(mixed $data, string $prefix = ''): string`.

- Splits keys into simple `values` and `tables` (nested/associative arrays, or sequential arrays of
  arrays). Emits `key = value` pairs first, then `[table]` sections, and `[[table]]` blocks for an
  array of tables (recursing via `format()`).
- `formatValue()`: `null`→`""`, bool→`true`/`false`, int/float→literal, string→`"..."` with
  `addslashes()` (multiline strings use `"""..."""`), array→`formatArray()` (`[a, b, c]`).
- `formatKey()`: bare `[A-Za-z0-9_-]` keys are unquoted; anything else is `"`-quoted with `addslashes()`.
- `isSequentialArray()` mirrors the loader's list-vs-map check.

Covered by `tests/src/Unit/Utility/TomlFormatterTest.php` and
`tests/src/Unit/Plugin/DocumentLoader/ApiLoaderTest.php` (Guzzle `MockHandler`, dictionary-API fixture).
