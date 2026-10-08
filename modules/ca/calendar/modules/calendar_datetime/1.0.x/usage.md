Calendar Datetime is a helper submodule of Calendar that supplies a Views argument-default plugin ("Calendar Current date") so a calendar-style view opens on today's date when no period is present in the URL.

---

Calendar Datetime is a small companion module bundled with the Calendar project whose job is to hold date/time classes and functions that Calendar needs but that are not (yet) in Drupal core's DateTime module. In this release its one working piece is a Views **argument-default** plugin registered with the id `date` and the title "Calendar Current date" (`Drupal\calendar_datetime\Plugin\views\argument_default\Date`). When a Views contextual filter (a date argument) has no value in the URL, this plugin fills in the current date using the request time, so a Calendar view lands on "today" by default. It is period-aware: if the contextual filter is a core Date argument that advertises its own format via `getArgFormat()`, the plugin formats the current time with that format (matching year, month, day, or week granularity); otherwise it falls back to `Y-m-d`. The plugin implements `CacheableDependencyInterface` with an empty cache-context list and a max-age of 0, so the "current date" it produces is never cached and always reflects the real request time. The module exists partly to carry a core patch (issue #2325899) that allows the current day to be used as a default argument. It declares no admin UI, permissions, config, or Drush commands — it is consumed entirely through the Views UI by the parent Calendar module. Requires Views (its plugin extends the Views argument-default base and inspects the Views Date argument) and works alongside core datetime date fields.

---

- Make a Calendar view open on the current month/week/day when the URL has no date segment.
- Provide a "today" default for a Views date contextual filter without writing code.
- Select "Calendar Current date" as the "Provide default value" type on a date argument.
- Default a month-granularity contextual filter (e.g. `date_year_month`) to the current month.
- Default a day-granularity contextual filter to the current day.
- Default an ISO-week contextual filter to the current week.
- Default a year-granularity contextual filter to the current year.
- Let the argument's own `getArgFormat()` decide the date format so the default matches the filter's granularity.
- Fall back to a `Y-m-d` default date when the argument does not expose a format.
- Base the default on the server request time (`datetime.time`) rather than a hard-coded date.
- Keep the "current date" default uncached (max-age 0) so it is always accurate.
- Avoid stale calendars by ensuring the default date is recomputed on every request.
- Give the parent Calendar style/pager a starting period to render before the user navigates.
- Pair with the Calendar Pager so prev/next navigation begins from today.
- Reuse the plugin on any Views date argument, not only Calendar displays.
- Supply the current date to a custom Views display that needs a date-based default.
- Carry the core datetime patch (#2325899) that enables current-day default arguments.
- Drive a "what's happening now" landing view that starts at the present date.
- Build an events calendar whose default landing page is the current month.
- Ship a calendar page that needs no query string to show the relevant period.
