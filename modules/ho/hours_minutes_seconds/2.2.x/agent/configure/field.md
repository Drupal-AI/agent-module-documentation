# Add & configure an HMS field

No admin/configure route (`configure: null`). You configure it like any Field API field, per
bundle, via *Manage fields* / *Manage form display* / *Manage display* — or in `field.*` and
`core.entity_*_display.*` config directly.

## The field type

- Field type id: **`hour_minutes_seconds`**. Storage: one column `value`, `int`, `unsigned: FALSE`,
  `not null: FALSE` — i.e. **total seconds** (negative allowed, NULL allowed).
- `default_widget = hour_minutes_seconds_default`, `default_formatter = hour_minutes_seconds_default_formatter`.

### Field-instance settings (min/max)

`field.field_settings.hour_minutes_seconds` → keys `min`, `max` (both strings, seconds; blank = no
constraint). Validated on save by the field's constraint; the widget also shows a formatted hint.

```php
// Create an HMS field on Article with a 1-minute..8-hour constraint.
use Drupal\field\Entity\FieldStorageConfig;
use Drupal\field\Entity\FieldConfig;
FieldStorageConfig::create([
  'field_name' => 'field_duration', 'entity_type' => 'node', 'type' => 'hour_minutes_seconds',
])->save();
FieldConfig::create([
  'field_name' => 'field_duration', 'entity_type' => 'node', 'bundle' => 'article',
  'label' => 'Duration', 'settings' => ['min' => '60', 'max' => '28800'],
])->save();
```

## Widget settings — `hour_minutes_seconds_default`

Schema `field.widget.settings.hour_minutes_seconds_default`:

| Key | Type | Meaning |
|---|---|---|
| `format` | string | Input format editors type (see format strings below). |
| `default_placeholder` | bool | Use the format string itself as the placeholder. |
| `placeholder` | string | Custom placeholder when `default_placeholder` is off. |
| `show_seconds_hint` | bool | Show the stored raw-seconds value under the widget. |

The widget parses the typed string to seconds on validation; an invalid string or an out-of-range
value (min/max) sets a form error.

## Formatter settings

- **`hour_minutes_seconds_default_formatter`** (`field.formatter.settings.*`): `format` (string),
  `leading_zero` (bool), `live_timer` (bool — JS count-up).
- **`hour_minutes_seconds_countdown_formatter`**: `format`, `leading_zero`, `finished_text`
  (shown when the JS countdown hits zero; sets `#cache['max-age'] = 0`).
- **`hour_minutes_seconds_natural_language_formatter`**: `display_formats` (sequence of unit keys),
  `separator` (default `, `), `last_separator` (default ` and `).
- **`hour_minutes_seconds_iso_duration_formatter`**: `visible_label` (bool — wrap in `<time>`),
  `human_fallback` (string — the `title` tooltip format).

```php
// Show field_duration as ISO 8601 wrapped in a <time> element on the default view display.
$vd = \Drupal::entityTypeManager()->getStorage('entity_view_display')->load('node.article.default');
$vd->setComponent('field_duration', [
  'type' => 'hour_minutes_seconds_iso_duration_formatter',
  'settings' => ['visible_label' => TRUE, 'human_fallback' => 'h:mm:ss'],
])->save();
```

Read back the chosen formatter:
```bash
drush cget core.entity_view_display.node.article.default content.field_duration
```

## Format strings

`h:mm`, `h:mm:ss`, `hh:mm:ss`, `m:ss`, `mm:ss`, `d:h:mm:ss`, `h`, `m`, `s`. Units: `w` week,
`d` day, `h` hour, `m` minute, `s` second (factor map in the service). Doubled letters (`hh`, `mm`,
`ss`) mean zero-padded; the service `normalizeFormat()` collapses `hh`→`h` internally. Add more via
`hook_hour_minutes_seconds_format_alter()` (see hooks doc).

## Timer state (rendered markup)

Live timer/countdown output carries `data-hms-format`, `data-hms-since`, `data-hms-offset`,
`data-hms-leading-zero`, `data-hms-countdown` on the element, plus attaches library
`hours_minutes_seconds/hours_minutes_seconds` and `drupalSettings.hours_minutes_seconds.servertime`.
Theme via classes `hour-minutes-seconds--running`, `--countdown`, `--countdown-finished` (1.x
underscore aliases are still emitted).
