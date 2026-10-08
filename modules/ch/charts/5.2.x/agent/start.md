# charts — agent start

Library-agnostic charting framework: a Views **Chart** style, a `chart_config` field type +
formatter, and a `chart` render element, all rendered by a pluggable charting-library backend.
The core module ships **no** library — enable a library submodule (charts_highcharts,
charts_chartjs, charts_google, charts_billboard, charts_c3) to get a working chart. Global
defaults live in `charts.settings`; config UI at **Admin → Config → Content authoring → Chart
configuration** (`/admin/config/content/charts`), route `charts.settings`.

- Configure defaults, the Views style, the field formatter, choose library + chart type/colors → [configure/charts.md](configure/charts.md)
- The Chart library & chart-type plugin types — add a backend or chart type → [plugins/charts.md](plugins/charts.md)
- Build charts in code (render element) + alter hooks → [api/charts.md](api/charts.md)
