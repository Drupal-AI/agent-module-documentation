<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views field & filter handlers

Eight plugin classes under `src/Plugin/views/`, registered by `hook_views_data()` in `charts_exposed_settings.module`. Each of the four logical inputs (title, subtitle, x-axis title, y-axis title) is exposed as BOTH a Views field and a Views filter, sharing one handler id.

## Registration (`hook_views_data`)
Defines a virtual global table `charts_exposed_settings` with join `#global => []` (available on every View), group "Global". Each row registers both a `field.id` and a `filter.id` pointing at the same handler id:

- `field_exposed_title` — "Exposed Chart Title"
- `field_exposed_subtitle` — "Exposed Chart Subtitle"
- `field_exposed_yaxis_title` — "Exposed Y-Axis Title"
- `field_exposed_xaxis_title` — "Exposed X-Axis Title"

## Field plugins (`Plugin/views/field/*`)
`ExposedTitle`, `ExposedSubtitle`, `ExposedXAxisTitle`, `ExposedYAxisTitle` extend `FieldPluginBase`, annotated `@ViewsField("field_exposed_*")`. Behavior (all four identical apart from the option key and labels):
- `query()` and `getValue()` are empty — the handler adds nothing to the SQL query and produces no row output.
- `canExpose()` and `isExposed()` both return `TRUE`.
- `buildExposedForm()` adds one `#type => textfield` element keyed by the param name (`chart_title` / `chart_subtitle` / `x_axis_title` / `y_axis_title`) with a title and description; `#default_value => ''`.
- `defineOptions()` adds the param key with `['default' => '']`.
- `buildOptionsForm()` just calls the parent.

## Filter plugins (`Plugin/views/filter/*`)
Same four names extend `InOperator`, annotated `@ViewsFilter("field_exposed_*")`. Differences from the field variants:
- `defineOptions()` also sets `exposed => ['default' => TRUE]`.
- `buildOptionsForm()` hides the operator and value sub-forms (`#access = FALSE`) and sets `expose/identifier/#default_value` to the param name — so the exposed identifier defaults to `chart_title`/etc.
- `query()` is empty (no filtering performed).

Both variants are essentially UI shims: they render a text input in the exposed form under the expected identifier. They do NOT themselves apply the value to the chart — that is done in `hook_views_pre_view()` (see [api/pre-view.md](../api/pre-view.md)). Because the hook reads directly from the request, the same query params also work without any handler present, but the handlers give site builders a form control and the correct default identifier.

## Config schema (`config/schema/charts_exposed_settings.views.schema.yml`)
Provides per-handler options schema so the exposed options save cleanly. For each id it defines `views.field.<id>` (type `views_field`) and `views.filter.<id>` (type `views_filter`) with a single string mapping key matching the param (`chart_title`, `chart_subtitle`, `y_axis_title`, `x_axis_title`).
