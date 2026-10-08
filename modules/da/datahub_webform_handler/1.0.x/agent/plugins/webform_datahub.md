<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `webform_datahub` handler plugin, field mapping and payload services

## The handler

- Class `WebformDatahub` (`src/Plugin/WebformHandler/WebformDatahub.php`), extends
  `WebformHandlerBase`.
- Annotation: `id = "webform_datahub"`, label/category *"WebformDatahub"*,
  `cardinality = CARDINALITY_UNLIMITED`, `results = RESULTS_PROCESSED`,
  `submission = SUBMISSION_OPTIONAL`, `tokens = TRUE`.
- Injects `entity_field.manager` and `language_manager` in `create()` (neither is actually used in
  the shipped logic).

### Adding & configuring it

1. Edit a webform → *Settings → Emails / Handlers* → *Add handler* → **WebformDatahub**.
2. `buildConfigurationForm()` renders one `webform_mapping` element,
   `settings.user_field_mapping`:
   - **Source** = the webform's elements (from `getElementsInitializedFlattenedAndHasValue()`).
   - **Destination** = a **hard-coded list** of keys (in `getMappingOptions()`): `firstName`,
     `email`, `surname`, `websiteURL`, `phoneNumberBaseNumber`, `addressCountry`,
     `registrationStatus`, `jobTitle`, `addressTownCity`, `title`, `gender`, `companyName`,
     `interest`, `industry`, `eventEditionCode`, `getInTouch`, `eventsAndProduct`,
     `CPHIMilanEvents`, `CPHIMilanLatestProductsServices`, `CPHIMilanPartnersProductsServices`,
     `privacyTerms`, `visitorType`, `jobFunction`.
   - Mapping is optional; stored in `configuration['user_field_mapping']`.

### On submission (`postSave()`)

1. Collects submission data, webform/submission UUIDs, name.
2. Rebuilds `$user_field_data` by remapping each `webform_key => destination_key` from
   `user_field_mapping`.
3. Reads UTM parameters from `$_SERVER['QUERY_STRING']` (via `parse_str`).
4. `$token = datahub_webform_handler.GetAccessToken::accessToken()` — a fresh login on **every**
   submission.
5. If a token came back, decodes `accessToken`, builds the payload with
   `datahub_webform_handler.BodyValue::formValues(...)`, then POSTs it via
   `datahub_webform_handler.DatahubIntegration::sentWebformSubmissionTodatahub($payload, $token)`.

> Note: the handler uses super-globals (`$_SERVER`, `parse_str`) rather than the request service,
> and re-authenticates per submission rather than reusing the cached `accessToken`.

## Service: `GetAccessToken` (`src/Service/GetAccessToken.php`)

`accessToken()` reads `webform_datahub.settings` (`username`, `password_field`, `endpoint_api`),
POSTs to `{endpoint_api}/api/secure/token` with the credentials as `username` / `password` headers
(default Guzzle, TLS on), and returns the **raw JSON response body** (the caller decodes
`accessToken`). On failure it logs *"AccessToken Not Generated"* and returns `''`.

## Service: `BodyValues` (`src/Service/BodyValues.php`)

`formValues($user_field_data, $webform_uuid, $submission_uuid, $webform_name, $queryParams,
$response)` assembles the nested `AttendeeRegistration` array:

- **Profile**: `firstName`, `surname`, `title`/`gender`, `sourceSystem = 'SS_DRUPAL'`,
  `contactInformation` (email/address/phone), `organization` (company, `natureOfBusiness.SIC` =
  industry, jobFunction, jobTitle), `preferences` (marketing / third-party opt-in flags derived
  from `getInTouch`, `eventsAndProduct`, `CPHIMilan*`, `privacyTerms`).
- **contactSessionHistory**: `eventEditionCode` (default `EME23FST`), the UTM values, `formName`,
  and one `Session` with `actionDateTime` (`date("d-m-Y\TH:i:s")`), visitor type, website URL,
  fixed track/session codes (`T_EXHB` / `S_EXHB` "Exhibition"), `uniqueRefereceNumber` =
  submission UUID, `registrationStatus` (default `RS_REGSTR`), and an `interest` array built from
  the mapped `interest` values.
- Country handling: `addressCountry` name → ISO code via `\Drupal::service('country_manager')
  ->getList()` + `array_search`.
- Phone handling: splits the value on the first space into `phoneNumberCountrycode` +
  `phoneNumberBaseNumber`.

Consent mapping (examples): `privacyTerms == '1'` → all opt-ins *Yes/Explicit*;
`CPHIMilanLatestProductsServices == 'yes'` → `marketingOptIn = Yes/Explicit`; `getInTouch == '1'`
→ third-party *No/Explicit*. Defaults are `marketingOptIn = Yes`, type `Implicit`.

## Service: `DatahubIntegration` (`src/Service/DatahubIntegration.php`)

`sentWebformSubmissionTodatahub($payload, $accessToken)` reads `endpoint_api` from config, and
`http_client->post("{endpoint_api}/api/attendee/registration", ['json' => $payload, 'headers' =>
['Content-Type' => 'application/json', 'token' => $accessToken]])`. Default Guzzle (TLS on).
The response body and the JSON payload are written to the log channels *"webform_datahub
response_body"* / *"webform_datahub response"*. Exceptions are caught and logged.

## The UTM hook (`.module`)

`datahub_webform_handler_webform_submission_insert()` reads `utm_*` query parameters and, **only if
a `utm` entity type is available** (`entityTypeManager()->getStorage('utm')`, wrapped in
try/catch), creates a `utm` entity keyed by the submission id. The module does **not** define a
`utm` entity type or provide config for one, so on a stock install this hook returns early and does
nothing. `hook_preprocess_page()` also attaches the `webformDatahub` library on every page (only
used to mask the settings-form password input).

## Gotchas

- The destination field list and several codes (`eventEditionCode` `EME23FST`, track `T_EXHB`,
  `sourceSystem` `SS_DRUPAL`) are hard-wired for a particular event Datahub; adapt expectations
  accordingly.
- No config schema ships, so strict schema tooling may flag `webform_datahub.settings` and the
  handler's `user_field_mapping` config.
- The three "services" extend `ServiceProviderBase` but are ordinary helper classes; they mostly
  fetch dependencies via `\Drupal::` static calls rather than injection.
