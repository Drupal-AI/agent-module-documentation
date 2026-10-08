# Entity Delta Formatter — manual setup guide

**Entity Delta Formatter** (`entity_delta_formatter`) is a field formatter that
displays only the items you choose from a **multi‑value field**, selected by their
position (delta) in the list. Instead of rendering every value, you can show just
the first one, the last one, a specific range, or any combination — useful when a
field holds several values but a given display only needs some of them.

It's configured entirely on a field's **Manage display** screen, where you set the
formatter to **"Rendered entities by delta"** and specify which positions to show.
There's no settings page and nothing global to configure. Rendered values follow
normal field sanitization, and the module has no content or access role of its own.

The selection syntax is flexible:

- **A single item by position** — `1` for the first item, `2` for the second, and so
  on (positions start at 1).
- **From the end** — a negative number counts back from the last item; `-2` is the
  second‑to‑last.
- **A range** — start and end joined by `_`; `1_3` shows the first, second, and third
  items, and `2_-1` shows everything except the first.
- **Combinations** — join selections with commas; `1_3, -1` shows the first, second,
  third, and last items.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** — you set everything up on the field's
**Manage display**, described in "How to use it" below.

## Where it lives in the admin menu

Entity Delta Formatter adds no admin page. You use it from **Structure → (your
entity type) → Manage display**, on a multi‑value field.

## How to use it

1. Go to the **Manage display** tab for the entity/bundle that has the multi‑value
   field (for example an entity reference field).
2. Set that field's format to **"Rendered entities by delta"**.
3. Open the formatter settings (the gear icon) and enter the deltas you want to
   show, using the syntax above — for example `1` for just the first item, or
   `2_-1` for all but the first.
4. Save the display. Only the selected items will render.
