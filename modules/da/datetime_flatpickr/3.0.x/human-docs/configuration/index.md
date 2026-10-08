# Configuration

Flatpickr datetime picker has **no global settings page**. You configure it per
field on the *Manage form display* tab, and each field keeps its own options.

## Open the widget settings

1. Go to **Structure → Content types → *(your type)* → Manage form display**
   (or the equivalent form‑display tab for any entity/bundle).
2. Find your **Date/time** or **Date‑range** field.
3. In the **Widget** column, choose a Flatpickr widget:
   - **Flatpickr** — a Date/time field (single date, optionally with time).
   - **Flatpickr range** — a Date‑range field in a single input.
   - **Flatpickr range (separate inputs)** — a Date‑range field with separate
     start and end inputs.
4. Click the settings cog (⚙) at the end of the row.

Adjust the options below, then click **Update** and **Save**.

## The widget settings

### Date and display format

- **Date format** — the machine format the field works with (PHP date tokens;
  default `Y-m-d H:i`).
- **Alternative input (altInput)** — when on, editors see a friendly, readable
  date while the machine format is still submitted behind the scenes.
- **Alternative format (altFormat)** — the display format shown when *altInput* is
  on (default `F j, Y`, e.g. "August 15, 2026").
- **Use system format** — instead of typing a display format, reuse one of the
  site's Regional‑settings date formats for the alternative display. When ticked,
  pick which **system date format** to use. (Requires *altInput*.)
- **Allow manual input** — let users type directly into the field as well as pick
  from the calendar.

### Time options

- **Enable time** — add a time picker alongside the date.
- **Enable seconds** — include seconds in the time picker.
- **24‑hour time** — show time in 24‑hour format with no AM/PM.
- **Minute increment** — the step for minutes (default 5), e.g. set to 15 for
  quarter‑hour slots.
- **Minimum / maximum time** — restrict the selectable time window (each an hour
  0–23 and minute 0–59).

### Date limits

- **Minimum date / Maximum date** — the earliest and latest selectable dates
  (inclusive). Useful for booking or event fields.
- **Disabled weekdays** — checkboxes to make specific days of the week
  unselectable (for example, disable weekends).
- **Disabled dates** — a list of individual dates to block out (one `YYYY-MM-DD`
  per line), handy for holidays or blackout days.

### Calendar appearance and behavior

- **Position** — where the calendar opens relative to the input: *auto*, *above*,
  or *below*.
- **Week numbers** — show ISO week numbers in the calendar.
- **Inline** — render the calendar always‑visible inline rather than opening it on
  focus.
- **Mode** — selection mode: *single*, *multiple*, or *range*.
- **Jump to date** — the month/date the calendar initially opens on.
- **Default date / default hour / default minute** — pre‑fill the initial value.

## Save

Click **Update** on the widget settings, then **Save** on the Manage form display
page. Open a content edit form for that type to see the flatpickr picker in
action.

## Localization

You don't configure the language — the calendar automatically loads the flatpickr
locale that matches the site's current interface language.
