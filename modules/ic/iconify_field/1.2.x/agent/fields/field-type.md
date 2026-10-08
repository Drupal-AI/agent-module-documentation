# The `iconify_field_icon` field type

Class: `Drupal\iconify_field\Plugin\Field\FieldType\IconItem` (extends `FieldItemBase`).
Annotation: `label = "Icon"`, `default_widget = "iconify_field_icon_picker"`,
`default_formatter = "iconify_field_icon_formatter"`. The stored `value` is an Iconify
`collection:name` string such as `mdi:home`.

Add it like any field via Field UI ("Icon" in the field-type list), `drush field:create`, or
`FieldStorageConfig`/`FieldConfig`. There is **no module settings page** (`configure` is null);
everything is configured on the field's widget/formatter forms. Set the field cardinality to
"Unlimited" to let editors store a list of icons.

## Stored columns (`schema()`)

| Column | Type | Notes |
|---|---|---|
| `value` | text (normal) | NOT NULL. The `collection:name` icon identifier. |
| `classes` | varchar 255 | NOT NULL, default `''`. Extra CSS classes for the rendered icon. |
| `decorative` | int tiny | NOT NULL, default `1` (TRUE). Whether the icon is decorative. |
| `arialabel` | text (normal) | NOT NULL. Accessible name (used only when not decorative). |

`update_10001` (in `iconify_field.install`) re-saves existing `iconify_field_icon` storage
definitions so the added advanced columns (`classes`/`decorative`/`arialabel`) are applied to
pre-existing fields.

## Property definitions (`propertyDefinitions()`)

| Property | Type | Label | Required |
|---|---|---|---|
| `value` | string | Value | **Yes** |
| `classes` | string | Additional classes | No |
| `decorative` | boolean | Is decorative | No |
| `arialabel` | string | Accessible name | No |

`isEmpty()` returns TRUE when `value` is `NULL` or `''` — the other columns do not keep an
item alive. `defaultFieldSettings()` seeds `value => ''`, `classes => ''`, `decorative => TRUE`,
`arialabel => ''`.

## Per-item options (set by the widget's "Advanced" details)

The picker widget writes these three columns from an **Advanced** fieldset (see
[widget.md](widget.md)):

- **`classes`** — space-separated extra classes merged onto the rendered icon.
- **`decorative`** — checkbox; when TRUE the formatter adds `aria-hidden="true"`.
- **`arialabel`** — accessible name; only meaningful when `decorative` is FALSE, in which case
  the formatter adds `aria-label` + `role="img"`. The widget's `massageFormValues()` **blanks
  `arialabel` whenever `decorative` is TRUE**, so a decorative icon never carries a label.

## Create a field in PHP

```php
use Drupal\field\Entity\FieldStorageConfig;
use Drupal\field\Entity\FieldConfig;

FieldStorageConfig::create([
  'field_name' => 'field_icon',
  'entity_type' => 'node',
  'type' => 'iconify_field_icon',
  'cardinality' => 1,
])->save();

FieldConfig::create([
  'field_name' => 'field_icon',
  'entity_type' => 'node',
  'bundle' => 'article',
  'label' => 'Icon',
])->save();
```

Then set the widget (`iconify_field_icon_picker`) and formatter
(`iconify_field_icon_formatter`) on the form/view displays — see [widget.md](widget.md) and
[formatter.md](formatter.md).

## Integration plugins keyed on this field type

- **GraphQLCompose** — `Plugin\GraphQLCompose\FieldType\IconItem` exposes the field as SDL
  `String` (uses `FieldProducerTrait`). Loads only when `graphql_compose` is installed.
- **SingleContentSync** — `Plugin\SingleContentSyncFieldProcessor\IconItem` exports/imports the
  raw field value array (`getValue()` / `set()`). Loads only when `single_content_sync` is
  installed.
