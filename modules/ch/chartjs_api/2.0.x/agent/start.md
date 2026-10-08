# ChartJS API — agent index

Developer API only: a `chartjs_api` render element that renders a Chart.js chart (plus a custom
`halfdonut` type). No config UI, no permissions, no dependencies, no config schema.

- **The render element: properties, `drupalSettings`, libraries, halfdonut, custom plugins** →
  [api/element.md](api/element.md)

Key facts:
- Element: `src/Element/ChartjsApiTheming.php` (`@RenderElement("chartjs_api")`).
- Chart.js 4.4.1 loads from Cloudflare CDN (`chartjs_api.libraries.yml` → `chartjs` library).
- Template `templates/chartjs-api.html.twig` outputs `<canvas id="{id}" data-graph-type="{graph_type}">`.
- Data flows: render array `#data/#options/#plugins` → `drupalSettings.chartjs[<id>]` → `js/chartjs.js`.
