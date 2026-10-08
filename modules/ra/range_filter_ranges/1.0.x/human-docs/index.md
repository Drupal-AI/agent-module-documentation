# Range Filter Ranges — manual setup guide

**Range Filter Ranges** (`range_filter_ranges`) adds a Views filter for numeric
**range** fields — the `range_integer` field provided by the
[Range](https://www.drupal.org/project/range) module. It lets you filter a View by
**predefined ranges (buckets)** rather than exact numbers.

Here's the distinction. The Range module's own filter lets a visitor search for a
single number *inside* the stored ranges. This module's filter instead gives you a
**min and a max**, and returns the rows whose stored range *overlaps* the range
you defined — so you can offer bucketed choices like "£0–50", "£50–100",
"£100–200" and match any item whose own range crosses into the selected bucket.

It's a display-and-filtering feature only: results still respect the View's own
access rules, and the module has no access-control role of its own. It depends on
core Views (and, to have `range_integer` fields to filter, the contributed Range
module).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no separate configuration page** — you set everything up inside the
Views UI, on the filter itself, as described below.

## How to use it

1. Make sure you have a **Range** (`range_integer`) field on the entity your View
   lists.
2. Edit your View (**Structure → Views**), and under **Filter criteria** click
   **Add**.
3. Choose the range filter this module provides for your `range_integer` field.
4. Configure the filter's **min** and **max** to define the bucket you want to
   match against — the View returns rows whose stored range overlaps it. Expose
   the filter if you want visitors to pick a bucket themselves.
5. Save the View.
