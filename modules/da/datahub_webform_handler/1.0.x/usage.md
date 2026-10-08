<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Webform Datahub adds a Webform handler (plugin id `webform_datahub`) that, on each submission, maps webform elements to a fixed set of attendee/profile fields and POSTs a nested `AttendeeRegistration` JSON document to an external "Datahub" registration REST API using a token obtained from that API's credentials-based login.

---

The module ships one Webform handler plugin, `WebformDatahub` (`src/Plugin/WebformHandler/WebformDatahub.php`, `CARDINALITY_UNLIMITED`), which you add to a webform and configure with a `webform_mapping` element mapping each webform element to one of a built-in list of destination keys (`firstName`, `email`, `surname`, `phoneNumberBaseNumber`, `addressCountry`, `companyName`, `industry`, `interest`, UTM/consent keys, etc.). In `postSave()` the handler reads the stored config, calls `GetAccessToken::accessToken()` to log in and retrieve an `accessToken`, calls `BodyValues::formValues()` to assemble the full nested payload (Profile + contactInformation + preferences + contactSessionHistory/Session, enriched with `utm_*` query parameters and country-code lookup via the core `country_manager`), and then `DatahubIntegration::sentWebformSubmissionTodatahub()` POSTs it to `{endpoint}/api/attendee/registration` with a `token` header. All three services are plain classes registered in `datahub_webform_handler.services.yml`. A site-wide settings form, `WebformDataHubConfigForm` at `admin/config/services/webform_datahub-config` (route `datahub_webform_handler.config`, permission `access administration pages`), stores the endpoint base URI, username and password in the config object `webform_datahub.settings`; on save it also performs a live login to `{endpoint}/api/secure/token` and caches the returned `accessToken`. The endpoint and credentials are administrator-configured, not derived from the request. Separately, `hook_webform_submission_insert()` in the `.module` file records UTM query parameters against a submission by creating a `utm` entity — but only if a `utm` entity type exists on the site (the module does not define one; the call is wrapped in try/catch and silently returns otherwise). All outbound calls use Drupal's default `http_client`/`httpClient` (standard Guzzle, TLS verification enabled). This is a bespoke integration built for a specific event-registration Datahub (endpoints, field list and `eventEditionCode` defaults are hard-wired), so it is most useful when integrating a Drupal Webform with exactly that API rather than as a generic connector.

---

- Forward a Webform submission to an external event-registration "Datahub" REST API on submit.
- Map arbitrary webform elements to attendee fields (`firstName`, `surname`, `email`, `phoneNumberBaseNumber`, `companyName`, `jobTitle`, `industry`, `interest`, ...) via a UI mapping table.
- Register newsletter or event sign-ups from a Drupal form into a CRM/registration backend.
- Send marketing- and third-party-consent flags (opt-in / opt-out) derived from checkbox elements to the Datahub.
- Capture UTM campaign attribution (`utm_source`, `utm_medium`, `utm_campaign`, `utm_content`, `utm_term`, `utm_refcode`, `utm_emailname`) from the landing-page URL and attach it to each submission payload.
- Populate `contactSessionHistory` / `Session` records (event edition code, form name, registration status) for each attendee.
- Look up an ISO country code from a submitted country name using core's `country_manager` before sending.
- Split a submitted phone number into country-code and base-number parts for the payload.
- Store the Datahub base URI, username and password centrally on one admin settings page.
- Automatically obtain and cache an API access token by logging in with the stored credentials.
- Re-authenticate on every submission (the handler fetches a fresh token in `postSave()`).
- Attach the same handler to multiple webforms (unlimited cardinality) with different field mappings.
- Send a submission's UUID as the payload's `uniqueRefereceNumber` for idempotency/traceability on the Datahub side.
- Optionally record UTM parameters against submissions in a `utm` entity when another module provides that entity type.
- Validate the configured endpoint URL format and protocol before saving credentials.
- Integrate an event/exhibition registration webform (visitor type, track/session codes) with a downstream attendee system.
- Keep the API endpoint and credentials as administrator-only configuration, not exposed to the front-end request.
- Log the outbound payload and API response to the Drupal log channel for integration debugging.
- Adapt an existing Webform to a proprietary registration API without writing a custom submit handler each time.
