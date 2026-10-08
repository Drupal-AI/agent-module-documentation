# Time Field — manual setup guide

**Time Field** (`time_field`) adds two field types for storing a plain
time‑of‑day value — without dragging in a full date. Use **Time** (`time`) for a
single moment such as an opening time, or **Time Range** (`time_range`) for a
start/end pair such as a "9:00 am – 5:00 pm" window. Each value is stored as an
integer number of seconds past midnight, which sorts and filters cleanly in Views
and the database.

Both field types come with a matching editing widget built on the browser's
native HTML5 time input, and a formatter that displays the stored time using any
PHP date‑format string — so you can show `9:00 am` (`h:i a`) or `09:00` (`G:i`),
whichever you prefer. The range field's end value is optional, so open‑ended
ranges (a start with no end) are allowed. The widgets can optionally collect
seconds, and a Time field's default value can be set to "the current time." The
module also integrates with the **Token** module (`[time:*]`,
`[time_range:from]`, `[time_range:to]`) and provides a **Feeds** import target,
and it ships a reusable `Time` value object and a `#type => 'time'` form element
for custom code.

There is **no site‑wide settings page** — everything is configured per field
through the normal Field UI. The module depends only on core's **Datetime**
module, which Drupal enables automatically.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent — including the `Time` helper
class, the reusable form element, and storage details — read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

Time Field has no admin page and no permissions of its own. You add and configure
its fields wherever you manage fields — **Structure → [entity type] → Manage
fields** — and tune display through **Manage form display** and **Manage
display** (Field UI must be enabled).

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Go to the **Manage fields** screen of any content type, taxonomy vocabulary,
   user, media type, or other fieldable entity — for example
   **Structure → Content types → Article → Manage fields → Add field**.
3. Choose the field type **Time** (a single time) or **Time Range** (a start/end
   pair). These appear under the "Time" category in the field‑type picker.
4. On the field's **settings**, optionally tick **Current time** (Time fields
   only) to default new content to the moment it is created.
5. On **Manage form display**, the field uses a native time‑input widget. Its
   widget settings let you turn on a **seconds** parameter and set the step (in
   seconds) if you need seconds precision; leave them off for hour/minute only.
6. On **Manage display**, set the formatter's **time format** — a PHP
   date‑format string. Common choices: `h:i a` → `09:30 am`, `G:i` → `9:30`,
   `H:i` → `09:30`. For a Time Range field you can also set the **range format**
   template (default `start ~ end`, which renders as `9:00 am ~ 5:00 pm`).
7. Save, then add or edit content to enter times. Because values are stored as
   seconds past midnight, you can sort and filter on them in Views.

Multi‑value time fields work as usual (raise the field's cardinality), which is
handy for several daily slots on one entity.
