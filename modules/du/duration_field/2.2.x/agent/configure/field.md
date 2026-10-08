<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Adding & configuring a Duration field

There is **no module settings page**. A duration field is configured like any Field API
field: add it to a bundle, set its field settings, pick a widget, pick a formatter.

## Field type: `duration`

`Drupal\duration_field\Plugin\Field\FieldType\DurationField`
- `default_widget = duration_widget`, `default_formatter = duration_human_display`.
- **Columns / properties:**
  - `duration` — varchar(255), the ISO 8601 duration string (e.g. `P1Y2M10DT2H30M`). Main property.
  - `seconds` — bigint, the duration in seconds (set in `preSave()`; enables math/queries).
  - `weeks` — int (default 0), extra weeks (ISO 8601 has no week token).
- Empty value = `P0M` (`Iso8601StringInterface::EMPTY_DURATION`); `isEmpty()` treats `P0M`/null/'' as empty.

### Field settings (`defaultFieldSettings`)

| Setting | Default | Meaning |
|---|---|---|
| `granularity` | `y:m:d:h:i:s` | Colon-separated units the widget collects: `y` years, `m` months, `d` days, `h` hours, `i` minutes, `s` seconds |
| `include_weeks` | `false` | Adds a "Weeks" input to the widget |

The settings form uses the custom `granularity` form element (checkboxes per unit) + an
"Include weeks" checkbox.

## Widget: `duration_widget`

Renders one `number` input per enabled granularity unit (via the `duration` form element).
On submit the values become a `DateInterval` stored as the duration string; `seconds` is
recomputed in `preSave()`.

## Formatters

| Formatter id | Label | Settings |
|---|---|---|
| `duration_human_display` (default) | Human Friendly | `text_length`: `full`/`short`; `separator`: `space`/`hyphen`/`comma`/`newline` (+ custom) |
| `duration_string_display` | Duration String | none — outputs the raw ISO 8601 string |
| `duration_time_display` | Time Format | none — `YY/MM/DD HH:MM:SS` (theme `duration_field_duration_time`); hides date or time part if granularity has only the other |

## Scriptable: create a duration field

```php
use Drupal\field\Entity\FieldStorageConfig;
use Drupal\field\Entity\FieldConfig;

FieldStorageConfig::create([
  'field_name' => 'field_reading_time', 'entity_type' => 'node', 'type' => 'duration',
])->save();
FieldConfig::create([
  'field_name' => 'field_reading_time', 'entity_type' => 'node', 'bundle' => 'article',
  'label' => 'Reading time',
  'settings' => ['granularity' => 'h:i:s', 'include_weeks' => FALSE],
])->save();

// Widget + formatter on the displays:
\Drupal::service('entity_display.repository')->getFormDisplay('node','article')
  ->setComponent('field_reading_time', ['type' => 'duration_widget'])->save();
\Drupal::service('entity_display.repository')->getViewDisplay('node','article')
  ->setComponent('field_reading_time', ['type' => 'duration_human_display',
    'settings' => ['text_length' => 'short', 'separator' => 'comma']])->save();
```

## Set / read a value

```php
$node->set('field_reading_time', ['duration' => 'PT1H30M']);   // 1 hour 30 min
$node->save();
$iso     = $node->field_reading_time->duration;                 // 'PT1H30M'
$seconds = $node->field_reading_time->seconds;                  // 5400
$interval = $node->field_reading_time->duration; // property "duration" also exposes a DateInterval via getCastedValue()
```

Read the field settings back: `drush field:info` or
`FieldConfig::loadByName('node','article','field_reading_time')->getSetting('granularity')`.
