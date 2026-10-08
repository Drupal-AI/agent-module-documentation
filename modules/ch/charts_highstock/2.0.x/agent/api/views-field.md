<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views field: Highstock Value (`field_charts_highstock`)

`hook_views_data()` (`charts_highstock.views.inc`) registers a global field **Highstock Value Field**
(`field_charts_highstock`), handled by `src/Plugin/views/field/HighstockValue.php`
(`#[ViewsField("field_charts_highstock")]`, implements `ChartViewsFieldInterface`).

Purpose: turn two other fields in the view into a Highstock `[timestamp, value]` data point for a
time-series/stock series.

## Options (`buildOptionsForm`)
- **Timestamp Provider** (`timestamp`) — a preceding field that outputs a numeric timestamp.
- **Value Provider** (`value`) — a preceding field that outputs the numeric value.
- **Value provider source** (`value_source`) — `entity` (default) or `views` (whether views rewrites apply).
- **Round** (`value_set_precision`) + **Precision** (`value_precision`, 0–10).
- **Decimal point** (`value_decimal`, default `.`) and **Thousands marker** (`value_separator`, default `,`).
- Only fields listed *before* this one are offered as providers.

## Output (`getValue`)
Returns `Json::encode([timestamp, formattedValue])`. Guards: if the timestamp is not numeric, or the
value is not numeric, returns `NULL` (no data point). `getChartFieldDataType()` returns `array`.
`query()` is a no-op (values come from the other fields at render time).
