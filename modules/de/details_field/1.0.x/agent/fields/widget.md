<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Widget, attribute plugins & extension

## Widget `details_field`
`DetailsFieldWidget` (`src/Plugin/Field/FieldWidget/DetailsFieldWidget.php`) extends
`Drupal\text\Plugin\Field\FieldWidget\TextareaWithSummaryWidget`. `field_types = ['details_field']`.
It is dependency-injected with the `plugin.manager.details_field` service (see `create()`).

### Widget settings (`config/schema/details_field.schema.yml` → `field.widget.settings.details_field`)
| Key | Default | Meaning |
|---|---|---|
| `rows` | (inherited) | Textarea rows for the body. |
| `summary_rows` | `1` | Textarea rows for the summary. |
| `placeholder` | (inherited) | Placeholder text. |
| `allowed_attributes` | `{open:TRUE, name:TRUE, id:FALSE, class:FALSE, aria-label:FALSE}` | Which attribute controls editors may edit. |

`settingsForm()` removes the inherited `show_summary` control (summary is always visible) and adds an
`allowed_attributes` checkboxes element whose options come from
`DetailsFieldManager::getOptionsFromDefinitions()`. `settingsSummary()` lists the enabled attributes.

### Edit form (`formElement()`)
- `summary` is a `text_format` element (`#base_type => textarea`, rows from `summary_rows`), its
  format seeded from the item's `summary_format`; `#allowed_formats` is applied from the field's
  `summary_allowed_formats` setting (except on the default-value widget).
- An "Extra Settings" `#type => details` section holds the attribute inputs, built from the allowed
  attributes. For each allowed attribute definition the widget adds a form element of the
  definition's `#type`. Attributes flagged `specific_field: true` (`open`, `name`) map to their own
  item property; the rest (`id`, `class`, `aria-label`) go under an `attributes` fieldset. The
  `class` default is the stored class array imploded with spaces.

### Saving (`massageFormValues()`)
- Splits the `summary` text_format value into `summary` + `summary_format`.
- Flattens `extra_settings` back onto the item (so `open`/`name` and the `attributes` bag).
- Explodes a space-separated `class` string into an array, then `serialize()`s the whole
  `attributes` array for the blob column.

## Attribute plugin type `details_field`
`DetailsFieldManager` (`src/DetailsFieldManager.php`, service `plugin.manager.details_field` in
`details_field.services.yml`) is a `DefaultPluginManager` whose discovery is a `YamlDiscovery` on the
name **`allowed_attributes`** across all module directories (wrapped in
`ContainerDerivativeDiscoveryDecorator`), cached under `details_field`. `getOptionsFromDefinitions()`
returns `id => title` pairs; `getDefinitions()` yields the full definitions used to build widget
inputs.

### Shipped definitions (`details_field.allowed_attributes.yml`)
| Key | type | specific_field | Purpose |
|---|---|---|---|
| `open` | checkbox | true | Open by default. |
| `name` | textfield | true | Group name — one open at a time (accordion). |
| `class` | textfield | false | Extra whitespace-separated CSS classes. |
| `id` | textfield | false | Explicit element ID (overrides auto ID). |
| `aria-label` | textfield | false | ARIA label. |

### Add your own attribute options
Ship `MODULE.allowed_attributes.yml` in any enabled module with entries shaped like the above
(`title`, `type`, `description`, `specific_field`). Non-`specific_field` keys are stored in the
serialized `attributes` bag and emitted onto the `<details>` element as HTML attributes (escaped by
the render system's `Attribute` object); `specific_field` keys must correspond to a real item
property. Clear caches after adding a file.
