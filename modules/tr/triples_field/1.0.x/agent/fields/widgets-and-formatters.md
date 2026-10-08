<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Widgets, formatters, Feeds and hooks

## Widgets

Both widgets accept `field_types = {"triples_field"}` and share `getSubwidgets()`,
`massageFormValues()`, `getSettings()`/`getFieldSettings()`.

- **`triples_field_table`** (`TriplesFieldTable`, label "Triple Field Table") — the **default
  widget**. Renders the three sub-widgets of a single delta as one row of an HTML `#type => table`;
  overrides `formMultipleElements()` to draw multi-value items as a drag-orderable table with an
  "Add another item" AJAX button (via `hook_preprocess_field_multiple_value_form` reshaping
  `field_multiple_value_form`).
- **`triples_field`** (`TriplesField`, label "Triple Field") — stacked sub-widgets inside a
  container, with an **inline** display option and per-column `label_display`
  (block/inline/invisible/hidden).

### Sub-widget matrix (`getSubwidgets($storageType, $isList)`)

If the column has an allowed-values list, `select` and `radios` are prepended. Then by storage type:

| Storage type        | Sub-widgets offered                                   |
| ------------------- | ----------------------------------------------------- |
| `boolean`           | checkbox                                               |
| `string`            | textfield, email, tel, url, **color**                 |
| `email`             | email, textfield                                      |
| `telephone`         | tel, textfield                                        |
| `uri`               | url, textfield                                        |
| `text` / `text_long`| textarea (`text_long` is forced to a `text_format` CKEditor with a format select) |
| `integer`/`float`/`numeric` | number, textfield, range                      |
| `datetime_iso8601`  | datetime                                              |

`getSettings()` picks the first eligible sub-widget when none is chosen, and forces `text_long`
columns to a formatted textarea (`editor => TRUE`). Per-widget settings: `size`, `placeholder`,
`label` (checkbox), `cols`, `rows` (textarea). `massageFormValues()` unwraps `text_format`
(`value` → column, other keys → `<column>_format`), converts `''` to NULL, and converts a
`DrupalDateTime` back to the UTC storage string (`Y-m-d\TH:i:s` or `Y-m-d`).

## Formatters

All extend `Base` (`FormatterBase`) and inject `config.factory`, `renderer`,
`entity_type.manager`. Ids and behaviour:

- **`triples_field_table`** (`Table`) — **default**. One HTML table; optional row-number column
  (`number_column`, `number_column_label`), per-column header labels
  (`<column>_column_label`). Each cell is themed via `triples_field_subfield`.
- **`triples_field_details`** (`Details`) — a `details` element per item; the first column is the
  title, the rest are `<p>` rows. `open` setting.
- **`triples_field_html_list`** (`HtmlList` extends `ListBase`) — `ul` / `ol` / `dl` (`list_type`);
  `dl` uses the `triples_field_definition_list` template, else `item_list` with the
  `triples_field_item` theme. `inline` option.
- **`triples_field_unformatted_list`** (`UnformattedList` extends `ListBase`) — each item via the
  `triples_field_item` theme; `inline` option.

### `Base::prepareItems()` — per-column value preparation

Runs once (items are cloned in `view()`), per column, unless the column is set **`hidden`**
(value nulled). It: maps boolean → on/off label; wraps `text_long` in `#type => processed_text`
with the stored `<column>_format`; number-formats numeric columns (`numberFormat()` →
`number_format` with per-column scale/decimal/thousand separators); renders `datetime_iso8601`
via `#theme => time` (storage-tz for date-only, user tz for datetime); for list columns replaces
the stored key with its allowed-values label unless **"Display key"** is on.

### Link building (email / telephone / uri)

When a column's **Display as link** setting is on (`$linkTypes = ['email','telephone','uri']`), the
value becomes a `#type => link` render element:

- `email` → `Url::fromUri('mailto:' . $value)`
- `telephone` → `Url::fromUri('tel:' . rawurlencode(preg_replace('/\s+/','',$value)))`, external
- `uri` → `Url::fromUri($value)`, external

The `uri` case passes the editor-supplied stored value straight to `Url::fromUri()`. This is
**safe** because rendering an external `Url` runs through core's unrouted URL assembler, which
only builds a link when `UrlHelper::isExternal()` accepts the scheme (safe protocols only); a
`javascript:` / `data:` value causes an `\InvalidArgumentException` rather than a rendered link.
Link text (`#title`) is the plain value, HTML-escaped by the link generator. All twig templates
auto-escape column values (`{{ subitem }}`; `text` uses `|nl2br`), so there is no raw-markup sink.

## Feeds target (optional)

`\Drupal\triples_field\Feeds\Target\TriplesField` (`@FeedsTarget id = "triples_field"`) exposes
each column as a mappable property. Feeds is **not** a declared dependency — the class only loads
when Feeds is installed.

## Hooks (`triples_field.module`)

- `hook_theme` — registers the three templates.
- `hook_help` — help page text (note: the help text is copy-pasted boilerplate referencing a
  "user dashboard"; ignore it, it does not describe this module).
- `template_preprocess_*` — build variables for the three templates.
- `hook_field_storage_config_update` — warns when a column storage type changes.
- `hook_validation_constraint_alter` — repoints `NotEqualTo` at the Symfony constraint (for
  required booleans).
- `hook_theme_suggestions_*` / `_alter` — per-field-name suggestions for item, subfield,
  definition list, `item_list`, `table`, `details`.
- `hook_preprocess_field_multiple_value_form` — reshapes the multi-value form into the table widget.
- `hook_field_type_category_info_alter` — attaches the field icon library to the fallback field
  category.
