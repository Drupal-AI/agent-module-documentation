<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Year Only — programmatic surface

Namespaces under `Drupal\yearonly\Plugin\Field\…`. There are no services, no hooks, no
Drush commands — the module is three field plugins plus a Feeds target.

## Field type: `YearOnlyItem`

`Drupal\yearonly\Plugin\Field\FieldType\YearOnlyItem` (annotation `id = "yearonly"`,
`category = "date_time"`, `list_class = YearOnlyFieldItemList`, `default_widget` /
`default_formatter` = `yearonly_default`).

- **schema()** — one column `value`: `int` (length 50), indexed on `value`.
- **propertyDefinitions()** — single `value` property, `DataDefinition` of type `integer`,
  label "Year", required.
- **isEmpty()** — empty when `value` is `NULL` or `''`.
- **defaultFieldSettings()** — `['yearonly_from' => '', 'yearonly_to' => '']`.
- **fieldSettingsForm()** — renders the two range inputs (`yearonly_from` number,
  `yearonly_to` textfield); both required.

### Static helpers you can reuse

```php
use Drupal\yearonly\Plugin\Field\FieldType\YearOnlyItem;

// Resolve a "to" setting to a concrete year. Numeric strings pass through;
// anything else is fed to strtotime()+date('Y'), so "now", "+5 years", "-1 year" work.
$year = YearOnlyItem::calculateYear('now');        // e.g. "2026"
$year = YearOnlyItem::calculateYear('+5 years');   // current year + 5
$year = YearOnlyItem::calculateYear('1978');       // "1978"
```

- **calculateYear(string $year): mixed** — returns the resolved year (string/int), or the
  result of a failed `strtotime` for garbage input; used by the widget and validator.
- **validateMinAndMaxConfig(&$element, $form_state, &$complete_form): void** — element
  validator on `yearonly_from`; sets a form error unless resolved min < resolved max.
- **generateSampleValue(FieldDefinitionInterface $field_definition): array** — returns
  `['value' => mt_rand($min, $max)]` where `$min = yearonly_from ?: 1970` and
  `$max = calculateYear(yearonly_to)`. Used by Devel-generate / tests.

## Widget: `YearOnlyDefaultWidget`

`id = "yearonly_default"`, label "Select Year". `defaultSettings()` → `['sort_order' => 'asc']`.
`formElement()` builds a `select` from `range(yearonly_from, yearonly_to)` (with `now`
expanded to `date('Y')`, and `from` clamped to `to` when `from > to`); reverses the option
order when `sort_order === 'desc'`. `#empty_value` is `''`.

## Formatter: `YearOnlyDefaultFormatter`

`id = "yearonly_default"`, label "Year only". `viewElements()` renders each item as a
`markup` element printing the raw `$item->value` (the plain year, no formatting).

## Feeds target: `YearOnly`

`Drupal\yearonly\Feeds\Target\YearOnly` (`@FeedsTarget id = "year_only_feeds_target"`,
`field_types = {"yearonly"}`). Lets a `yearonly` field be a mapping target in a Feeds
importer; maps the incoming value onto the `value` property. Only relevant when the
`drupal/feeds` module is installed (it is a dev dependency of this module).
