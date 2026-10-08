# Charts Highcharts Drilldown — manual setup guide

**Charts Highcharts Drilldown** (`charts_highcharts_drilldown`) adds a Views
style that turns your View results into an interactive **drilldown** chart:
visitors see top-level categories, and clicking one expands it into a child
series without leaving the page. It is an extension of the
[Charts](https://www.drupal.org/project/charts) module's Highcharts integration,
so it reuses your existing Charts configuration and theming.

You build the chart entirely from a View. You choose a **series field** (the
parent grouping), a **drilldown field** (the child series revealed on click), a
**data field** (the numeric values), and an **operator** that aggregates those
values by either sum or average across each parent. It is well suited to
hierarchical data — region into country, category into product — where you want a
summary chart people can explore.

The drilldown works with the chart types that support it: **bar**, **column**,
**pie**, and **donut**. The module also wires up the small details for you:
data labels, an accessibility "announce new data" cue when drilling, and the
correct axis/legend handling. It relies on the Highcharts drilldown JavaScript,
which loads from the Highcharts CDN by default, though you can serve it locally
instead (see [Installation](installation/index.md)).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and optionally self-host the drilldown library.

## Where it lives in the admin menu

There is **no module settings page**. All configuration happens inside a View,
under **Structure → Views**, when you set the display's **Format** to the
drilldown chart style.

## How to use it

1. Create a **View** that returns the fields you want to chart: a parent-grouping
   field, a child field, and a numeric value field.
2. Set the View's **Format** to **Chart highcharts drilldown**.
3. In the format settings, pick a **chart type** that supports drilldown — bar,
   column, pie, or donut (other types are rejected).
4. Configure the four drilldown options:
   - **Series Field** — the parent series; values are aggregated at this level.
   - **Drilldown Field** — the child series shown when a parent point is clicked.
   - **Data Field** — the numeric field that gets aggregated.
   - **Operator** — how to aggregate: **sum** (default) or **average**.
5. Save and view the display. Clicking a top-level point drills into its child
   series.

You can combine this with the View's normal filters and contextual filters to
scope the data that feeds the chart.
