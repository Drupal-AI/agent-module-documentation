<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `decimal_string` field type, widget & formatter

## Install & enable

```bash
composer require drupal/decimal
drush en decimal -y
```

Pulls in `brick/math`, `commerceguys/intl`, `prestashop/decimal` and needs the **BCMath**
PHP extension (`ext-bcmath`). If BCMath is missing, `decimal_requirements()` in `decimal.install`
raises a `REQUIREMENT_ERROR` on the status page. Only Drupal dependency is core `field`.

## Add the field

Field UI: *Manage fields* on any bundle → add a field of type **"Decimal (as string)"**
(plugin id `decimal_string`, category *Number*). Its default widget and formatter are both
`decimal_string`.

`DecimalStringItem` (extends core `Drupal\Core\Field\Plugin\Field\FieldType\DecimalItem`) stores
the value in a single `value` column of type `varchar` length **32** (see `schema()`), rather than
core's native `DECIMAL` column. That is what preserves precision for very large numbers.

## Storage settings (per-field, set once)

`storageSettingsForm()` reuses core's precision/scale form but caps them:

| Setting | Max | Config key |
|---|---|---|
| `precision` | 32 | `field.storage.*.settings.precision` |
| `scale` | 18 | `field.storage.*.settings.scale` |

Schema: `field.storage_settings.decimal_string` (both integers).

## Field settings (per-bundle)

Schema `field.field_settings.decimal_string`:

| Key | Type | Meaning |
|---|---|---|
| `min` | float | Minimum accepted value (enforced in the element validator). |
| `max` | float | Maximum accepted value. |
| `prefix` | label | Text before the value; `\|`-separated, last segment used, wrapped in `FieldFilteredMarkup`. |
| `suffix` | label | Text after the value; same handling. |

## Save-time normalization

`DecimalStringItem::preSave()` runs the stored value through the `decimal.normalizer` service,
so locale symbols (comma → dot), spaces, `+` and non-breaking spaces are cleaned before the string
is written to the database.

## Widget (`DecimalStringWidget`)

Extends core `NumberWidget`. Adds one setting, `placeholder` (default `''`), shown via
`settingsForm()`/`settingsSummary()`. In `formElement()` it builds a `#type => 'decimal_string'`
element, sets `#min`/`#max` from the field settings when numeric, and adds `#field_prefix`/
`#field_suffix` from the prefix/suffix settings (sanitized with `FieldFilteredMarkup::create`).

## Formatter (`DecimalStringFormatter`)

Extends core `DecimalFormatter`. Adds a `scale` setting (default **2**, min 0, max 18) in
`settingsForm()`. Its `numberFormat()` delegates to the `decimal.formatter` service:

```php
return \Drupal::service('decimal.formatter')->format($number, ['scale' => $this->getSetting('scale')]);
```

So the displayed value is the stored string rounded (HALF_UP) to the configured number of decimals.

### Config equivalent (view display)

```bash
drush cset core.entity_view_display.node.article.default \
  content.field_amount.type decimal_string -y
drush cset core.entity_view_display.node.article.default \
  content.field_amount.settings.scale 4 -y
drush cr
```
