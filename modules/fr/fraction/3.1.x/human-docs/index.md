# Fraction — manual setup guide

**Fraction** (`fraction`) provides a field type that stores a decimal as two whole
numbers — a **numerator** and a **denominator** — so the value keeps exact
precision instead of drifting through floating‑point rounding. If you have ever
watched `0.1 + 0.2` turn into `0.30000000000000004`, this module is the answer:
values round‑trip perfectly. It is a popular choice for high‑precision or
multi‑currency **price storage** (up to about 9 decimal places) and for scientific
or engineering quantities.

Under the hood each value is stored as a signed BIGINT numerator and a signed INT
denominator, so it avoids the precision loss of float or fixed‑scale decimal
columns. The module ships two widgets — **Fraction** (separate numerator and
denominator textfields, for exact values like 1/3) and **Decimal** (a single
decimal textfield that is converted to a base‑10 fraction on save, e.g. `13.95` →
`1395/100`) — and three formatters that render the stored value as a **fraction**
(`1/3`), a **decimal** (`0.33333`), or a **percentage** (`33.33333%`). An
"automatic precision" option renders base‑10 or terminating fractions at their
exact length. Views integration lets you sort and filter by the decimal
equivalent, and Feeds and Migrate plugins are included for importing and migrating
data.

Fraction also ships a standalone `\Drupal\fraction\Fraction` PHP value object for
developers — exact fraction arithmetic (add, subtract, multiply, divide), reduce
to lowest terms, convert to/from decimals — all backed by the BCMath extension
when it is available, falling back to native math otherwise. The module depends
only on core's **Field** module, has no submodules, no permissions, and no admin
settings form: you configure everything through the normal Field UI.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent — including the full
`Fraction` class API — read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

There is no dedicated admin page. Fraction adds a field type, widgets, and
formatters that you configure through the standard Field UI on any content type,
taxonomy vocabulary, or other fieldable entity.

## How to use it

1. Go to the entity you want to add the field to — for example **Structure →
   Content types → [your type] → Manage fields** — and click **Add field**.
2. Choose the **Fraction** field type and give it a label.
3. Under **Manage form display**, pick the widget editors will use: **Fraction**
   (numerator + denominator textfields) for exact fractions, or **Decimal** (a
   single decimal textfield, with an optional auto‑precision setting) for prices
   and plain decimals.
4. Under **Manage display**, pick a formatter for the output:
   - **Fraction** — renders `numerator / denominator`, with a configurable
     separator (default `/`).
   - **Decimal** — renders a decimal string at a chosen precision, or automatic
     precision.
   - **Percentage** — same as Decimal but multiplied by 100 with a `%` sign.

Because the field exposes a computed decimal value, min/max range validation is
applied against that decimal, and you can sort and filter Views by it. Developers
can also work with values directly through the `Fraction` class — see the
[`agent/`](../agent/start.md) docs for the API.
