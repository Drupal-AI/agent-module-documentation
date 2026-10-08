# Other View filter — manual setup guide

**Other View filter** (`other_view_filter`) adds a single new Views filter called
**Other view result**. It lets one view filter its rows against the results of
*another* view — so you can show only the items that appear in the other view, or
(the default) exclude the items the other view already returned. A classic use is
a general "latest content" listing that automatically leaves out anything already
shown in a curated "featured" block.

The module registers one Views filter plugin (`other_views_filter`, extending
core's `InOperator`) and makes it available on the base ID field of every content
entity table, every Search API index, and any other view base table that declares
a base field. You pick one or more `view:display` combinations whose output drives
the filter; at query time the module runs those displays, collects the ID of each
result row, and applies an **IN** or **NOT IN** condition to your current view. The
operator defaults to **not in**, so the "exclude what's already featured" case
works with no extra effort.

There is nothing to configure globally — no settings form, no permissions, no Drush
commands. Everything happens inside the Views UI when you edit a view. The module
depends only on core's **Views** module and has no submodules. One thing to keep in
mind: each referenced display is fully executed on every request, so referencing
several views (or uncached ones) can slow pages down noticeably — keep referenced
views simple and cache aggressively.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

There is no dedicated admin page. Once enabled, the filter shows up inside the
**Views** editor (`/admin/structure/views`) whenever you add a filter criterion to
a view.

## How to use it

1. Edit the view you want to **narrow** at **Structure → Views**.
2. Under **Filter criteria**, click **Add** and choose **Other view result** (it
   appears on the view's base field, e.g. Content).
3. Set the **operator**: *not in* (the default — exclude the other view's rows) or
   *in* (keep only the other view's rows).
4. Under **View: display**, select one or more `view:display` combinations whose
   results should drive the filter.
5. Optionally tick **Inherit contextual filter(s)** to pass the current view's
   arguments into the selected views, so contextual filters carry over.
6. Save the view.

A few behaviours worth knowing: if the referenced views return no rows, a *not in*
filter shows everything (a no‑op) while an *in* filter forces an empty result. The
referenced display's own access checks are respected, so a display a user cannot
see is skipped. And because every referenced display runs on each request, the UI
warns you to keep them simple and well cached.
