# HMS Field — manual setup guide

**HMS Field** (`hms_field`) gives you a **duration** field. Behind the scenes it stores a
single number — an integer count of seconds — but editors enter and read it in friendly
Hours:Minutes:Seconds form (and week/day/hour/minute/second variants). So an editor can type
`1:30:00`, `90m`, or `1h 30m` and it's saved as `5400` seconds. Because the stored value is a
plain integer, durations sort, aggregate, and range‑filter correctly in Views and entity
queries — something you don't get if you store durations as text.

It's a natural fit for video or audio length, reading/estimated time, task estimates,
timesheet or work‑log entries, session lengths, and similar. The input parser is forgiving:
it accepts `h:mm:ss`, `hh:mm`, `m:ss`, single‑unit values like `h`/`m`/`s`, and
space‑separated forms like `3h 15m 30s` (including `w` for weeks and `d` for days). The column
is signed, so negative durations (time deltas/adjustments) work too.

For display you get two formatters. The **default** formatter shows a compact `h:mm` /
`hh:mm:ss` style value, with optional leading zeros. The **natural‑language** formatter renders
the duration in words — "2 hours, 15 minutes and 30 seconds" — and lets you choose which unit
fragments to show and the separators between them. There's also a neat **running‑timer** mode:
fed a "running since" timestamp, the default display ticks up live in the browser as a
stopwatch/elapsed counter (though wiring that up needs a custom formatter/render array — see
below).

There is no global settings page and no permissions — everything is configured per field on
**Manage form display** (the widget) and **Manage display** (the formatters). It depends only
on core's **Field** module and ships no submodules. For developers it also exposes an
`hms_field.hms` conversion service, a reusable `hms` form element, and two alter hooks for
adding formats or units.

This guide is written for a **human** clicking through the admin UI. If you want terse,
token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and enable it.

## Where it lives in the admin menu

HMS Field has no admin page of its own. You add and configure an HMS field on a fieldable
bundle — for content types that's **Structure → Content types → [type] → Manage fields /
Manage form display / Manage display**.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. **Add the field.** On a content type (or any fieldable entity), add a field of type **HMS**.
3. **Configure the input widget** (on **Manage form display**). The HMS widget lets you choose:
   - **Format** — the input/parse format editors use (`h:mm`, `hh:mm:ss`, `h:mm:ss`, `m:ss`,
     single units `h`/`m`/`s`, or the space‑separated `hms` style). Whatever the editor types is
     validated and converted to seconds on save.
   - **Placeholder** — by default the format string itself is shown as the placeholder; you can
     supply a custom one instead.
4. **Configure the display** (on **Manage display**). Choose one of the two formatters:
   - **Default (HMS) formatter** — pick a display **format** and whether to **zero‑pad**
     fragments (`01:05` vs `1:5`).
   - **Natural language formatter** — tick which unit fragments to show
     (weeks/days/hours/minutes/seconds), and set the **separator** (default `", "`) and the
     **last separator** (default `" and "`). Only non‑zero fragments are printed, each correctly
     pluralised — e.g. "1 hour, 5 minutes and 30 seconds".
5. Save the display.

### The live running‑timer

The stopwatch/elapsed‑counter behavior is available through the `hms` theme hook but is not
exposed as a checkbox on the stock formatter. To build a live ticking timer, supply a
`running_since` timestamp from a custom formatter or render array (`['#theme' => 'hms',
'#value' => …, '#running_since' => …]`); the module then attaches the JavaScript and the browser
counts the value up in real time. This is a developer step — see the sibling
[`agent/api/service.md`](../agent/api/service.md) for the render‑element details.
