<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Field type, widgets, formatter & settings

All classes under `src/Plugin/Field/`. The field type targets any fieldable entity; its widgets
source options from an external JSON API.

## Field type — `ApiDataConnectorItem`

`FieldType/ApiDataConnectorItem.php`, id `api_data_connector_item`, label "API Data Connector
Field.", `default_widget = api_data_connector_widget`, `default_formatter =
api_data_connector_formatter`.

Stored columns (`schema()`) / typed-data properties (`propertyDefinitions()`):

| Column | Type | Notes |
|---|---|---|
| `target_id` | int, nullable | The mapped remote **id** (required property, but nullable column) |
| `target_name` | varchar(255), NOT NULL | The mapped remote **label** shown/stored |
| `api_response_data` | blob, nullable | Serialized response row — only written by the Select2 widget |

### Per-field settings (`defaultFieldSettings()` + `fieldSettingsForm()`)

Three `details` fieldsets:

- **`api_fieldset`**
  - `api_url` (textfield, required) — the external API endpoint.
  - `query_parameter` (textfield, required) — the query-string parameter name the typed text is
    sent as (e.g. an API expecting `?q=` → put `q`).
- **`mapping_fieldset`**
  - `key` (textfield, required) — response field mapped to `target_id`. Supports **dotted nested
    paths**, e.g. `user.userid`.
  - `value` (textfield, required) — response field mapped to `target_name` (the label). Dotted
    paths supported.
  - `additional_values` (textarea, optional) — extra response fields to capture, one per line.
- **`auth_fieldset`**
  - `auth_value` (select, required) — the only shipped option is **`none`**. There is no
    authentication implementation; the widget/controller send **no credentials** and the field has
    nowhere to store one. Treat these fields as usable only against endpoints that need no auth (or
    that you front with your own authenticating proxy).

Note: `fieldSettingsForm()` reads `additional_values` as if it were a scalar string default even
though it is declared as an array default (`[]`) — a minor inconsistency; enter newline-separated
plain field names.

## Widgets (`src/Plugin/Field/FieldWidget/`)

### `ApiDataConnectorWidget` — id `api_data_connector_widget` (default)

`formElement()` builds a **`textfield`** with `#autocomplete_route_name =
api_data_connector.autocomplete` and `#autocomplete_route_parameters` carrying the field's
`api_url`, `query` (= `query_parameter`), `key`, `value`. As the editor types, core's autocomplete
JS hits that route (see [../api/autocomplete.md](../api/autocomplete.md)) which returns
`"Label(id),"` suggestions. `massageFormValues()` parses the submitted string with
`preg_match_all('/\((\d+)\)/', …)` to pull the `(id)` tokens and splits on `,` for names, saving
`{target_id, target_name}` per match. Selections are represented in the text as `Name(id),`.

### `ApiDataConnectorTagsWidget` — id `api_data_connector_widget_tags`

Extends the default widget, `multiple_values: TRUE`. Sets `#tags = TRUE` and pre-fills the field
with the existing `target_name`s joined by `, `. Same `(id)`-token parsing on submit → an array of
`{target_id, target_name}`.

### `ApiDataConnectorOptionsSelectWidget` — id `api_data_connector_select`

Extends core `OptionsWidgetBase`, `multiple_values: TRUE`, injects `http_client` + logger via
`create()`/`__construct()`. Instead of autocomplete it renders a **`select2`** element whose
`#options` are fetched **at form build**:

- `fetchSelectOptions($api_url, $key, $value, $additional_values)` — GETs `$api_url` (no query
  string), `json_decode`s the array, and for each row builds an option keyed by
  `fetchSerializeData()` (a PHP-`serialize()`d `{target_id, target_name, …additional}`) with the
  label as the option text. On any exception it shows a messenger error (including the raw
  exception message) and logs to channel `api_data_connector`.
- `fetchKey($user, $key)` — walks a dotted `key`/`value` path through the decoded row.
- `massageFormValues()` — reverses the serialized option value (the round-trip of the
  `fetchSerializeData()` payload built at form build) and stores
  `{target_id:(int), target_name, api_response_data}`, where `api_response_data` is the
  serialized row persisted to the blob column.

## Formatter — `ApiDataConnectorFormatter`

`FieldFormatter/ApiDataConnectorFormatter.php`, id `api_data_connector_formatter`. `viewElements()`
emits `['#markup' => $item->target_name]` for each non-empty item. (`#markup` is passed through the
renderer's admin XSS filter; `target_name` originates from the external API response, so it is
remote-sourced text.)

## Enable / operate

1. `composer require drupal/api_data_connector` (brings `drupal/select2`); `drush en
   api_data_connector -y`. Select2 must be enabled for the Select2 widget.
2. Add the field to a bundle; complete **API Details** + **Mapping Details** on field settings.
3. Pick the widget on *Manage form display* and the formatter on *Manage display*.

No config schema is shipped, so these field settings export/import through the standard
`field.field.*` / `field.storage.*` config with the values under `settings` — Config Inspector will
flag them as schemaless.
