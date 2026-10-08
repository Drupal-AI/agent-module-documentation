<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
ApexCharts adds the ApexCharts JavaScript library as a rendering option for the Charts module.

---

The Charts module is an abstraction: a View or a render array describes what to plot, and a library plugin decides how it is drawn, which makes the choice of charting library a configuration decision rather than a rewrite. This module registers ApexCharts as one of those libraries alongside Highcharts, Chart.js, Billboard, ECharts, Plotly and the rest, and it is worth having on the list for a licensing reason: Highcharts requires a commercial licence for anything beyond personal or non-profit use, whereas **ApexCharts is MIT** and free in commercial projects. It supports area, range-area, bar, column, box-and-whisker, bubble, candlestick, donut, dumbbell, gauge/radial-bar, heatmap, line, pie, radar, range-bar, scatter, slope, spline and treemap charts. **Installation needs asset-packagist**, because ApexCharts is distributed through npm and the module requires `npm-asset/apexcharts`, which is not on packages.drupal.org — add `https://asset-packagist.org` to the `repositories` section of `composer.json`, install `oomphinc/composer-installers-extender`, and set `extra.installer-paths` so libraries land in `/libraries`; then `composer require drupal/charts_apexcharts` installs the JS into `web/libraries/apexcharts`. Without the local library the module can fall back to the jsDelivr CDN if you enable the CDN option under Charts' Advanced settings, but a local install is recommended and the status report will tell you which state you are in. After enabling, set ApexCharts as the default library at `/admin/config/content/charts` (or force it per chart with `#chart_library => 'apexcharts'`), then build charts through a View's "Chart" format, a chart field, or the Charts API. Two things worth planning with any charting library: charts render **client-side**, so whatever is plotted is present in the page source regardless of what the chart displays — aggregate before sending if the underlying rows are sensitive; and a chart is an image to a screen reader unless a data table or text summary conveys the same information.

---

- Render Drupal charts with the ApexCharts library.
- Choose a charting library by configuration instead of code.
- Use an MIT-licensed chart library and avoid Highcharts licensing obligations.
- Set ApexCharts as the site-wide default charting library.
- Force ApexCharts for a single chart with `#chart_library`.
- Plot data from a View using the "Chart" display format.
- Add a chart field to an entity type and render it with ApexCharts.
- Build a chart programmatically through the Charts API.
- Install the ApexCharts library via Composer and asset-packagist.
- Diagnose a missing `npm-asset/apexcharts` package error.
- Recognise a repository gap rather than a dead module.
- Load the library from a CDN when a local install is not possible.
- Check the status report to confirm the library is installed.
- Render area, bar, column, line, spline, pie, donut and radar charts.
- Render candlestick, box-and-whisker, range-area and range-bar charts.
- Render heatmap, treemap, bubble, scatter and gauge charts.
- Enable dark mode or a sparkline presentation for a chart.
- Enable stacked-bar totals or a dumbbell/slope presentation.
- Pass raw ApexCharts options through `#raw_options` for full control.
- Aggregate data before sending it to the client to avoid exposing raw rows.
- Provide a data table alongside a chart for accessibility.
- Switch charting libraries without changing the underlying View.
- Compare chart libraries when planning a project.
- Explore the bundled API example page for working code samples.
