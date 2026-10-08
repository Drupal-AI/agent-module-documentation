DaData Integration attaches DaData Suggestions API autocomplete dropdowns (address, full name, email, company) to Drupal form fields selected by CSS selector, proxying each query server-side through the site's stored API token.

---

The module ships a single admin settings form (`/admin/config/services/dadata`, route `dadata_integration.settings`, permission `administer site configuration`) that stores the DaData API key, the base API URL, and a list of field rows. Each row maps a CSS selector to a suggestion type (`address`, `fio`, `email`, `party`) and, for addresses, a granularity/bound (`country`, `region`, `city`, `settlement`, `street`, `house`). `hook_page_attachments()` (implemented in `Hook\DadataIntegrationHooks`) attaches the `dadata_integration/dadata` library on every page and passes the configured field list to `drupalSettings.dadataIntegration.fields`. The client behavior in `js/dadata_autocomplete.js` binds each matched input; after three characters it fetches `/dadata/suggest/{type}` (route `dadata_integration.suggest`), which is served by `Controller\SettingsController::suggest()`. That controller builds a DaData `suggest` request payload (`query`, `count` capped at 20, `language`, optional `from_bound`/`to_bound`, optional `locations`/`locations_geo`) and POSTs it to `{api_url}/{type}` with an `Authorization: Token <api_key>` header via the core `http_client` (Guzzle, default TLS verification), returning the raw suggestions JSON to the browser. The module provides no entities, no plugin types, no permissions of its own, and no Drush commands; configuration is stored in the `dadata_integration.settings` config object (schema in `config/schema/dadata_integration.schema.yml`). It supports Drupal 10.1+, 11, and 12, depends only on `system`, and ships English (`.pot`) and Russian (`ru.po`) translations.

---

- Add address autocomplete to a contact or checkout form by mapping `#edit-address` to type `address`.
- Restrict an address field to city-level suggestions using the `city` bound so users pick a settlement, not a full street address.
- Populate a country field with country-only suggestions via the `country` bound.
- Offer region/oblast suggestions on a registration form with the `region` bound.
- Suggest street names for a delivery form using the `street` bound.
- Autocomplete house/building numbers for a precise-address field with the `house` bound.
- Add company (party) autocomplete so users search organizations by name or tax id.
- Add full-name (fio) autocomplete to prefill first/last/patronymic name fields.
- Add email-domain suggestions to an email field with type `email`.
- Bind autocomplete to a Webform element by targeting its rendered selector, e.g. `.webform-submission .field_city`.
- Target a field by attribute selector such as `input[name="company"]` when the id is unstable.
- Attach suggestions to several fields at once by adding one selector row per field on the settings form.
- Bind multiple inputs that share a class with a single selector row (the behavior binds every match).
- Point the base API URL at a self-hosted DaData gateway or mirror instead of the default `suggestions.dadata.ru` endpoint.
- Adjust the number of suggestions returned per query (default 10, hard-capped at 20 by the controller).
- Serve suggestions in a different response language by passing a `language` query parameter to the suggest endpoint.
- Constrain address results to specific locations by supplying a `locations` JSON parameter to the suggest endpoint.
- Constrain address results to a geographic area by supplying a `locations_geo` JSON parameter.
- Provide type-ahead address entry that improves data quality and reduces malformed addresses on submissions.
- Add autocomplete to fields injected by other modules, since selectors are matched against the whole page DOM on every request.
- Remove or reorder configured field rows through the AJAX add/remove controls on the settings form.
- Localize the admin UI and suggestion language for Russian-speaking sites using the bundled `ru.po` translation.
