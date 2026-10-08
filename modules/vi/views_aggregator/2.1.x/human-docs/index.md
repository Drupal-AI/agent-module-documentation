# Views Aggregator Plus — manual setup guide

**Views Aggregator Plus** (`views_aggregator`), often shortened to VAgg+, adds a new
Views table style called **"Table with aggregation options"**. Its trick is that it
works on the *rendered* results of a View — after the database query has already run
— which lets it group rows and calculate summaries that plain SQL aggregation
cannot. If you have ever wanted a Views table that groups rows on a shared value and
shows a totals row (sum, average, median, min, max, a tally, and more), this is the
module that does it, entirely through the Views UI.

Because it operates after the query, it can group rows on the identical value of one
column and then apply a summary function to the other columns — for example one row
per industry, with turnover summed per industry. Each field in the View can
independently carry a *group* function (which produces one aggregated row per group)
and/or a *column* function (which produces a totals row shown in the table header,
footer, or caption). Rather than collapsing groups, you can also keep every row and
insert per-group subtotal rows, spreadsheet-style.

It cooperates nicely with computed "Global: Custom text" fields written in Twig
(respecting `number_format` separators), and with Webform submission and Commerce
fields. There is **no admin settings page and no permissions** — everything is
configured per View, right in the style's settings. Other modules can add their own
aggregation functions, and the bundled `views_aggregator_more_functions` submodule
adds three extra ones.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent — including the full function
list and the hook to add your own — read the sibling [`agent/`](../agent/start.md)
docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the module,
   and optionally add the extra-functions submodule.

## Where it lives in the admin menu

Nowhere of its own — there is no configuration page. You use it from inside the
Views UI (**Structure → Views**, `/admin/structure/views`) by choosing its table
style on any View you build.

## How to use it

Configure it per View:

1. Edit a View (`/admin/structure/views/view/YOUR_VIEW`).
2. Under **Format**, set the style to **"Table with aggregation options"**.
3. In the **Advanced** section, set **Use aggregation: No** — VAgg+ does *not*
   combine with Views' own SQL aggregation.
4. Open the style's **Settings**. There you assign functions per field and set the
   table-wide options.

The key choices in the style settings are:

- **Per field** — tick "Apply a group function" and/or "Apply a column function" on
  each field, and choose which function (Sum, Average, Count, Median, Min, Max,
  Tally, Enumerate, Range, Label, Filter rows, Display first, and so on). Functions
  marked with an asterisk accept an optional parameter such as a regular expression,
  a rounding precision, or a separator.
- **Grouping** — exactly one field must be assigned the **"Group and compress"**
  function for group aggregation to work (the one exception is "Filter rows").
  Choose whether to collapse each group into a single row or keep all rows and show
  per-group subtotal rows (with an optional label prefix/suffix and CSS classes).
- **Column totals** — choose where the totals row appears (header, footer, and/or
  caption), whether totals cover the entire result set or only the visible page, a
  default decimal precision, and a CSS class for the totals row.

A tip: aggregation runs on rendered values, so if a result looks wrong, switch the
field's formatter to "Plain text". See the [`agent/`](../agent/start.md) docs for
the complete per-field and table option reference.
