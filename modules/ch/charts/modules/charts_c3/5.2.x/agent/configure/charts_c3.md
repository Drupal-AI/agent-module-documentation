# Use the C3.js library

## Enable & select

```bash
drush en charts_c3 -y
```

This registers the Chart library plugin `c3` (`C3`, `#[Chart(id: "c3", name: "C3", …)]`). Make
it the default at **Admin → Config → Content authoring → Chart configuration**
(`/admin/config/content/charts`) by setting the default **library** to C3, or pick "C3" per
View (Chart style), per chart block, or per `chart_config` field. In a render array set
`'#chart_library' => 'c3'`.

## Supported chart types

area, bar, bubble, column, donut, gauge, line, pie, scatter, spline.

## External libraries (CDN vs local)

Requires two JS libraries:

| Library | Version | Local path |
|---|---|---|
| C3.js | 0.7.20 | `/libraries/c3` |
| D3 | 7.9.0 | `/libraries/d3` |

- **CDN (default):** with `charts.settings` → `advanced.requirements.cdn: true`, both load
  from their CDNs — no install needed.
- **Local:** disable the CDN option (`/admin/config/content/charts/advanced`) and install the
  libraries. Composer packages (`c3js/c3:0.7.20`, `d3/d3:7.9.0`) are declared in the
  submodule's `composer.json`; or use the npm `libraries:copy` workspace script.

Config schema: `config/schema/charts_c3.schema.yml`. C3.js is the library Billboard.js forked
from, so the two behave similarly.
