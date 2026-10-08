<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# How "all day" works (mechanism)

There is **no boolean column** for "all day". The state is derived from the stored times.

## `DateRangeAllDayHelper::isAllDay($item)`

`Drupal\date_all_day\Utility\DateRangeAllDayHelper` — one static method, `TIME_FORMAT = 'H:i:s'`.
Accepts either a `DateRangeItem` or an array with `value` / `end_value` `DrupalDateTime` objects
(the widget's form values); anything else throws `\InvalidArgumentException`.

Returns TRUE when, formatted in `date_default_timezone_get()`:

- start time is `00:00:00`, **and**
- end is empty **or** end time is `23:59:59`.

Use it in custom code:

```php
use Drupal\date_all_day\Utility\DateRangeAllDayHelper;
$all_day = DateRangeAllDayHelper::isAllDay($node->get('field_event_dates')->get(0));
```

## The widget — `DatetimeRangeAllDayWidget`

Extends `DateRangeDefaultWidget`.

- `formElement()` adds `$element['all_day']` (a checkbox, weight 2) whose `#default_value` is
  `isAllDay()` for the current item, attaches the `date_all_day/date_all_day` library, and applies
  the field's `optional_end_date` setting (title becomes "End date (optional)"; `#required` on
  `end_value` is cleared even when the field itself is required).
- `validateStartEnd()` overrides core's: errors if the end date is missing while
  `optional_end_date` is FALSE, and if the end date is before the start.
- `massageFormValues()` is where the coercion happens: if the checkbox is on it calls
  `setTime(0,0,0)` on the start and `setTime(23,59,59)` on the end before formatting to
  `DATETIME_STORAGE_FORMAT` in UTC. It explicitly re-sets the timezone first because the method
  runs twice per submit.

**Consequence:** the checkbox is not persisted anywhere; on the next form build it is re-derived
from the saved times.

## The JavaScript — `js/date_all_day.js`

`Drupal.behaviors.date_all_day` scopes to `.field--widget-daterange-all-day fieldset` and, when
the checkbox is ticked, hides both time inputs and writes `00:00:00` / `23:59:59` into them
(re-applying on date-field change). It is a convenience layer only — `massageFormValues()`
enforces the same thing server-side, so the values are correct even with JS off.

> Caveat: `date_all_day.libraries.yml` still declares a dependency on `core/jquery.once`, which no
> longer exists in Drupal 10/11 core. The behaviour file itself does not call `.once()`, so the
> logic does not depend on it, but the stale dependency is in the library definition.

## The formatters — `DateRangeAllDayTrait`

All three formatters `use DateRangeAllDayTrait`, which overrides `viewElements()`:

- computes `$is_all_day = DateRangeAllDayHelper::isAllDay($item)` per delta,
- when there is an end date **and** the two timestamps differ, renders
  `start_date` + `separator` + `end_date`; otherwise renders the start date alone (and merges
  `$item->_attributes`),
- each bound is built by `buildDateWithIsoAttribute()` → `#theme: 'time'` with
  `datetime="Y-m-d\TH:i:sZ"` and `#cache.contexts: ['timezone']`,
- `formatDate($date, $all_day)` (implemented per formatter) picks the `date_only_format` setting
  when `$all_day`, otherwise the parent's normal format setting.

Unlike core's `DateRangeDefaultFormatter`, this tolerates `$end_date === NULL` — which is what
makes `optional_end_date` usable.

## `date_all_day_update_8001()`

Legacy migration only. Earlier versions shipped their own `daterange_all_day` **field type**;
this update rewrites `field.storage.*` (`type` → `daterange`, `module` → `datetime_range`) and
`field.field.*` (`field_type` → `daterange`) plus their dependencies, then clears cached field
definitions. Nothing to run on a fresh install. The widget's `field_types` still lists
`daterange_all_day` for backwards compatibility.

## Things that surprise people

- Setting the times to `00:00:00`/`23:59:59` **by hand** (or by import) makes an item "all day" —
  the checkbox will appear ticked.
- Detection uses the **site default timezone**, not the user's; a value stored as UTC midnight is
  not all-day for a site in `Europe/Madrid`.
- A `daterange` field whose storage `datetime_type` is `allday`/date-only has no time to compare,
  so the module's widget adds no value there.
- `daterange_all_day_plain` is explicitly labelled DEPRECATED and takes no `date_only_format`.
