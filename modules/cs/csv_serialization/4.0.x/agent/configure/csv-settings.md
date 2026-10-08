# CSV settings

There is no admin form of its own. Behavior is set through a `csv_settings` array — either
as a serializer `$context['csv_settings']`, or from a Views style plugin's
`options['csv_settings']` (e.g. the `views_data_export` "Data export" display, which exposes
these as a form). Keys read by `CsvEncoder::setSettings()`:

| Key | Effect | Default |
|---|---|---|
| `delimiter` | Field separator. `\t` is converted to a real tab. | `,` |
| `enclosure` | Field enclosure character. | `"` |
| `escape_char` | Escape character. | `\` |
| `new_line` | End-of-line sequence (passed through `stripcslashes`). | `\n` |
| `encoding` + `utf8_bom` | If `encoding === 'utf8'` and `utf8_bom` truthy, prepend UTF-8 BOM (Excel-friendly). | no BOM |
| `strip_tags` | Decode HTML entities and strip tags from each value. | `TRUE` |
| `trim` | Trim whitespace from each value. | `TRUE` |
| `output_header` | Emit the header row. | `TRUE` |

Constructor defaults (when no settings passed): `delimiter=","`, `enclosure='"'`,
`escapeChar="\\"`, `stripTags=TRUE`, `trimValues=TRUE`.

The in-cell separator for flattened multi-value data is a hard-coded `|` (not configurable).
