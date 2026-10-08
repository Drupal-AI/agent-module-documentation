<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Webform Datahub module (datahub_webform_handler) — agent index

A single **Webform handler plugin** (id `webform_datahub`) that POSTs each submission to an
external **"Datahub" event-registration REST API**. On submit it logs in with a stored
username/password to fetch an access token, builds a nested `AttendeeRegistration` JSON payload
from a webform→field mapping plus UTM query parameters, and POSTs it to
`{endpoint}/api/attendee/registration`. Package `Webform`. Depends on **`webform`** (`^6.0`).
Core requirement `^9 || ^10 || ^11`. License GPL-2.0-or-later. Version 1.0.x. Not covered by a
security advisory policy.

- **Install, the settings form, config object, endpoint/credential flow** →
  [config/settings.md](config/settings.md)
- **The handler plugin, field mapping, payload assembly and the three services** →
  [plugins/webform_datahub.md](plugins/webform_datahub.md)

## What it actually is

- One plugin: `WebformDatahub` (`src/Plugin/WebformHandler/WebformDatahub.php`), extending
  `WebformHandlerBase`, `CARDINALITY_UNLIMITED`, `RESULTS_PROCESSED`, `tokens = TRUE`. Added to a
  webform under *Settings → Emails/Handlers*.
- Three plain services in `datahub_webform_handler.services.yml` (all extend
  `ServiceProviderBase`, none are real service providers — just DI-registered helper classes):
  - `datahub_webform_handler.GetAccessToken` → `GetAccessToken::accessToken()` — POSTs credentials
    to `{endpoint}/api/secure/token`, returns the raw JSON body containing `accessToken`.
  - `datahub_webform_handler.BodyValue` → `BodyValues::formValues(...)` — builds the nested
    `AttendeeRegistration` array from mapped data + UTM params.
  - `datahub_webform_handler.DatahubIntegration` →
    `DatahubIntegration::sentWebformSubmissionTodatahub($payload, $accessToken)` — POSTs the payload
    to `{endpoint}/api/attendee/registration` with a `token` header.
- One config/settings form: `WebformDataHubConfigForm`
  (`src/Form/WebformDataHubConfigForm.php`), route **`datahub_webform_handler.config`** at
  `admin/config/services/webform_datahub-config`, permission **`access administration pages`**,
  menu link under *Configuration → Web services*.
- Config object: **`webform_datahub.settings`** (`endpoint_api`, `username`, `password_field`,
  `accessToken`). **No `config/schema`, no `config/install`** — the object is created only when the
  form is saved.
- One JS asset `js/webform_datahub.js` (library `webformDatahub`, attached on every page via
  `hook_preprocess_page`) that masks the `#edit-password-field` input to `type=password`
  client-side.
- One hook: `hook_webform_submission_insert()` in the `.module` file records `utm_*` query
  parameters into a **`utm` entity** — but only if such an entity type exists (wrapped in
  try/catch; the module does **not** define it, so it is a no-op on a stock site).

## Provides / does not provide

- **No** permissions of its own, **no** Drush commands, **no** config schema, **no** new plugin
  types, **no** entities. It *consumes* Webform's handler plugin type and *targets* an external API.

## Notes (from source)

- Outbound calls use Drupal's default `\Drupal::httpClient()` / `http_client` (standard Guzzle) —
  **TLS verification is on** (no `verify => false`).
- The endpoint base URI and credentials are **administrator config**, never taken from the request;
  there is no request-supplied URL fetched server-side.
- The destination field list (`firstName`, `email`, `surname`, `phoneNumberBaseNumber`,
  `addressCountry`, `companyName`, `industry`, `interest`, `eventEditionCode`, consent keys, ...)
  and several defaults (`eventEditionCode` `EME23FST`, `sourceSystem` `SS_DRUPAL`, session/track
  codes) are hard-wired for a specific event Datahub — this is a bespoke, not generic, connector.
