# Configuration

Single DateTimePicker has no central settings form. You configure it per field,
per form mode, by choosing its widget and adjusting that widget's settings on the
entity's **Manage form display** page.

## Assign the widget to a field

1. Make sure the entity has a date field of a supported type (or add one). The
   three widgets match these field types:

   | Widget | Field type | Provided by |
   |--------|-----------|-------------|
   | **Single Date Time** (`single_date_time_widget`) | `datetime` | single_datetime |
   | **Single Date Time (timestamp)** (`single_date_time_timestamp_widget`) | `timestamp`, `created` | single_datetime |
   | **Single Date Time Range** (`single_date_time_range_widget`) | `daterange` | single_datetime_range (submodule) |

2. Go to **Manage form display** for the entity — for a content type,
   `/admin/structure/types/manage/<type>/form-display`.
3. In the **Widget** column for your date field, select the matching Single Date
   Time widget.
4. Click the gear icon to open the widget's settings, adjust them (see below),
   and click **Update**, then **Save**.

## Widget settings

Every option below has a sensible default, so you only need to touch the ones you
care about.

- **Hour format** — `24h` (default) for a 24-hour clock, or `12h` for AM/PM.
- **Allow seconds** — off by default (seconds stay fixed at `00`); turn on to let
  editors pick seconds.
- **Allow times** — the minute granularity in the time picker: 5, 10, 15
  (default), 30, or 60 minutes. Set it to 15 for quarter-hour slots.
- **Allowed hours** — a comma-separated list of hours to offer (for example
  `8,9,10,...,17` for business hours). Leave empty for all hours.
- **Disable days** — grey out chosen weekdays in the calendar (for example
  Saturday and Sunday to block weekends).
- **Exclude date** — specific dates to block, one per line in `d.m.Y` format
  (handy for holidays).
- **Inline** — render the picker always-visible on the form instead of as a
  popup.
- **Mask** — add an input mask (`__.__.____`) that guides manual typing.
- **DateTimePicker theme** — `default` (light) or `dark` colour scheme.
- **Start date** — the date the calendar opens on when the field is empty.
- **Min date / Max date** — the earliest and latest selectable date-time (for
  example `0` for "now" as the minimum, to prevent past dates).
- **Year start / Year end** — the range of the fast year selector.
- **Allow blank** — let editors clear the value back to empty.

## Building an appointment-slot picker (example)

Combine a few settings to constrain entry: set **Hour format** to `24h`, **Allow
times** to `15`, and **Allowed hours** to your opening hours (say `9,10,11,12,13,
14,15,16`), then use **Disable days** to grey out weekends. Editors now can only
pick weekday times on the quarter hour within business hours.

## Deploying the configuration

The widget choice and all of its settings are stored on the entity's form-display
configuration, so they travel with your exported configuration like any other
display setting — no separate step is needed to move them between environments.

Remember the picker only renders if the xdan library is present at
`/libraries/jquery-datetimepicker` (see [Installation](../installation/index.md)).
