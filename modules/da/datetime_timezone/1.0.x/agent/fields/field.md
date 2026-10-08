# Field type, widget and formatter

The module ships one field type, one widget and one formatter. Everything is a thin subclass of the
equivalent core `datetime` plugin; the only new data is a per-value `timezone` string.

| Plugin | id | Class | For field types |
|---|---|---|---|
| Field type | `datetime_timezone` | `DateTimeTimezoneItem` (extends core `DateTimeItem`) | — |
| Widget | `datetime_timezone` | `DateTimeTimezoneWidget` (extends core `DateTimeDefaultWidget`) | `datetime`, `datetime_timezone` |
| Formatter | `datetime_timezone_default` | `DateTimeTimezoneDefaultFormatter` (extends `DateTimeTimezoneFormatterBase`) | `datetime_timezone` |

## Field type — `datetime_timezone`

`DateTimeTimezoneItem` extends core `DateTimeItem`, so it keeps core's `value` column (a UTC datetime
string) and the `datetime_type` storage setting (date-only vs date+time — `field.storage_settings.datetime_timezone`
inherits `field.storage_settings.datetime`). It adds:

- Property `timezone` — `DataDefinition::create('string')`, label "Timezone".
- Column `timezone` — `varchar(255)`, alongside `value`.

`default_widget = datetime_timezone`, `default_formatter = datetime_timezone_default`, and it reuses
core's `DateTimeFieldItemList` as `list_class`. The computed `date` property (a `DrupalDateTime`) and
`DATETIME_STORAGE_FORMAT`/`DATE_STORAGE_FORMAT` semantics are inherited unchanged from core.

## Widget — `datetime_timezone`

Adds a `timezone` sub-element to core's datetime widget and does the timezone bookkeeping
(`DateTimeTimezoneWidget.php`):

- **`formElement()`** — after `parent::formElement()`, if the item already has a stored `timezone`
  it converts the default value into that zone (`$element['value']['#default_value']->setTimeZone(...)`
  and sets `#date_timezone`) so the editor re-opens the same local time. It then appends
  `$element['timezone']`: a `#type => 'select'` whose `#options` come from
  `\Drupal\Core\Datetime\TimeZoneFormHelper::getOptionsListByRegion()` (region-grouped PHP timezone
  list), defaulting to the item's current `timezone`.
- **`massageFormValues()`** — for each delta with a non-empty `timezone`, it rebuilds the `value` as a
  `DrupalDateTime` of the entered wall-clock time *interpreted in the selected zone*
  (`new DrupalDateTime($value['value']->format(DATETIME_STORAGE_FORMAT), new \DateTimeZone($tz))`),
  then defers to `parent::massageFormValues()` — which is core's `DateTimeWidgetBase`, and that
  converts the value to **UTC for storage**. Net effect: `value` is stored in UTC, `timezone` stores
  the chosen zone name.

Because `field_types` lists both `datetime` and `datetime_timezone`, the widget can be selected on a
plain core `datetime` field too. There it still reinterprets the entered time in the picked zone, but
a core `datetime` field has no `timezone` column, so the chosen zone itself is **not persisted** — use
it on a `datetime_timezone` field if you want the zone kept.

## Formatter — `datetime_timezone_default`

`DateTimeTimezoneFormatterBase` (abstract) provides the settings and date-formatting helpers;
`DateTimeTimezoneDefaultFormatter` provides `viewElements()`.

- **Setting** `format_type` (default `medium`) — the machine name of a core `date_format` entity.
  `settingsForm()` builds a `<select>` of all `date_format` entities (loaded via `entity_type.manager`
  → `date_format` storage) labelled with a live-formatted sample; `settingsSummary()` shows a sample
  render. Schema: `field.formatter.settings.datetime_timezone_default` → `format_type: string`.
- **`viewElements()`** — for each item with a `value`, renders `#theme => 'time'` with
  `#text => formatDate($item->date, $item->timezone)` and a machine-readable
  `datetime` attribute set to the value in **UTC** (`$date->format(\DateTimeInterface::ATOM, ['timezone' => 'UTC'])`).
  `formatDate()` calls `date.formatter`'s `format($timestamp, $format_type, '', $timezone)` — passing
  the **stored per-value timezone** as the display zone, which is what makes the value render in its
  own zone rather than the site/viewer zone. The render array carries `#cache['contexts'] = ['timezone']`.

## Wire it up from code

```php
// 1) Create the field storage + instance (field type = datetime_timezone).
\Drupal\field\Entity\FieldStorageConfig::create([
  'field_name' => 'field_event_time',
  'entity_type' => 'node',
  'type' => 'datetime_timezone',
  'settings' => ['datetime_type' => 'datetime'], // or 'date'
])->save();
\Drupal\field\Entity\FieldConfig::create([
  'field_name' => 'field_event_time',
  'entity_type' => 'node',
  'bundle' => 'article',
  'label' => 'Event time',
])->save();

// 2) Form widget.
\Drupal::service('entity_display.repository')
  ->getFormDisplay('node', 'article', 'default')
  ->setComponent('field_event_time', ['type' => 'datetime_timezone'])
  ->save();

// 3) Display formatter.
\Drupal::service('entity_display.repository')
  ->getViewDisplay('node', 'article', 'default')
  ->setComponent('field_event_time', [
    'type' => 'datetime_timezone_default',
    'settings' => ['format_type' => 'long'],
  ])->save();
```

Reading a value: `$node->field_event_time->value` is the UTC datetime string,
`$node->field_event_time->timezone` is the stored zone name, and `$node->field_event_time->date` is
the computed `DrupalDateTime`.
