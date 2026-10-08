# Configure — the field, widgets and formatter

No global settings page. Everything is set on a field of type **External Data Source Field**
(`external_data_source`).

## Add the field

Manage fields → add field → "External Data Source Field". On the field **storage settings**
(`ExternalDataSource::storageSettingsForm`, all `#disabled` once the field has data):

| Setting | Key | Default | Meaning |
|---|---|---|---|
| External Data Source | `ws` | `countries` | data-source plugin id (select of all `@ExternalDataSource` plugins) |
| Max result count | `count` | `10` | max suggestions requested |
| Maximum length | `max_length` | `255` | varchar length + `Length` constraint on the stored value |

The stored column is a single string `value` (required). Shipped `ws` choices: `countries`,
`franceregions`, `francezipcodes`.

## Widgets (Manage form display)

| Widget id | UI | Notes |
|---|---|---|
| `external_data_source_select_widget` | `<select>` (default) | options built at form build via the plugin's `optionsForSelect()`; prepends a "None" option |
| `external_data_source_checkboxes_widget` | checkboxes (multi) / radios (single) | extends `OptionsWidgetBase`; validates stored values against the option list |
| `external_data_source_auto_complete_widget` | textfield + autocomplete | uses `#autocomplete_route_name = external_data_source.auto_complete_controller` with route params `plugin_name = ws`, `count` |

Each widget has `size` and `placeholder` settings (schema
`field.widget.settings.external_data_source_*_widget`). The select/checkboxes widgets throw
`SuspiciousOperationException` if the configured `ws` is not a known plugin.

## Formatter (Manage display)

`external_data_source_formatter` renders each value as `nl2br(Html::escape(t($item->value)))` —
escaped plain text.

## Autocomplete route

`external_data_source.auto_complete_controller` → `/external_data_source/autocomplete`, JSON,
permission **`access content`**, `no_cache: TRUE`. Query params:
`plugin_name` (must be a registered `@ExternalDataSource` id — otherwise `NotFoundHttpException`)
and `q` (the search term passed to the data source). The controller instantiates the plugin,
sets the request, and returns `getResponse()` as JSON. Because `q` is appended to each shipped
plugin's **hardcoded** endpoint host, it only varies the query against that fixed third-party API —
it cannot redirect the request to another host.

## Programmatic option resolution

`ExternalDataSourceController::optionsForSelect(ExternalDataSourceInterface $plugin): array` returns
`['value' => 'label', …]` (UTF-8-normalised), the same list the select/checkboxes widgets use.
