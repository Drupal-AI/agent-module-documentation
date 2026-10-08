A demo submodule that renders the shared Charts API example set with Apache ECharts on one page.

---

`charts_echarts_api_example` is the Examples-package submodule of `charts_echarts`. Enabling it exposes a single page at `/charts/example/echarts` whose controller (`EchartsApiExample::display()`) calls the shared `charts_api_example.builder` service (`ChartExampleBuilder::build('echarts')`) to render every Charts API demo chart that ECharts supports. It adds no chart logic of its own — it is a reference/preview page that mirrors the Highcharts and Plotly example modules. It depends on `charts`, `charts_echarts`, and `charts:charts_api_example`. Use it to verify your ECharts library is installed and working, and as copy-paste-friendly reference for the Charts render API.

---

- Preview every ECharts-supported chart type (area, bar, column, line, spline, pie, donut, gauge, scatter, bubble, plus combo and stacked variants) on one page.
- Confirm that the ECharts JS library (local or CDN) is correctly installed after setup.
- Use the page as a live smoke test after upgrading `charts` or `charts_echarts`.
- Study `EchartsApiExample::display()` and the `charts_api_example` builder as a template for building charts with the Charts render API in your own code.
- Compare ECharts output against the same examples rendered by the Highcharts/Plotly example modules.
- Demonstrate the ECharts backend to stakeholders without configuring a Views chart first.
- See how a "from CSV file" data source renders through the Charts pipeline with ECharts.
- Reach the demo from the admin/examples menu (link `charts_echarts_api_example.display`, parented to `charts_api_example.display`).
- Disable the submodule in production once evaluation is done (it is a demo, not required for charting).
