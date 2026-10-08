# Human Decimal Formatter — manual setup guide

**Human Decimal Formatter** (`human_decimal`) is a tiny field formatter for core
**decimal** fields that drops insignificant trailing zeros when it displays a
value. So `3.00` renders as "3", `3.50` renders as "3.5", and `3.23` still renders
in full as "3.23". You get clean, human‑friendly numbers without losing precision
when the value genuinely has decimals.

It's ideal anywhere trailing zeros look unnatural — prices without cents,
quantities, ratings and scores, measurements, percentages, or tax and discount
rates. The formatter still uses the same decimal and thousand separator settings as
core's Decimal formatter, so locale‑aware formatting is preserved; it just trims
the zeros.

This is about as simple as a module gets: it adds one formatter and nothing else.
There is no settings page, no permissions, no services, and no configuration of its
own — you simply choose "Human decimal" as the display format for a decimal field.
It depends only on core's **Field** module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

Nowhere of its own — the module has no admin page. Its one effect is a new display
format option, **Human decimal**, that appears for decimal fields on the *Manage
display* tab.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Go to the entity/bundle that has a decimal field — for example **Structure →
   Content types → Product → Manage display** (or the *Manage display* tab of any
   entity with a decimal field).
3. Find your decimal field and, in the **Format** column, choose **Human decimal**.
4. Optionally click the gear to confirm the decimal and thousand separators (these
   are inherited from core's Decimal formatter), then **Save**.

You can apply it per view mode (for instance trim zeros in the teaser but not the
full view), and it works on multi‑value decimal fields, formatting each value
independently.
