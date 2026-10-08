# ApexCharts — manual setup guide

**ApexCharts** (`charts_apexcharts`) is a rendering backend for the **Charts**
module. On its own it does nothing visible — it plugs the ApexCharts JavaScript
library into Charts so that any chart you build (through Views, an entity field,
or the Charts API) can be drawn with ApexCharts. ApexCharts is a modern,
interactive charting library covering a wide range of chart types: area, range
area, bar, box & whisker, bubble, candlestick, column, donut, dumbbell,
gauge/radial bar, heatmap, line, pie, radar, range‑bars, scatter, slope, spline,
and treemap. Combination charts are possible through Views or the Charts API.

The headline reason to reach for it is **licensing**. ApexCharts is **MIT
licensed** and free to use in commercial applications. By contrast, Highcharts —
the library many Drupal sites default to — requires a commercial licence for
anything beyond personal or non‑profit use, and plenty of sites are quietly
non‑compliant simply because a developer picked the default. If you want a
capable, freely licensed chart library, ApexCharts is a strong choice.

Two planning notes that apply to any client‑side chart library: charts render **in
the browser**, so whatever data you plot is present in the page source even if the
chart only shows a summary — aggregate first if the underlying rows are sensitive.
And a chart is effectively **an image to a screen reader** unless you also provide
a data table or text summary carrying the same information.

The one wrinkle is installation: the ApexCharts library comes from **Asset
Packagist**, not the usual Drupal Composer repository, so you need a little
one‑time Composer setup before requiring the module — see
[Installation](installation/index.md).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — set up Asset Packagist, install with
   Composer, enable, and select ApexCharts as your charting library.

There is **no settings form specific to this module**. You simply choose
ApexCharts as the Charts library on the Charts module's own settings page — see
"Where it lives" below.

## Where it lives in the admin menu

Once enabled, select ApexCharts as your default charting library on the Charts
module's settings page at **Configuration → Content authoring → Charts**
(`/admin/config/content/charts`). You then build charts the usual Charts way: a
View with the **Chart** format, a **Chart** field on an entity type, or the Charts
API in code.
