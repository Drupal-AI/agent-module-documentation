# Configuration

Charts is configured in two layers: a **global settings form** that sets
site‑wide defaults, and **per‑chart settings** on each View, block, or field that
can override those defaults.

## Global settings

Go to **Configuration → Content authoring → Chart configuration**
(`/admin/config/content/charts`). This form requires the core **Administer site
configuration** permission, and every value is stored as exportable
configuration. There is also an **Advanced** tab
(`/admin/config/content/charts/advanced`) for the CDN and debug options.

### Library and type

- **Default library** — which charting library every chart uses unless overridden
  (for example Highcharts, Chart.js, Google Charts, Billboard, or C3). This only
  offers libraries whose submodule you have enabled. Leaving it at the site
  default resolves to the installed default library.
- **Default chart type** — the chart type new charts start with (default
  **line**). Available types include line, column, bar, pie, donut, area, spline,
  scatter, bubble, gauge, and others depending on the library.

### Display

- **Colors** — an ordered palette of series colors (25 by default). The first
  series uses the first color, the second series the second, and so on, giving
  every chart on the site a consistent look.
- **Title** and **Subtitle** — default chart headings.
- **Legend** and **Legend position** — whether to show a legend (off by default)
  and where to place it (right by default).
- **Tooltips** — show a tooltip on hover (on by default).
- **Data labels** and **Data markers** — show value labels on points, and point
  markers (both off by default).
- **Three‑dimensional** and **Polar** — 3D or polar rendering where the chosen
  library supports it.
- **Dimensions** — default chart width and height, each expressible as a
  percentage or in pixels.
- **Gauge** — the minimum, maximum, and colored threshold bands (green/yellow/red)
  used by gauge charts.

### Axes

- **X‑axis title** and **Y‑axis title, min, max, prefix, suffix, and decimal
  count** — default axis labelling and scaling.

### Advanced tab

- **Load library from a CDN** *(on by default)* — serve the charting library's
  JavaScript from a content delivery network. Turn it off to require a locally
  installed copy in `/libraries`.
- **Debug** — extra debug output when troubleshooting.

## Per‑View chart settings (the Views "Chart" style)

To chart a View, edit the View and set its **Format** to **Chart**. The style's
settings let you choose, for this View only: the library, the chart type, which
field supplies the labels versus the data series, the colors, and the axis
titles — each overriding the global defaults above. You can also expose a
chart‑type selector so visitors pick the chart type themselves.

## Chart data on entities (the `chart_config` field)

Add a field of type **Chart** (`chart_config`) to a content type to let editors
store chart data directly on content. Its widget provides an AJAX data‑entry
table plus a per‑item choice of library and chart type; the matching formatter
renders the stored data as a chart on display.

## Permissions

Charts defines permissions under **People → Permissions** that govern who may
administer chart settings and use chart features. Grant them to the roles that
need to manage or build charts.
