# Views Contextual Range Filter — manual setup guide

**Views Contextual Range Filter** (`contextual_range_filter`) lets a View's
contextual filter (argument) match a **range** of values taken from the URL, instead
of only a single exact value. Using a `from--to` syntax, a URL such as
`/products/100--199.99` filters the View to everything priced between 100 and 199.99.
It works for numeric, date, and alphabetic ranges.

The module adds range‑aware versions of core Views' contextual filter handlers. A
range can be closed (`100--199.99`), open‑ended (`100--` for "100 and up", `--149.95`
for "up to 149.95"), a single value, or several ranges OR'd together with `+`
(when "Allow multiple ranges" is on). It ships three argument plugins — numeric,
alphabetic (case‑insensitive, glossary‑aware), and date (understanding both
`YYYY-MM-DD` and relative dates like "10 days ago") — plus a numeric‑range validator
and a PHP‑code argument default that can compute a default range. That PHP default is
what powers "related content" side blocks, such as "similarly priced products" or
"posts published around the same time".

Because Views chooses a filter's handler class before you could pick a range variant,
you don't select "range" directly in the Views UI. Instead you add a **normal**
contextual filter, then convert it to a range filter on the module's settings page.
That conversion both records the choice in the module's configuration and rewrites the
View's argument to the range variant.

This module works with core Views and has no other dependencies.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside Views.

## Where it lives in the admin menu

The conversion page is at **Configuration → Content authoring → Contextual range
filter** (`/admin/config/content/contextual-range-filter`). The filters themselves are
built in the usual Views UI.

## How to use it

### Step 1 — Add a normal contextual filter

In the Views UI, open **Advanced → Contextual filters** and add the field or property
you want to filter on, exactly as you normally would, then save the View.

### Step 2 — Convert it to a range filter

1. Go to **Configuration → Content authoring → Contextual range filter**
   (`/admin/config/content/contextual-range-filter`). This page requires the
   **Administer contextual range filters** permission.
2. The page lists every contextual filter found across all your Views, grouped into
   **date**, **numeric**, and **string** sections.
3. Tick the filters you want to convert to range filters and click **Save
   configuration**. (All caches are cleared, so this can take a moment.)

Saving both records the conversion in the module's settings and rewrites each
affected View's argument to the matching range plugin. Untick a filter later to
convert it back to the core single‑value handler.

### Step 3 — Use the range syntax in URLs

All ranges are inclusive. You can use `:` in place of `--`.

| URL argument | Meaning |
|---|---|
| `100--199.99` | from 100 to 199.99 |
| `100--` | 100 and up |
| `--149.95` | up to 149.95 |
| `100` | a single exact value |
| `k--q` | alphabetic range k…q (case‑insensitive) |
| `2020-01-01--2020-06-30` | a date range |
| `10 days ago--tomorrow` | a relative date range |
| `a--e+k--r` | a–e OR k–r (needs "Allow multiple ranges") |
| `all`, `--`, or `:` | return all results for this filter position |

To show results *outside* a range instead, tick **Exclude** in the contextual
filter's *More* section (this produces a NOT‑BETWEEN style query).

### Related‑content blocks with a PHP default

For a "related content" block, add the module's **PHP code** argument default to the
filter and return a range computed from the current node (for example a price band or
a date window). This feature is gated by a separate permission — see
[Installation](installation/index.md#permissions).
