# AP Style formatters & settings

## Two field formatters

| Formatter id | Label | Applies to field types |
|---|---|---|
| `timestamp_ap_style` | AP Style | `datetime`, `timestamp`, `created`, `changed`, `published_at` |
| `daterange_ap_style` | AP Style | `daterange`, `smartdate` |

Assign one on a bundle's **Manage display** page (or in the `entity_view_display` config) by
setting the field component's `type` to the formatter id. Per-instance settings live under the
component's `settings` and default to the global config values.

## Global settings

- Config object: **`date_ap_style.settings`**
- Admin form: `/admin/config/regional/date-ap-style` (route `date_ap_style.settings`)
- Permission: **`administer ap style settings`**

All option keys (defaults shown = shipped install values):

```yaml
always_display_year: false          # show year even for the current year
use_today: false                    # print "today" for the current day
cap_today: false                    # capitalize -> "Today"
display_day: false                  # print weekday name for dates within the current week
display_time: false                 # append the time
hide_date: false                    # show only the time (requires display_time)
time_before_date: false             # AP "TDP": time then date, e.g. "3 p.m. Thursday"
display_noon_and_midnight: false    # "noon"/"midnight" instead of 12 p.m./12 a.m.
capitalize_noon_and_midnight: false # "Noon"/"Midnight"
use_all_day: false                  # midnight (or midnight-to-23:59) ranges read "All Day"
separator: 'to'                     # date-range separator: to | endash | hyphen
timezone: ''                        # timezone override; '' = site/user default
month_only: false                   # show only the month (+ year)
```

`separator` is constrained to `endash` (` – `), `to` (` to `), or `hyphen` (`-`). `timezone`
must be `''` or a valid `\DateTimeZone` identifier (validated by
`date_ap_style_get_timezone_options()`).

## Per-formatter settings

`field.formatter.settings.timestamp_ap_style` and `field.formatter.settings.daterange_ap_style`
carry the same keys (the timestamp formatter has no `separator`), plus a `langcode`. Each
formatter's `defaultSettings()` seeds these from `date_ap_style.settings`, so leaving them
untouched inherits the global defaults; changing them on a view display overrides globally.

## Reading / writing via drush

```bash
drush cget date_ap_style.settings
drush cset date_ap_style.settings separator endash -y
drush cset date_ap_style.settings always_display_year 1 -y
```

## AP formatting rules (applied automatically)

- Months: full name for March–July (`F`), `Sept.` for September, otherwise abbreviated + period
  (`Jan.`, `Feb.`, `Aug.`, `Oct.`, `Nov.`, `Dec.`).
- Year is omitted when it equals the current year (unless `always_display_year`).
- Meridians are lowercased with periods: `a.m.` / `p.m.`; minutes are dropped on the hour.
