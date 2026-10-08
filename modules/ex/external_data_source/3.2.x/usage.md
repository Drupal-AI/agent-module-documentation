External Data Source provides a Drupal field type whose allowed values come from an external web service (via a pluggable "data source"), rendered as an autocomplete, select, or checkboxes/radios widget, so editors pick from live remote options (e.g. countries, French regions/zip codes) instead of a hard-coded list.

---

The module defines a plugin type — `@ExternalDataSource` plugins managed by
`plugin.manager.external_data_source` — where each plugin's `getResponse()` returns a
`[{value,label}]` option list, typically by calling a remote API with Guzzle. Three plugins ship:
`countries` (restcountries.eu), `franceregions` and `francezipcodes` (geo.api.gouv.fr); each has a
**hardcoded** endpoint host and appends the request's `q` search term to the query — the URL is not
admin-configurable and cannot be pointed at an arbitrary host. It adds a field type
`external_data_source` (a single varchar `value` with `max_length`, plus storage settings `ws` =
the chosen data-source plugin id and `count` = max results) and three widgets:
`external_data_source_select_widget` (default, a `<select>`), `external_data_source_checkboxes_widget`
(checkboxes/radios), and `external_data_source_auto_complete_widget` (a textfield wired to the
`external_data_source.auto_complete_controller` autocomplete route at `/external_data_source/autocomplete`,
permission `access content`). The formatter `external_data_source_formatter` prints the stored value
(`nl2br(Html::escape(t($value)))`). The select/checkboxes widgets build their `#options` at form-build
time by instantiating the configured plugin and calling `optionsForSelect()`; the autocomplete widget
fetches options over AJAX as the user types. Responses are cast to strings and UTF-8-normalised
(`Masterminds\HTML5` `UTF8Utils`). There is no global settings page — everything is configured on the
field (Manage fields → storage settings) and its form/display. Extend it by writing your own
`@ExternalDataSource` plugin for any REST/JSON service.

---

- Provide a country-picker field whose list comes from a live countries web service.
- Populate a "French region" select field from the geo.api.gouv.fr API.
- Populate a "French commune / zip code" field from an external API.
- Add a field whose allowed values are maintained in an external system, not in Drupal.
- Offer an autocomplete text field that queries a remote API as the editor types.
- Render remote options as a single-select dropdown.
- Render remote options as multi-select checkboxes (or single-select radios).
- Cap the number of remote suggestions returned per field via the `count` storage setting.
- Constrain stored values to a maximum length with the `max_length` storage setting.
- Reuse the same external data source across many bundles by adding the field type repeatedly.
- Integrate a custom microservice as an option provider by writing an `@ExternalDataSource` plugin.
- Pull option lists from an internal REST catalogue service into a content field.
- Show a placeholder and control widget size for the remote-backed field.
- Keep option lists always current without editing Drupal config when the remote data changes.
- Provide a typeahead field for large remote datasets (autocomplete widget) to avoid huge selects.
- Display the stored external value on the rendered entity via the field formatter.
- Build a data-entry form where one field's choices are governed by an external authority list.
- Swap a field's backing service by changing the `ws` storage setting (before data exists).
- Programmatically resolve a plugin's options with `ExternalDataSourceController::optionsForSelect()`.
