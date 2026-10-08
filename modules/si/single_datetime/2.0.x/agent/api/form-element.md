<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# `single_date_time` Form API element & AttributeHelper

Besides the field widgets, the module exposes a reusable render element and a helper so you can
put the picker on **any** form — not just field widgets.

## The `single_date_time` render element

Defined by `\Drupal\single_datetime\Element\SingleDateTime` (`@FormElement("single_date_time")`).
It renders as a text input, attaches the `single_datetime/datetimepicker` library, and turns its
`#`-prefixed properties into the `data-*` attributes the JS reads.

```php
$form['purchase_date'] = [
  '#title' => 'Purchase date',
  '#type' => 'single_date_time',
  '#date_timezone' => date_default_timezone_get(),
  '#default_value' => NULL,
  '#date_type' => 'datetime',        // datetime | date
  '#required' => TRUE,
  '#hour_format' => 24,
  '#allow_times' => 60,
  '#allowed_hours' => \Drupal\Component\Serialization\Json::encode(range(0, 23)),
  '#disable_days' => [],
  '#inline' => '0',
  '#mask' => FALSE,
  '#datetimepicker_theme' => 'default',
  '#single_date_time' => 'datetime',
  '#exclude_date' => '',
  '#min_date' => '', '#max_date' => '',
  '#year_start' => '1970', '#year_end' => date('Y'),
];
```

`\Drupal\single_datetime\AttributeHelper::allElementAttributes()` returns a ready-made set of
these `#` properties you can spread onto the element.

## Attaching to a plain textfield (any element)

For a non-`single_date_time` element, attach the library and the `data-*` attributes yourself:

```php
$form['purchase_date'] = [
  '#title' => 'Purchase date',
  '#type' => 'textfield',
  '#attributes' => \Drupal\single_datetime\AttributeHelper::defaultWidget(),
];
$form['#attached']['library'][] = 'single_datetime/datetimepicker';
$form['#attributes']['autocomplete'] = 'off';
```

`AttributeHelper` methods:

| Method | Returns |
|---|---|
| `defaultWidget()` | `data-*` attributes for a datetime textfield |
| `defaultDateOnlyWidget()` | same but `data-single-date-time = date` |
| `allAttributes()` | full `data-*` set incl. `start_date`, `min_date`, `max_date`, year range |
| `allElementAttributes()` | the `#`-property form of the above (for a `single_date_time` element) |

## Mechanism notes

- `SingleDateTime::processSingleDateTime()` reads `#disable_days` (mapping Sunday `7 → 0` for the
  JS lib), `#exclude_date` (newline-split `d.m.Y` list), `#allowed_hours`, etc., and JSON-encodes
  them into `data-*` attributes; `preRenderSingleDateTime()` forces `type=text`.
- The widgets (`SingleDateTimeBase::getCommonElementSettings()`) map each stored widget setting to
  the matching `#` property, so the widget settings and this element share one code path.
- No library at `/libraries/jquery-datetimepicker` → the field is just a plain text input; nothing
  fatals.
