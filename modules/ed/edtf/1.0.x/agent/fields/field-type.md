<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `edtf` field type, widget and validation

## Field type — `EDTF`

`src/Plugin/Field/FieldType/EDTF.php`, extends core `FieldItemBase`.

```
@FieldType(
  id = "edtf",
  label = "Extended Date/Time Format",
  category = "date_time",
  default_widget = "edtf_widget",
  default_formatter = "edtf_humanizer"
)
```

- **Storage** (`schema()`): a single column `value` of type `char`, length **255**, `not null`.
  The EDTF string is stored verbatim (e.g. `2023-12-XX`, `1600~`, `2020/..`).
- **Property** (`propertyDefinitions()`): one string property `value` labelled *EDTF*.
- **Emptiness** (`isEmpty()`): item is empty when `value` is `NULL` or `''`.
- No `getConstraints()` override and **no config schema / config/install** ship with the module —
  the field has no per-field or per-storage settings.

Add it in the UI as field type **"Extended Date/Time Format"**, or via config:

```bash
drush field:create node article --field-name=field_when --field-type=edtf   # (drush ^12 field-create)
```

## Widget — `EDTFDefaultFieldWidget`

`src/Plugin/Field/FieldWidget/EDTFDefaultFieldWidget.php`, extends core `WidgetBase`.

```
@FieldWidget( id = "edtf_widget", label = "Default EDTF Widget", field_types = { "edtf" } )
```

- `formElement()` renders a plain `#type => 'textfield'`, seeded with the current `value`, with CSS
  class `edtf`, honoring the field's `#required`. It attaches an `#element_validate` callback
  `[static::class, 'validateElement']`. The widget has **no settings**.
- **Validation** — `validateElement()` (static): empty input is allowed (returns early); otherwise
  it calls `Helper::getParser()->parse($value)` and, if `$parsingResult->isValid()` is false, sets
  a form error *"Invalid EDTF date entered."* This is the module's only validation surface — it runs
  on form submit, so malformed EDTF cannot be saved **through this widget**. There is no field-type
  constraint, so values written by other means (migration, REST/JSON:API, programmatic) are not
  re-validated by the module.

## Accepted EDTF syntax (handled by the library, examples)

| Input | Meaning |
|---|---|
| `2023-12-24T18:00:00Z` | date-time, UTC |
| `2023-12-24` | a full date |
| `2023-12` | a month |
| `2023` | a year |
| `2023-12-XX` | unknown day in Dec 2023 |
| `202x` | a year in the 2020s |
| `2023?` | uncertain |
| `2023~` | approximate |
| `2023%` | uncertain **and** approximate |
| `2023-21` | season (Spring) |
| `2023-12-01/2023-12-24` | interval |
| `2020/..` | open-ended interval |

Parsing, validity and humanizing all come from the `professional-wiki/edtf` library via
`Drupal\edtf\Helper`; the module adds no EDTF grammar of its own.
