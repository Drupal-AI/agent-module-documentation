# Hours, Minutes and Seconds Field — manual setup guide

**Hours, Minutes and Seconds Field** (`hours_minutes_seconds`) adds a Drupal
field type for storing a **duration** — a length of time such as a video's
runtime, a task estimate, a lap time, a cooking time, or an SLA window. Editors
type a friendly value like `2:30:45`, but under the hood the field stores a
single whole number of seconds (`9045` in that example), so the data is exact
and easy to sort, filter and migrate. Negative durations are supported too, for
things like schedule variance.

The real strength is in how the value is displayed. The module ships four
display formatters you can pick per field: a plain formatted duration (with an
optional live count-up timer that ticks every second), a live **countdown** to
zero with an optional "finished" message, a **natural-language** rendering like
"2 hours, 30 minutes and 45 seconds", and an **ISO 8601** rendering like
`PT2H30M45S` that can be wrapped in a `<time>` element for machine readers and
SEO. You can also set a minimum and maximum allowed duration per field.

This is a fields module, so there is no central settings page. You add and
configure it exactly like any other field, on a per-content-type basis through
Drupal's usual **Manage fields / Manage form display / Manage display** screens.
For developers, the module also exposes a conversion service, a reusable form
element, a Views field handler, and two alter hooks for adding custom time units
or format strings — those are covered in the [`agent/`](../agent/start.md) docs.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

Nowhere of its own — this module has no dedicated settings page and no
permissions (access is governed by ordinary field and entity permissions). You
work with it through the field UI on each content type.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. On a content type, go to **Manage fields → Add field** and choose the **Hours,
   Minutes and Seconds** field type. Give it a label such as "Duration".
3. In the field settings you can optionally set a **minimum** and **maximum**
   allowed duration (entered in seconds); leave them blank for no limit.
4. On **Manage form display**, the field uses a text widget. You can choose the
   **input format** editors type — for example `h:mm`, `h:mm:ss`, `hh:mm:ss`,
   `m:ss`, `mm:ss`, `d:h:mm:ss`, or a single unit like `h`, `m` or `s` — set a
   placeholder, and optionally show a hint of the raw stored seconds under the
   field.
5. On **Manage display**, pick one of the four formatters:
   - **Default** — a formatted duration, optionally with a live count-up timer.
   - **Countdown** — a live countdown to zero, with optional finished text.
   - **Natural language** — "1 hour and 5 minutes", with configurable separators.
   - **ISO 8601 duration** — `PT2H30M45S`, optionally wrapped in a `<time>`
     element with a human-readable tooltip.

Because the format is only a display/entry choice, you can switch it later
without touching the stored data. The live timer and countdown formatters keep
accurate time even on cached pages.
