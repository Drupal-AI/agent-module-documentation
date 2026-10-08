# Configure an HMS field

No global settings page (`configure` null). Configure per field on **Manage form display**
(widget) and **Manage display** (formatter). The stored value is always an integer number of
seconds (column `value`, signed, nullable).

## Widget: `hms_default`
Renders the custom `hms` form element. Settings (`field.widget.settings.hms_default`):

| Key | Default | Meaning |
|---|---|---|
| `format` | `h:mm` | Input/parse format. Options from `HMSService::formatOptions()`. |
| `default_placeholder` | `1` (true) | Use the format string itself as the placeholder. |
| `placeholder` | `''` | Custom placeholder (used when `default_placeholder` off). |

Selectable formats (`formatOptions()`): ISO-8601-based `h:mm`, `hh:mm:ss`, `h:mm:ss`, `m:ss`,
`h`, `m`, `s`; plus space-separated `hms` (e.g. `3h 15m 30s`). On submit, input is validated and
converted to seconds by `HMSService::formattedToSeconds()`; invalid input raises a form error.

## Formatter: `hms_default_formatter`
Settings (`field.formatter.settings.hms_default`):

| Key | Default | Meaning |
|---|---|---|
| `format` | `h:mm` | Display format (same option set). |
| `leading_zero` | `true` | Zero-pad fragments (e.g. `01:05` vs `1:5`). |

Themed by `hms.html.twig` → `<span class="{{ classes }}">{{ hms_value_formatted }}</span>`.

### Live running-timer mode
The `hms` theme also accepts `running_since`, `offset`, `default_value` variables. When
`running_since !== 0`, `template_preprocess_hms()`:
- attaches library `hms_field/hms_field` and `drupalSettings.hms_field` (`servertime`, `factor_map`);
- adds classes `hms-running`, `hms-since-<ts>`, `hms-offset-<n>`, `hms-leading_zero-<0|1>` so
  `js/hms_field.js` ticks the value up in the browser from the given timestamp.
The stock `hms_default_formatter` does not expose `running_since` in its settings form — supply it
from a custom formatter/render array (`['#theme' => 'hms', '#value' => …, '#running_since' => …]`)
to build a live stopwatch/counter.

## Formatter: `hms_natural_language_formatter`
Renders selected unit fragments in words. Settings
(`field.formatter.settings.hms_natural_language_formatter`):

| Key | Default | Meaning |
|---|---|---|
| `display_formats` | `["w","d","h","m","s"]` | Which units to show (checkboxes). |
| `separator` | `", "` | Joins fragments. |
| `last_separator` | `" and "` | Joins the final two fragments. |

Themed by `hms-natural-language.html.twig`; only non-zero fragments are emitted, each pluralised
via `formatPlural()` with the unit labels from `factorMap(TRUE)`. Example: `1 hour, 5 minutes and
30 seconds`.

## Notes
- Value is a plain signed int → sorts/aggregates/range-filters correctly in Views and queries.
- Negative durations are supported (leading `-`).
- Format and unit sets are alterable globally — see [../api/service.md](../api/service.md).
