# Configuration

TARDIS is configured per view, not from a central settings page. You pick the
TARDIS style on a view, adjust a handful of options, and then build the pages its
links point to.

## Select the TARDIS style on a view

1. Create or edit a view of the content you want to archive (typically nodes with
   a date).
2. In the view's **Format** section, set **Style** to **TARDIS**.
3. Give the view a **date field or sort** and enough rows to cover the span of
   time you want linked — TARDIS builds its year/month list from the dates in the
   view's results.

The view now renders as a reverse-chronological list of year links, each
expandable to months, instead of a table or list.

## Style options

Open the TARDIS style settings (the gear/settings link next to the style) to
adjust these:

| Option | Default | What it does |
|--------|---------|--------------|
| **Path** (`path`) | `tardis` | The path prefix for each generated link, so a month link looks like `example.com/tardis/1963/11`. Change it to something meaningful for your site, e.g. `archive`, giving links like `/archive/2024/03`. |
| **Month date format** (`month_date_format`) | `m` | A PHP `date()` format string used for the month label. The default `m` shows a two-digit month number; use `F` for the full month name, `M` for the abbreviated name, and so on. |
| **Nesting** (`nesting`) | off | Whether month links are nested inside their year link. Turn it on for a year heading that expands to reveal its months. |

## Wiring up the link targets

This is the important part: TARDIS only *emits* the links — it does not create the
pages they lead to. Each link has the form `/{path}/{year}/{month}`, so you need a
destination that understands those year and month segments.

The usual approach is to build a **second view** with **contextual filters
(arguments)** on your content's created/date field — one argument resolving the
year, then one resolving the month — and give it a path matching your prefix (for
example `tardis/%/%`). When a visitor clicks a month in the TARDIS archive, that
view receives the year and month and shows the matching content.

## Theming

TARDIS renders through the `views_view_tardis` theme hook, with templates in the
module's `templates/` directory and preprocessing in `tardis.theme.inc`. If you
want to change the markup of the year/month list, override that template in your
theme.
