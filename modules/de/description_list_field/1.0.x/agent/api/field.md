# description_list_field — field type, widget, formatter, theme

## Field type: `description_list_field`
`src/Plugin/Field/FieldType/DescriptionListFieldItem.php` (extends `FieldItemBase`).

Storage `schema()` columns (per delta; the field is multi-value, add it with cardinality > 1 for a
real list):
- `term` — `text` / size `big`.
- `description` — `text` / size `big`.
- `format` — `varchar(255)`, indexed (`indexes: format`). Holds a text-format machine name.

Properties (`propertyDefinitions()`):
- `term` — string.
- `description` — string.
- `format` — `filter_format`.
- `description_processed` — computed string, class `\Drupal\text\TextProcessed`, `text source =
  description`; not internal (readable via API/REST). Use this to get the description with its text
  format applied, e.g. `$item->description_processed`.

`isEmpty()` is true only when BOTH `term` and `description` are empty. Annotation sets
`default_widget = description_list_widget`, `default_formatter = description_list_formatter`.

Create the field with Field UI (Manage fields → Add field → "Description list") or in code as any
field: `FieldStorageConfig::create(['type' => 'description_list_field', ...])`.

## Widget: `description_list_widget`
`src/Plugin/Field/FieldWidget/DescriptionListFieldWidget.php`. `formElement()` builds:
- `term` → `#type => textfield`, maxlength 255.
- `description` → `#type => text_format`, `#base_type => textarea`, default format
  `filter_fallback_format()`.

`massageFormValues()` flattens the composite value: sets `$item['format'] =
$item['description']['format']` then `$item['description'] = $item['description']['value']`. No
widget settings form.

## Formatter: `description_list_formatter`
`src/Plugin/Field/FieldFormatter/DescriptionListFieldFormatter.php`. `viewElements()` returns one
render array `#theme => 'description_list'` with `#items[delta]`:
- `term` → `['#plain_text' => $item->term]` (escaped, no markup allowed from the term).
- `description` → `['#type' => 'processed_text', '#text' => $item->description, '#format' =>
  $item->format, '#langcode' => …]` — the ProcessedText element applies the stored text format and
  bubbles cache context/tags. No formatter settings.

## Theme hook: `description_list`
Registered by `description_list_field_theme()` with one variable `items`. Template
`templates/description-list.html.twig` outputs `<dl>`, and per item a `<dt>` when
`item.term['#plain_text']` is set and a `<dd>` when `item.description['#text']` is set. Override by
copying the template into your theme.

## TMGMT integration
`description_list_field_field_info_alter()` sets `tmgmt_field_processor` to
`TmgmtDescriptionListFieldProcessor` (only used when TMGMT is installed). That processor extends
`DefaultFieldProcessor` and, in `extractTranslatableData()`, removes the `#format` from the `term`
column so the term is extracted as plain text without a text format. No effect without TMGMT.
