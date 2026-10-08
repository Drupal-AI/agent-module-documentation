Charts Blocks lets you place charts as Drupal blocks — entering the data by hand — so you can add a chart to any region without building a View.

---

Charts Blocks is a submodule of Charts that provides block plugins for standalone charts. The standard **"Charts block"** (`charts_block`) exposes a full chart configuration form plus an AJAX-driven data-collector table where you type category labels and series values, choose the library and chart type, and set colors — the block stores this in its own configuration and renders it through the Charts `chart` render element, so it stays library-agnostic and honors the site's charting-library backend. A second **"Chart (Canvas)"** block (`charts_canvas_block`) is a Drupal Canvas–friendly variant: it deliberately avoids the AJAX data-collector table and instead accepts data as CSV or JSON in a textarea, so it renders reliably inside Canvas' component form and live preview. Both depend on the base `charts` module and require an enabled library submodule to actually draw. Place them via **Block layout** (or Layout Builder / Canvas) like any other block. Because rendering goes through the shared Charts API, blocks reuse the same alter hooks, chart types, color palette, and accessible-table fallback as Views charts and chart fields.

---

- Add a chart to a sidebar or footer region without creating a View.
- Hand-enter a small dataset (labels + values) for a one-off chart.
- Place a chart in a Layout Builder section as a block.
- Embed a chart inside a Drupal Canvas layout with the Canvas-friendly block.
- Paste CSV data into a textarea to render a quick chart (Canvas block).
- Paste JSON data to define a chart's series (Canvas block).
- Build a KPI/summary chart for a landing page.
- Choose the chart type (line, column, pie, donut, …) per block instance.
- Pick a different charting library for a specific block.
- Override series colors for an individual chart block.
- Reuse the same chart in multiple places by configuring a block.
- Show a static illustrative chart that is not driven by site content.
- Add multiple data series to a single block chart via the data-collector table.
- Give editors a point-and-click chart builder without View-building skills.
- Combine a chart block with block visibility conditions (path, role, content type).
- Provide an accessible data-table fallback automatically alongside the block chart.
- Configure axis titles and legend/tooltip options per block.
- Translate or theme the block wrapper like any core block.
- Prototype a dashboard from hand-entered numbers before wiring up real data.
- Render charts in a decoupled/Canvas component preview reliably (Canvas block).
