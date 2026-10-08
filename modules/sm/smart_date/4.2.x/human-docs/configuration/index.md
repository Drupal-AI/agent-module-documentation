# Configuration

Setting up Smart Date has two parts: **adding a Smart Date field** to a content
type and choosing how it's entered and displayed, and (optionally) **managing the
reusable date formats** that control the compact display. There's no single global
settings form — the work happens on the field's Manage screens and on the Smart
date formats admin page.

## Add a Smart Date field to a content type

1. Log in as an administrator and go to **Structure → Content types**, pick a type
   (for example *Event*), and open its **Manage fields** tab.
2. Click **Create a new field** and choose the **Smart date range** field type.
3. Give it a label (such as "Event date") and save. On the field settings you can
   set the allowed number of values — one for a single date, or several/unlimited
   for a field that holds multiple date ranges.

Under the hood each value stores a start timestamp, an end timestamp, and a
duration (plus recurrence and timezone information when those features are used).

## Choose the editing widget (Manage form display)

On the content type's **Manage form display** tab, pick the widget for your Smart
Date field. The options are:

- **Smart date | Default** — the app-like widget where choosing a duration
  auto-fills the end time and an all-day toggle is available. This is the usual
  choice.
- **Smart date | Inline** — a more compact, inline variant of the same widget.
- **Smart date | Timezone** — adds a per-value timezone selector, for events that
  span or belong to different timezones.
- **Smart date | Datelist** — a classic select-list style of date entry.

## Choose the display formatter (Manage display)

On the **Manage display** tab, pick the formatter that controls how the date
appears on the rendered page:

- **Default** — the compact, intelligent range that hides redundant parts (it drops
  the end date when it matches the start, omits the year for the current year, and
  renders time ranges tightly, e.g. "5–7pm").
- **Custom** — renders using a specific named Smart date format you've chosen (see
  below), so you can control exactly which date/time parts show.
- **Plain** — a simple, unstyled output.
- **Duration** — renders the length of the event (for example "2 hours") rather
  than the start/end times.

## Manage reusable Smart date formats

The compact display is driven by **Smart date format** configuration entities,
which you can reuse across every Smart Date field. Manage them at **Configuration →
Regional and language → Smart date formats** (`/admin/config/regional/smart-date`).
Access requires the **Administer smart date formats** permission, which is
restricted to trusted roles.

The module ships several ready-made formats — **default**, **compact**,
**date only**, and **time only** — and you can add your own. Each format defines:

- the **date format** string used for the start date (for example `D, M j` for
  "Mon, Jan 6"),
- the **time format** string for the time portion (for example `g:ia` for "5pm"),
- whether the **date comes first**, and how the two ends of a range are joined,
- an **AM/PM reduction** option that collapses "5pm–7pm" down to "5–7pm" when both
  ends share the same meridiem.

Because formats are exportable configuration, you can build them once and deploy
them between environments. Reference a format from the **Custom** formatter on any
Smart Date field.

## Save

Save each Manage screen and each format as you edit it. Field and formatter changes
take effect immediately — view a piece of content with the field to see the compact
date rendering.
