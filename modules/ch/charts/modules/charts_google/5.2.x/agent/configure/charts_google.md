# Use the Google Charts library

## Enable & select

```bash
drush en charts_google -y
```

Registers the Chart library plugin `google` (`Google`, `#[Chart(id: "google", name: "Google",
…)]`). Make it the default at **Admin → Config → Content authoring → Chart configuration**
(`/admin/config/content/charts`) by setting the default **library** to Google, or pick
"Google" per View (Chart style), per chart block, or per `chart_config` field. In a render
array set `'#chart_library' => 'google'`.

## Supported chart types

area, bar, boxplot, bubble, candlestick, column, donut, gauge, line, pie, scatter, spline,
plus **table** (a Google visualization this submodule adds via
`charts_google.charts_types.yml`).

## External library (the Google loader)

Google Charts is loaded through Google's **loader.js**:

| Library | Version | Source |
|---|---|---|
| google/charts | 45 | `https://www.gstatic.com/charts/loader.js` |

The `google/charts` Composer package (a drupal-library, declared in the submodule's
`composer.json`) only fetches this small loader script; the actual chart code is streamed from
Google's servers at runtime. So Google Charts is effectively always served remotely — there is
no full local library to host, and it needs network access to gstatic.com. Config schema:
`config/schema/charts_google.schema.yml`. (The nested `charts_google_api_example` submodule is
a demo page — skip it in production.)
