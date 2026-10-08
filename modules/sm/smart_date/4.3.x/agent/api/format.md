# Format Smart Date values in code

Formatting logic lives in `Drupal\smart_date\SmartDateTrait` (used by the `smart_date.manager`
service, `SmartDateManager`). Key static methods:

```php
use Drupal\smart_date\SmartDateTrait;

// Render a start/end pair with a named format. Returns a render array.
$build = SmartDateTrait::formatSmartDate(
  $start,          // start timestamp (int)
  $end,            // end timestamp (int)
  $settings,       // format settings array (see below)
  $timezone,       // timezone string or NULL
  'default'        // return type: 'default' (render array) or 'string'
);

// Load a smart_date_format config entity's settings as an array.
$settings = SmartDateTrait::loadSmartDateFormat('compact');

// Helpers
SmartDateTrait::isAllDay($start, $end, $timezone);   // bool
SmartDateTrait::normalizeSettings($settings);        // fill defaults
```

- `$settings` accepts keys like `date_format`, `time_format`, `separator`, `join`,
  `date_first`, `ampm_reduce`, `allday_class` — matching the `smart_date_format` schema.
- Get the service instead of the trait when you need a service: `\Drupal::service('smart_date.manager')`.
- A Twig extension (`smart_date_format.twig_extension`) exposes formatting in templates.
- To read stored values off an entity, the field item exposes `value` (start), `end_value`,
  `duration`, `timezone`.
