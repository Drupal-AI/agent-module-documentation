# Date Filter — manual setup guide

**Date Filter** (`date_filter`, project name "Views Date Filter") quietly upgrades
the two date filters that Views already ships — the **timestamp** filter (used on
columns like *Authored on* / `created`, `changed`, `login`) and the **Date/time
field** filter — so that exposed date filters render real HTML5 date (and, when you
want it, time) pickers instead of a plain free‑text box. In other words: your
visitors get a proper calendar widget on a "filter by date" form, with no extra
modules and no theming work.

It is genuinely plug‑and‑play. There is **no settings form, no admin page, no
permissions and no Drush command** — the module has exactly one job, which is to
transparently replace the class behind the existing `date` and `datetime` Views
filters with improved versions. Because it reuses the same filter plugin IDs, your
existing views keep working untouched; they just gain the nicer UI the next time
their exposed form renders.

The improved filters do more than swap in a datepicker. The `between` / `not
between` operators get sensible **from / to** labels instead of core's "min / max";
the useless *regular expression* operator is removed; admin defaults written as
relative offsets (like `-1 month`) are shown to visitors as a concrete date; and
date‑only filtering is made to behave intuitively — `=` matches the whole chosen
day, `>=` includes everything from the start of the day, and so on. Timestamp fields
finally behave the same as Date/time fields.

Date Filter supports Drupal 9, 10 and 11 and depends only on core's **Views**.

This guide is written for a **human** setting up a view. If you want the terse,
token‑cheap reference for an AI coding agent — the exact config key it writes, the
query semantics, timezone handling and the plugin‑swap mechanics — read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

Nowhere of its own. Date Filter has no configuration page. You use it inside the
Views UI at **Structure → Views** (`/admin/structure/views`) whenever you add or
edit a date filter on a view.

## How to use it

There is nothing to switch on globally — once the module is enabled, every date
filter in Views is already the improved version. To use it on a view:

1. Go to **Structure → Views** and edit (or create) a view.
2. Under **Filter criteria**, click **Add** and choose a date field — for example
   *Authored on* (`created`), or any Date/time field on your content.
3. In the filter settings you'll see a new **Filter type** choice — **Date** or
   **Date and time** — which replaces core's confusing "A date / An offset" radios.
   Pick *Date and time* if you want visitors to choose a time of day as well as a
   date. (On a date‑only Date/time field this is fixed to *Date*.)
4. Choose an **Operator**. The `between` / `not between` operators are great for a
   date‑range filter and their two inputs are labelled **from** / **to**.
5. Tick **Expose this filter** so visitors can set it themselves, then save the
   view.

On the front end, the exposed filter now renders `<input type="date">` (a native
calendar picker), plus an `<input type="time">` when you chose *Date and time*.
Everything is stored as ordinary Views configuration, so it exports and deploys with
the view like any other filter — no special handling required.

A couple of things worth knowing:

- Enabling the module does **not** rewrite your existing views; already‑saved date
  filters keep working and simply pick up the new UI.
- If another module also replaces the `date` / `datetime` Views filters (for
  example *Views Year Filter*), whichever loads last wins, so the two can conflict.
  The improved date pickers depend on Date Filter's classes being the active ones.

The precise config key Date Filter writes, the whole‑day padding rules and the
timezone behaviour are documented in the [`agent/`](../agent/start.md) reference.
