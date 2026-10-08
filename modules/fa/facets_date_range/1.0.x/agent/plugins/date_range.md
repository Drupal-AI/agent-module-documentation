# The date_range facet widget & processor

Two Facets plugins. Configure them on a facet at *Configuration → Search and metadata → Facets* → edit
a facet.

## Widget: `date_range`

`src/Plugin/facets/widget/DateRangeWidget.php` (`@FacetsWidget(id="date_range")`, extends
`WidgetPluginBase`).

- Renders two `#type => 'date'` inputs, `<facet id>_min` and `<facet id>_max`, with classes
  `facet-date-range` and `data-type` of `date-range-min` / `date-range-max`.
- `getQueryType()` → `range`.
- `isPropertyRequired('date_range', 'processors')` → **true**, so the widget forces the matching
  processor to be enabled.
- Attaches library `facets_date_range/date-range` and sets
  `drupalSettings.facets.daterange[<facet id>].url` to the facet's result URL template.

Config (schema `facet.widget.config.date_range`, `defaultConfiguration()`):

| Key | Default | Meaning |
|---|---|---|
| `min_label` | `Date from` | Label for the min input. |
| `max_label` | `Date to` | Label for the max input. |

The config form also prints a warning telling you to enable the "Date Range Picker" processor.

## Processor: `date_range`

`src/Plugin/facets/processor/DateRangeProcessor.php` (`@FacetsProcessor(id="date_range")`), stages
`pre_query` (60) and `build` (20).

- **build:** rewrites each result URL, removing existing filters for the facet and appending the
  template `<url_alias>:(min:__date_range_min__,max:__date_range_max__)`. The JS substitutes the two
  placeholders with the chosen dates before navigating.
- **pre_query:** parses the active `(min:X,max:Y)` item via regex into a numeric `[min, max]` range for
  the query backend, handling min-only (max → +100 years), max-only (min → epoch), and empty cases.

Config (schema `plugin.plugin_configuration.facets_processor.date_range`):

| Key | Default | Meaning |
|---|---|---|
| `max_inclusive` | `false` | If true, extends the max bound by one day minus one second so the entire max date is included. |

## Setup checklist

1. Edit the facet, set **Widget** = *Date Range Picker*; set the min/max labels.
2. Under **Processors**, enable *Date Range Picker*; optionally tick *Include through end of max date*.
3. Save. The facet now shows two date inputs and filters by range.

Requires the facet's underlying field to be a date/timestamp so range comparison is meaningful.
