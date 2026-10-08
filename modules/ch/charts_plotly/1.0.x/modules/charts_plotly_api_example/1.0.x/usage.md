Charts Plotly API Example is a demo submodule that renders the Charts render-API example gallery with Plotly.js at /charts/example/plotly.

---

This submodule of Charts Plotly exists purely to demonstrate the Charts render API using the Plotly.js backend. Enabling it adds one page, `/charts/example/plotly` (route `charts_plotly_api_example.display`, menu link under the parent Charts API example), whose controller `PlotlyApiExample::display()` calls the shared `charts_api_example.builder` service (`ChartExampleBuilder`) to build the standard library-agnostic example charts for the `plotly` library, then appends Plotly-specific examples: a radar chart (rendered as a polar/scatterpolar plot), a candlestick chart from `[open, high, low, close]` points, a box plot computed from a raw observation series, and a heatmap that aggregates several `chart_data` series into a Z-matrix. All data is hard-coded in the controller. It provides no configuration, permissions, services, or schema of its own and is intended for developers learning the API, not for production.

---

- Enable it to get a working Plotly.js example gallery at `/charts/example/plotly`.
- Study `PlotlyApiExample::display()` as a reference for building charts with the Charts render API and `#chart_library => 'plotly'`.
- See how a radar chart is expressed via the Charts polar example and rendered by Plotly as scatterpolar.
- See the expected candlestick data shape (`[open, high, low, close]` per point) for Plotly.
- See how a box plot is built from raw observation values rather than pre-computed quartiles.
- See how to build a heatmap by supplying multiple `chart_data` series aggregated into rows.
- Copy the render-array patterns (`#type => 'chart'`, `chart_data`, `chart_xaxis`, `chart_yaxis`) into custom code.
- Verify a Plotly.js install is working end-to-end by loading the example page.
- Compare the same example gallery across chart-library backends (each backend ships its own API example submodule).
- Use it as a smoke test after upgrading Charts or Charts Plotly.
- Disable it on production sites once the API patterns are understood (it is an Examples-package demo module).
