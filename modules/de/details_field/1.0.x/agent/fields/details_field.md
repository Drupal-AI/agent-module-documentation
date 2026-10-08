<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Field type, storage & formatters

## Install & enable
```bash
composer require drupal/details_field
drush en details_field -y
```
Enables core `field` and `text` if not already on. No config route; everything is per-field on the
entity's Manage fields / Manage form display / Manage display tabs.

## Field type `details_field`
`DetailsFieldItem` (`src/Plugin/Field/FieldType/DetailsFieldItem.php`) extends
`Drupal\text\Plugin\Field\FieldType\TextWithSummaryItem`. Attribute `#[FieldType]`: id
`details_field`, category `formatted_text`, `default_widget` and `default_formatter` both
`details_field`, `list_class` `TextFieldItemList`.

Stored columns (`schema()` adds to the inherited text-with-summary columns `value`, `summary`,
`format`):
| Column | Type | Meaning |
|---|---|---|
| `value` | text | Details body (rich text). |
| `format` | varchar_ascii | Text format for the body. |
| `summary` | text | Details summary / title (rich text). |
| `summary_format` | varchar_ascii(255) | Text format for the summary. |
| `open` | int tiny (default 0) | Render open by default. |
| `name` | varchar(255, default '') | `name` attribute (accordion grouping). |
| `attributes` | blob big, `serialize => TRUE` | Serialized bag of extra attributes (`id`, `class` array, `aria-label`). |

Property definitions (`propertyDefinitions()`): `summary_format` is a `filter_format` carrying the
`summary_allowed_formats` setting; `open` integer; `name` string; `attributes` a
`MapDataDefinition`.

`setValue()` normalizes input and, when `attributes` arrives as a string, unserializes it with
`unserialize($value, ['allowed_classes' => ['stdClass']])` (object injection restricted to
stdClass). It defaults `attributes` to `[]` when absent.

### Field settings form
`defaultFieldSettings()` adds `summary_allowed_formats => []` on top of the parent. `fieldSettingsForm()`
force-hides the inherited `display_summary` and `required_summary` controls (`#access = FALSE`) —
the summary is always shown and required — and adds a `summary_allowed_formats` checkboxes element
(options from `$this->get('format')->getPossibleOptions()`, validated by the inherited
`static::validateAllowedFormats`). Empty = all formats offered to the editor for the summary.

## Formatter `details_field` (default)
`DetailsFieldFormatter` (`.../FieldFormatter/DetailsFieldFormatter.php`) extends
`TextDefaultFormatter`. Setting `automatic_id` (default `FALSE`): when on, builds a URL-friendly `id`
from the summary — `str_replace(' ', '-', trim(preg_replace('/[^A-Za-z0-9 ]/', '',
strtolower(strip_tags($item->summary)))))`. A manually-set `id` attribute overrides it.

`viewElements()` renders each item as:
```
#type => details
#title => processed_text(summary, summary_format)   // sanitized by the text format
#open  => (bool) open
#attributes => [ id?, name?, ...extra attributes ]
content => processed_text(value, format)             // sanitized by the text format
```
Summary and body are always run through `#type => processed_text`, so the item's text formats apply
(cache metadata bubbles via `ProcessedText::preRenderText`). Extra attributes are merged after
`arrayFilterRecursive()` drops empty values; the `name` attribute is added when non-empty. Attribute
values are emitted through the render system's `Attribute` object, which HTML-escapes them.

## Formatter `details_field_summary`
`DetailsFieldSummaryFormatter` (extends `FormatterBase`) renders only the summary as
`#type => processed_text` (summary + summary_format). Useful for teasers/listings.

## Config example (view display)
```bash
drush cset core.entity_view_display.node.article.default \
  content.field_details.type details_field -y
drush cset core.entity_view_display.node.article.default \
  content.field_details.settings.automatic_id 1 -y
drush cr
```

## Views
`hook_field_views_data()` (`details_field.views.inc`) exposes columns `value` (Content), `summary`,
`open` (boolean), `name`, `attributes` as Views field/filter/sort/argument handlers (string handlers
for filter/argument on the standard columns).
