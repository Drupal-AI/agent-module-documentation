# Use the Billboard.js library

## Enable & select

```bash
drush en charts_billboard -y
```

This registers the Chart library plugin `billboard` (`Billboard`, `#[Chart(id: "billboard",
name: "Billboard.js", …)]`). Make it the default at **Admin → Config → Content authoring →
Chart configuration** (`/admin/config/content/charts`) by setting the default **library** to
Billboard.js, or pick "Billboard.js" per View (Chart style), per chart block, or per
`chart_config` field. In a render array set `'#chart_library' => 'billboard'`.

## Supported chart types

area, arearange, bar, bubble, candlestick, column, donut, gauge, line, pie, scatter, spline.

## External libraries (CDN vs local)

Requires two JS libraries (defined in `charts_billboard.libraries.yml`):

| Library | Version | License | Local path |
|---|---|---|---|
| Billboard.js | 3.10.3 | MIT | `/libraries/billboard` |
| D3 | 7.9.0 | BSD | `/libraries/d3` |

- **CDN (default):** with `charts.settings` → `advanced.requirements.cdn: true`, both load
  from their CDNs — no install needed.
- **Local:** disable the CDN option (`/admin/config/content/charts/advanced`) and install the
  libraries. Composer repos/packages (`billboardjs/billboard:3.10.3`, `d3/d3:7.9.0`) are
  declared in the submodule's `composer.json`; or use the npm `libraries:copy` workspace
  script from the Charts README.

Config schema: `config/schema/charts_billboard.schema.yml`. (The nested
`charts_billboard_api_example` submodule only provides a demo page — skip it in production.)
