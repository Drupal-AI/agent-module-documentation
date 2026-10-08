# Views Natural Sort — manual setup guide

**Views Natural Sort** (`views_natural_sort`) adds a "natural" sort option to Views
that orders string values — most commonly node titles — the way a human would,
rather than the way a database sorts raw text. It ignores leading articles like
"The" and "A" (so *The Hobbit* files near H, not T), strips configured filler words
and symbols, and sorts embedded numbers numerically so *Item 2* comes before
*Item 10* instead of after it.

Under the hood it keeps a precomputed index of transformed, sortable strings that's
updated whenever content is saved, and it upgrades the standard Views sort on
eligible string properties so you get extra **Sort ascending/descending naturally**
options in the Views UI. Choosing one makes the View order by the transformed value
instead of the raw text. Out of the box it targets node titles, but it works for
any integer-id entity's string properties that Views exposes as a sort, and it can
be extended in code to cover custom fields.

There's a small **settings page** (under the Views settings) where you control
which beginning words, filler words, and symbols get stripped, whether day-of-week
sorting is on, and the reindex batch size — plus a **Rebuild Index** button for
re-processing existing content. It depends only on core's **Views** module, has no
permissions of its own beyond the standard *Administer views*, and provides no Drush
commands.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.
2. [Configuration](configuration/index.md) — the settings form (which
   words/symbols to strip, day-of-week, batch size) and rebuilding the index.

## Where it lives in the admin menu

The natural-sort settings form is a tab under the Views settings, at
**Structure → Views → Settings → Natural Sort**
(`/admin/structure/views/settings/views_natural_sort`), gated by the **Administer
views** permission. The sort itself is used inside individual Views.

## How to use it

The main "usage" is choosing the natural sort inside a View:

1. Enable the module (see [Installation](installation/index.md)). It reindexes your
   content so existing titles get their sortable form.
2. Edit a View and add (or edit) a sort criterion on a string property — e.g. the
   node **Title**.
3. In the order options, pick **Sort ascending naturally** or **Sort descending
   naturally** (rather than the plain ascending/descending). Save the View.
4. The View now orders by the transformed value — articles ignored, numbers sorted
   numerically.

If content predates the module, or you change what's stripped, **rebuild the
index** so the stored sortable values reflect the current settings (see
[Configuration](configuration/index.md)). For custom string fields, developers can
widen what's sortable with `hook_views_natural_sort_supported_properties_alter()`
— see the agent docs ([`agent/hooks/hooks.md`](../agent/hooks/hooks.md)).
