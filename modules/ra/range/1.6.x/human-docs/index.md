# Numeric Range — manual setup guide

**Numeric Range** (`range`) adds field types that store a **FROM** number and a
**TO** number together in a single field. Instead of creating two separate number
fields and wiring them together yourself, you add one Range field and it holds
things like a price range ("$80 – $220"), a target age ("6–12 years"), a salary
band, an opening‑hours span, or a temperature range — a pair of numbers that
belong together as one value.

The module gives you three flavours, mirroring core's Number field: **Range
(integer)** for whole numbers, **Range (decimal)** for fixed‑precision numbers
like money, and **Range (float)** for approximate values. Each field uses a
two‑input widget (a "From" box and a "To" box) on the edit form, and it enforces
two rules automatically: both ends must be filled in, and the FROM value can't be
greater than the TO value — so you never end up with a half‑filled or
back‑to‑front range.

On display you get five formatters and a lot of control over presentation. You
can set a separator between the two numbers (a hyphen, an en‑dash, the word "to"),
add prefixes and suffixes (render `$10 – $50 per night` with no template edits),
and collapse a range down to a single value when both ends are equal. There are
also Views handlers: a **range filter** and a **range argument** that answer the
unusual question "does this stored range *contain* the number X?" — perfect for a
"price I can afford" exposed filter.

Numeric Range has **no settings page of its own** — everything is configured on
the field itself, the same way you configure any Drupal field. That's why this
guide has no separate configuration page; the "How to use it" section below
covers it.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

Numeric Range adds **no admin page**. Its field types appear wherever you add
fields — for example **Structure → Content types → *your type* → Manage fields →
Add field**, and then on the same content type's **Manage form display** (for the
widget) and **Manage display** (for the formatter) tabs.

## How to use it

Because everything is per‑field, here's the whole workflow:

### 1. Add a Range field

On any fieldable entity (content type, taxonomy term, media, user, paragraph…),
go to **Manage fields → Add field** and choose one of:

- **Range (integer)** — whole numbers.
- **Range (decimal)** — fixed decimal places, ideal for money (you set
  *precision* and *scale*).
- **Range (float)** — floating‑point numbers.

### 2. Field settings

On the field settings you can set an optional **minimum** and **maximum** to bound
what editors may enter (for example 0–100 for a percentage range), and four
independent **prefix/suffix** pairs:

- **Field** — wraps the whole rendered range (e.g. suffix ` per night`).
- **From** — wraps just the FROM number (e.g. prefix `$`).
- **To** — wraps just the TO number.
- **Combined** — used when the range collapses to a single value.

These are stored on the field but only appear on display if the formatter is told
to show them (see below).

### 3. The edit widget

On **Manage form display**, the field uses the **Range** widget — two number
boxes side by side. In its settings you can relabel the boxes (for example
"Shortest" / "Longest" instead of "From" / "to") and add placeholder hints.

### 4. Choose a display formatter

On **Manage display**, pick one of the five formatters:

- **Default** — formats each number normally, with a thousands separator (and, for
  decimals, a decimal separator and scale).
- **Formatted string** — runs each number through a PHP `sprintf` pattern, so you
  can render `007–042` with `%03d`.
- **Unformatted** — prints the raw numbers, handy for machine‑readable output.

Every formatter shares these options: a **separator** placed between the two
numbers; a **combine** toggle that shows just one value when FROM equals TO; and
four checkboxes deciding which of the prefix/suffix pairs above are actually
displayed.

### 5. Reading and writing values in code

There's no single `value` — a range item has a `from` and a `to`:

```php
$node->field_price = ['from' => 80, 'to' => 220];
$from = $node->field_price->from;
$to   = $node->field_price->to;
```

### 6. Filtering in Views

Each Range field automatically offers a **range filter** and a **range argument**
in Views, both using "contains / does not contain" logic — so you can list every
product whose stored price range contains a visitor‑supplied number, or use a URL
argument like `/products/150` to list everything whose range covers 150.
