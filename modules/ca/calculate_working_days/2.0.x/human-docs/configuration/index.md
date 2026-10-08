# Configuration

## Fix the access control first

Before anything else, be aware that this version registers the settings form
with only the **access content** permission — which anonymous visitors have by
default. As shipped, **any visitor can open the form and overwrite your
weekend/holiday calendar**, corrupting every working-day and deadline
calculation that depends on it.

Re-gate the route (`/admin/config/regional/calculate-working-days`) to require
**Administer site configuration**, or a dedicated admin permission, before you
rely on the module. Until you do, do not treat the calendar values as trusted.

## Open the settings form

1. Log in as a user allowed to reach the form (after the fix above, a user with
   **Administer site configuration**).
2. Go to **Configuration → Regional and language → Calculate Working Days**, or
   navigate directly to `/admin/config/regional/calculate-working-days`.

The values are saved to the `calculate_working_days.settings` config object.

## What you configure

- **Free weekdays** — tick which days of the week never count as working days
  (typically Saturday and Sunday).
- **Recurring holidays** — annual holidays that repeat every year, entered in
  `DD-MM` format (for example `03-12` for the 3rd of December).
- **Single-year holidays** — one-off holidays tied to a specific year, entered
  in `DD-MM-YYYY` format (for example `03-12-2014`).
- **Occasion days** — named free days (for example "last Monday of April").
- A **datepicker** lets you preview which days are treated as free.

Click **Save configuration** to store the calendar.

## Using the calendar from code

Once configured, the calendar drives the module's helper functions — for
example `calculate_working_days_get_work_days($startTimestamp, $endTimestamp)`
to count working days between two dates, its monthly variants, and the
`CalculateWorkingDays` value object. See the agent API notes at
[`agent/api/functions.md`](../../agent/api/functions.md) for the full list of
functions and their signatures.

> **Note on accuracy:** the calculation steps day-by-day by adding 86,400
> seconds at a time, so ranges that cross a daylight-saving-time boundary can
> drift by an hour at the edges.
