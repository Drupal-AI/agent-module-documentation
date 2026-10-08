# Configuration

Smart Date is configured in two places: on the **field** (its widget and formatter,
per content type) and centrally through reusable **Smart date formats**.

## Add and configure a Smart date field

1. Go to your content type (e.g. *Event*) and open **Manage fields → Add field**.
2. Choose the **Smart date** field type and save. Each value stores a start
   timestamp, an end timestamp, and a duration (plus a timezone, and recurrence
   data when the Recurring submodule is used).

### Choose a widget (Manage form display)

On the content type's **Manage form display**, set the field's widget:

- **Smart date (default)** — the app-like widget where a duration select auto-fills
  the end time and an all-day toggle is available.
- **Smart date (inline)** — a more compact, inline variant.
- **Smart date (timezone)** — adds a per-value timezone selector, for sites that
  show event times in multiple timezones.
- **Smart date (datelist)** — select-list style entry.
- **Smart date only** — date-only range entry (also works on core `daterange`
  fields).

### Choose a formatter (Manage display)

On **Manage display**, set how the value is rendered:

- **Default** — the compact, intelligent range that hides redundant date/year
  parts.
- **Custom** — apply a chosen Smart date format (see below).
- **Plain** — simple, unabbreviated output.
- **Duration** — render the duration (e.g. "2 hours").

With the Recurring submodule enabled you also get recurring-specific formatters.

## Manage reusable Smart date formats

Display styles are stored as **Smart date format** configuration entities so you can
define them once and reuse them everywhere.

1. Go to **Configuration → Regional and language → Smart date formats**
   (`/admin/config/regional/smart-date`). This requires the *Administer site
   configuration* permission.
2. The module ships several formats — **default**, **compact**, **date only**, and
   **time only**. You can edit these or **add your own**.
3. Each format defines the date and time format strings and how a range is joined,
   including options such as:
   - **Date format** — the format string for the date part (e.g. `D, M j`).
   - **Time format** — the format string for the time part (e.g. `g:ia`).
   - **Date first** — whether the date is shown before the time.
   - **Reduce am/pm** — render "5–7pm" instead of "5pm–7pm" when the meridiem
     matches.
   - An **all-day class** for styling all-day output.

Save the format, then reference it from a field's **Custom** formatter on Manage
display. Because formats are exportable configuration, your display setup is
portable between fields, views, and environments.
