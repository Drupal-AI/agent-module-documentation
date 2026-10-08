DaData API is a developer-oriented library module that wraps the DaData.ru Base, Cleaner, and Suggestions REST APIs as three injectable Drupal services.

---

The module ships no user-facing UI beyond an admin settings form; it is a thin, well-typed client for developers to call from their own code. Three services extend a shared `DaDataApiBase` class that reads the API key, secret, and timeout from the `dadata_api.settings` config object and issues Guzzle HTTP requests to DaData over HTTPS. `dadata_api.info` returns account version/balance/daily usage; `dadata_api.cleaner` standardizes and corrects submitted records (addresses, names, phones, emails, etc.); `dadata_api.suggestions` performs autocomplete-style suggestions, find-by-id lookups, nearest-address geolocation, and IP-to-location resolution. Authentication uses an `Authorization: Token <key>` header, with an added `X-Secret: <secret>` header for the Base and Cleaner endpoints. Responses are JSON-decoded and returned as arrays, or NULL on any non-2xx status or decode error. All calls are made server-side from your PHP code — there is no bundled autocomplete widget, form element, or public HTTP endpoint.

---

- Standardize a postal address entered by a user into a structured, canonical form via `dadata_api.cleaner`.
- Correct and enrich a full name (parse into surname/first/patronymic, detect gender) using the cleaner `name` type.
- Normalize and validate a phone number, returning region and operator metadata.
- Validate and correct an email address before storing it.
- Parse and standardize passport, vehicle, or birthdate fields with the Cleaner API.
- Build an address autocomplete feature in a custom form by calling `suggest()` with the `address` type from your own AJAX callback.
- Suggest company/organization records by name or INN for a B2B registration form (`suggest()`, `party` type).
- Suggest bank records by BIC/name to prefill payment-details forms.
- Look up an organization's full legal details by INN using `findById()` with the `party` type.
- Look up a bank's full details by BIC using `findById()`.
- Find the nearest postal address to a set of latitude/longitude coordinates via `geoLocate($data, 'address')`.
- Find the nearest postal unit (post office) to coordinates via `geoLocate($data, 'postal_unit')`.
- Detect a visitor's approximate city/region from their IP address with `ipLocate()` for geo-personalization.
- Auto-select the visitor's region on a form by calling `ipLocate()` with no argument (uses the current request's client IP).
- Display remaining DaData account balance in a custom admin dashboard via `dadata_api.info->getBalance()`.
- Monitor daily API usage/quota for a given date with `getStat('Y-m-d')`.
- Report the DaData API version programmatically with `getVersion()`.
- Batch-clean an array of records server-side during a data-import migration.
- Enforce clean, deduplicated address data at content-save time by hooking cleaner calls into an entity presave.
- Wrap the services in your own module to expose custom REST/JSON:API endpoints for a decoupled front end.
- Tune request latency/reliability with the configurable per-request `timeout` setting.
- Configure the API key and secret centrally through the settings form at Administration » Configuration » Web services » DaData API.
