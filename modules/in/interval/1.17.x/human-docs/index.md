# Interval Field — manual setup guide

**Interval Field** (`interval`) adds a new field type for storing a length of time as
a **number plus a period** — "3 days", "2 weeks", "1 quarter", and so on. Instead of
juggling a separate number field and a period dropdown, or hard-coding durations in
custom code, editors enter both parts in one tidy widget: a number box next to a
period select.

Under the hood the field stores two values — the count and the period's machine name
— and it knows how to *apply* that span to a date. So a "warranty period" of "1 year"
can be added to a purchase date, a "reminder lead time" of "3 days" can be subtracted
from an event date, and a "trial length" of "2 weeks" can drive a scheduled job — all
from a single reusable field.

The list of available periods isn't fixed. Interval ships nine (second, minute, hour,
day, week, fortnight, month, quarter, year), and any module can add more — a "decade"
or a "sprint" — by shipping a small YAML file, so developers can extend it without
patching the module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

Interval Field has **no settings page of its own** and no permissions. Like any field
type, you use it from an entity's field configuration — **Structure → Content types →
*(a type)* → Manage fields**, then **Manage form display** and **Manage display** for
the widget and formatter.

## How to use it

### Add an interval field

1. Go to **Structure → Content types → *(a type)* → Manage fields → Add field** (or
   the equivalent for another entity type — interval fields work on users, media,
   taxonomy terms, and more, not just nodes).
2. Choose the **Interval** field type and give it a label such as "Duration".
3. Save through the field settings.

### Choose which periods editors can pick

On **Manage form display**, the field uses the **Interval and Period** widget
(`interval_default`), which shows a number input beside a period dropdown. Open the
widget's settings (the gear icon) to set **Allowed periods**:

- Leave everything unticked to offer **all** periods.
- Tick just the ones you want — for example only *Days*, *Weeks*, and *Months* — to
  hide seconds, minutes, and hours from the dropdown.

### Display the value

On **Manage display**, pick one of three formatters:

- **Plain** (`interval_default`) — friendly text such as "3 Weeks" (with correct
  singular/plural and translation).
- **PHP date/time** (`interval_php`) — a machine-friendly string such as "21 days"
  (the count multiplied out into a base unit), useful for downstream scripting.
- **Raw value** (`interval_raw`) — the same label text emitted as plain markup.

### For developers

The stored span can be applied to a PHP `\DateTime` with the field item's
`applyInterval()` method, and you can add your own periods by shipping a
`mymodule.intervals.yml` file (or adjust the built-in ones with
`hook_intervals_alter()`). See the [`agent/`](../agent/start.md) docs for the exact
API and plugin format.
