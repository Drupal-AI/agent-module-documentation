<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# API Data Connector (api_data_connector) — agent index

A field type whose widgets fetch their options/autocomplete suggestions from an **external JSON
API** instead of local entities, storing the chosen **id + name** on the entity. Package `Custom`.
Depends on the **`select2`** contrib module. Core `^11`. License GPL-2.0-or-later.
Version **1.0.0-alpha15**. No admin settings form, **no `.permissions.yml`, no config schema,
no `.install`, no `.module`, no services file** — all configuration is per-field.

- **Field type, three widgets, formatter, settings, storage** →
  [fields/field.md](fields/field.md)
- **The autocomplete route + controller (how the text widget queries the API)** →
  [api/autocomplete.md](api/autocomplete.md)

## What it actually is (from source, `src/`)

- **Field type** `api_data_connector_item` — `Plugin/Field/FieldType/ApiDataConnectorItem.php`.
  Columns `target_id` (int), `target_name` (varchar 255, NOT NULL), `api_response_data` (blob).
  Per-field settings in three fieldsets: `api_fieldset` (`api_url`, `query_parameter`),
  `mapping_fieldset` (`key`, `value`, `additional_values`), `auth_fieldset` (`auth_value` — the
  only option shipped is `none`, so there is no authentication mechanism). `default_widget =
  api_data_connector_widget`, `default_formatter = api_data_connector_formatter`.
- **Widgets** (`Plugin/Field/FieldWidget/`):
  - `api_data_connector_widget` (`ApiDataConnectorWidget`) — a `textfield` with
    `#autocomplete_route_name = api_data_connector.autocomplete`; the field's `api_url`/query/key/value
    are passed as **route (query) parameters** to that controller.
  - `api_data_connector_widget_tags` (`ApiDataConnectorTagsWidget` extends the above) — same, with
    `#tags = TRUE`, multi-value.
  - `api_data_connector_select` (`ApiDataConnectorOptionsSelectWidget` extends
    `OptionsWidgetBase`) — a **Select2** element whose `#options` are fetched from the API at form
    build via `fetchSelectOptions()`; injects `http_client` + a logger. `massageFormValues()`
    reverses the serialized option value back into the stored row.
- **Formatter** `api_data_connector_formatter` (`ApiDataConnectorFormatter`) — renders each item's
  `target_name` as `#markup`.
- **Route** `api_data_connector.autocomplete` — `GET /api-data-connector/individual-user/autocomplete`,
  `_permission: 'access content'`, `ApiDataConnectorController::autocomplete()` (injects
  `config.factory`, `http_client`, logger). Reads `q`, `api_url`, `query`, `key`, `value` from the
  query string, GETs `api_url`, returns matched rows as `JsonResponse`.

## Operate it

1. `composer require drupal/api_data_connector` (pulls `drupal/select2`), `drush en api_data_connector -y`.
2. Add a field of type **API Data Connector Field** to a bundle.
3. On the field settings, fill **API Details** (API URL + parameter name) and **Mapping Details**
   (key → stored id, value → label; dotted paths like `user.userid` supported).
4. Choose one of the three widgets on **Manage form display**; the formatter on **Manage display**.

No Drush commands, no hooks, no update hooks. See the solution docs for exact keys and flow.
