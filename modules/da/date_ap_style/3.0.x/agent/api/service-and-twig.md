# ApStyleDateFormatter service & `ap_style` Twig filter

## Service `date_ap_style.formatter`

Class `Drupal\date_ap_style\ApStyleDateFormatter` (autowired). Two public methods.

```php
$fmt = \Drupal::service('date_ap_style.formatter');
// or inject '@date_ap_style.formatter' / the class via autowiring.

// Single timestamp:
$out = $fmt->formatTimestamp(
  int $timestamp,
  array $options = [],                     // same keys as date_ap_style.settings
  \DateTimeZone|string|null $timezone = NULL,
  ?string $langcode = NULL,
  ?string $fieldtype = NULL                // e.g. 'smartdate'
);

// Start/end range:
$out = $fmt->formatRange(
  array $timestamps,                       // ['start' => int, 'end' => int]
  array $options = [],
  \DateTimeZone|string|null $timezone = NULL,
  ?string $langcode = NULL,
  ?string $fieldtype = NULL
);
```

Behavior:
- **`$options` merge rule:** if `$options` is **empty**, the service reads all defaults from
  `date_ap_style.settings`. If `$options` is non-empty, it merges your keys over a hard-coded
  all-FALSE/`separator=to` default set — it does **not** pull from config. So to tweak one flag
  while keeping the site defaults, read the config yourself and pass the full array, or accept
  the all-false base.
- Empty `$timezone` falls back to `date_default_timezone_get()`.
- `formatRange` collapses identical parts (same day / month / year) and inserts the configured
  separator (` to ` / ` – ` / `-`) between the differing parts; time is appended (or placed
  before the date when `time_before_date`), and `use_all_day` yields "All Day".

## Twig filter `ap_style`

Provided by `Drupal\date_ap_style\TwigExtension\DateApStyle` (tagged `twig.extension`). Wraps
`formatTimestamp()`:

```twig
{{ node.created.value|ap_style }}
{{ my_timestamp|ap_style({display_time: true, use_today: true}) }}
```

The filter takes an integer timestamp and an optional options array (same keys as the config /
formatter settings). There is no `ap_style` filter for ranges — use the `daterange_ap_style`
formatter or call `formatRange()` in PHP.
