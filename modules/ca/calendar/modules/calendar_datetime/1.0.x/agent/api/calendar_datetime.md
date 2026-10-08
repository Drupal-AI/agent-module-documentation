# Calendar Current date — the `date` argument-default plugin

The submodule's only functional class is a Views argument-default plugin:

- **id:** `date`
- **title:** `Calendar Current date`
- **class:** `Drupal\calendar_datetime\Plugin\views\argument_default\Date`
- **base:** `Drupal\views\Plugin\views\argument_default\ArgumentDefaultPluginBase`
- **implements:** `CacheableDependencyInterface`

It returns the **current date** as the default value for a Views date contextual filter that
has no value in the URL — so a Calendar view (or any view) lands on "today".

## Wire it up in the Views UI

1. Add a date **contextual filter** (argument) to the display — e.g. the Calendar date argument
   or a core one like `date_year_month` / `date_year` / `date_fulldate`.
2. Under **"When the filter value is NOT in the URL"**, choose **Provide default value**.
3. Set **Type** to **Calendar Current date** (the `date` plugin from this submodule).
4. Save. With no date segment in the URL the view now opens on the current period; the Calendar
   Pager can then move forward/back from there.

The parent **Calendar** module's template-generated views already select this default, which is
why a fresh calendar opens on the current month.

## How it computes the default (`getArgument()`)

```php
// Simplified from src/Plugin/views/argument_default/Date.php
if ($this->argument instanceof DateArgument && method_exists($this->argument, 'getArgFormat')) {
  $format = $this->argument->getArgFormat();   // match the argument's granularity
}
else {
  $format = 'Y-m-d';                            // fallback
}
$request_time = $this->time->getRequestTime();  // datetime.time
return $this->dateFormatter->format($request_time, 'custom', $format); // date.formatter
```

- **Granularity-aware:** if the contextual filter is a core Views `Date` argument that exposes
  `getArgFormat()`, the current time is formatted with that format, so a year argument gets `Y`,
  a month argument `Y-m`, a week argument its week format, etc. This makes the default match the
  **date period** the argument represents.
- **Fallback format:** any other argument gets `Y-m-d`.
- **Source of "now":** the core `datetime.time` service (`getRequestTime()`), formatted through
  the core `date.formatter` service — not a hard-coded string.

## Caching

The plugin is deliberately uncacheable so "current date" is never stale:

```php
public function getCacheContexts() { return []; }
public function getCacheMaxAge()   { return 0; }  // do not cache
```

## Dependencies & background

Requires core **Views** (extends the Views argument-default base and inspects the Views `Date`
argument) and works with core **datetime** date fields. Per the module README, the code lives here
temporarily to carry a core datetime patch (drupal.org issue #2325899, "Allow current date to be
default argument") until the equivalent lands in core; the plugin defines no config, permissions,
or Drush commands.
