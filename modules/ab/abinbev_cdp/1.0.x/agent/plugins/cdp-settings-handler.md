<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CDP Settings Handler (`cdp_settings_handler`)

Class `Drupal\abinbev_cdp\Plugin\WebformHandler\CDPSettingsHandler`
(`src/Plugin/WebformHandler/CDPSettingsHandler.php`), extends `WebformHandlerBase`. This is the
whole module.

## Install / enable

1. `webform` must be enabled (the class extends `WebformHandlerBase`; note the module's
   `info.yml` does not declare it as a dependency).
2. Enable `abinbev_cdp`.
3. Edit a Webform → **Settings → Emails/Handlers → Add handler → "CDP Settings Handler"**.
   Cardinality is unlimited, so one webform may carry several instances.

## Configuration (`buildConfigurationForm()`)

Settings are stored in the handler's own configuration (nested under the handler in the webform
config entity), grouped into three `details` sections. Values are plain textfields unless noted.

- **User settings** (`configuration['user_settings']`) — webform field **machine names** to read
  from the submission: `name` (default `first_name`), `surname` (`last_name`), `email` (`email`),
  `phone` (`phone`), `birthday` (`birthday`), `language` (`language`), and `additional_fields`
  (textarea; one `cdp_field|webform_field` mapping per line).
- **Purposes** (`configuration['purposes']`) — machine names of consent checkboxes on the form:
  `tcpp` (default `tcpp`), `marketing` (`marketing`), `newsletter` (`newsletter`).
- **Campaign details** (`configuration['campaign_details']`) — `campaign_name`, `form_id`,
  `brand`, `interests` (textfields); `country` (`select` from `getCountryList()`, 35 ISO-3 codes,
  default `bel`); `dynamical_country` (country from current page language); `is_production`
  (`radios` `dev`/`prod`, default `dev`); **`cdp_key_dev`** and **`cdp_key_prod`** — the Treasure
  Data **write keys** (`X-TD-Write-Key`) for each environment.

`defaultConfiguration()` seeds `user_settings`/`purposes`/`campaign_details` as empty arrays.
`submitConfigurationForm()` resets to defaults, re-applies form state, `array_filter()`s empties,
then merges `$form_state->getValues()`. `validateConfigurationForm()` is a no-op.
`overrideSettings()`/`getSubmissionSettingsOverride()`/`getSettingsDefinitions()` are token-aware
webform-settings-override plumbing inherited from the pattern; they act only on keys that exist in
`webform.webform.*` settings and do not affect the CDP push.

## Runtime flow

**`validateForm()`** — optional 18+ age gate. If a `birthday` field is mapped and present, it
parses the value as `Y-m-d`, diffs against now, and calls `$form_state->setErrorByName(...)` with
*"You must to be 18 years old at least."* when age < 18. No birthday, or an unmapped field, skips
the check.

**`submitForm()`** — builds the CDP payload from `$webform_submission->getData()`:

- Resolves `language` from the mapped field, falling back to the current language; strips a
  `xx-YY` region suffix down to the second part.
- Consent: `TC-PP` added when the tcpp value is truthy; `marketing` → `MARKETING-ACTIVATION` else
  `MARKETING-ACTIVATION-NOT-GIVEN`; `newsletter` → `PERSONALIZATION` else
  `PERSONALIZATION-NOT-GIVEN`. Collected into `purpose_name` (array).
- Maps present values to `abi_firstname`, `abi_lastname`, `abi_email`, `abi_phone`,
  `abi_birthday`; always sets `abi_country`, `abi_preferred_language`, `abi_interests`; appends
  the parsed `additional_fields` (`cdp_field => submitted value`).
- Calls the private `__sendTD(...)`.

**`__sendTD()`** — augments the payload with `abi_brand`/`abi_campaign`/`abi_form`, `td_unify`,
`td_import_method = 'postback-api-1.2'`, `td_client_id` (from the `_td` cookie), and
`td_url`/`td_host` (built from `$_SERVER` HTTP_HOST/REQUEST_URI). Maps the country to a Treasure
Data zone via a fixed `country_zone_mapping` (africa/apac/eur/midam/naz/saz). POSTs
`json_encode($form_data)` with a plain `curl` handle to:

```
https://in.treasuredata.com/postback/v3/event/{zone}_source/{country}_web_form
```

Headers: `Content-Type: application/json` and `X-TD-Write-Key: {key}`. The key is
`cdp_key_dev` when `is_production == 'dev'`, otherwise `cdp_key_prod`. TLS is left at curl's
secure default (peer verification on; the URL is hard-coded HTTPS to Treasure Data). Returns the
HTTP status code; the response body is discarded.

## Notes / gotchas

- The endpoint host is fixed; only the zone/country path segments vary from the configured
  country select — the request URL is never taken from user input.
- `is_production` logic is quirky: the payload key selection uses `== 'dev'`, while the
  `$is_production` flag uses `== 'prod' ?? FALSE`.
- The age-gate `setErrorByName()` is passed the birthday **value** rather than the field name.
- Fields not present in a submission are simply omitted from the payload.

## The theme

`abinbev_cdp_theme()` registers `webform_handler_cdp_submit_handler_summary`
(`templates/webform-handler-cdp-submit-handler-summary.html.twig`) — a generic
`settings.debug`/`settings.message` summary partial; the handler does not implement
`getSummary()`, so this template is vestigial.
