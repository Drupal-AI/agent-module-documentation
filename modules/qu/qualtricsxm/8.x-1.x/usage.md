<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# QualtricsXM

Connects Drupal to Qualtrics. The main module stores API credentials and a base URL, calls the Qualtrics API to list/fetch surveys, and renders a survey page that embeds the survey in an iframe. Submodule `qualtricsxm_embed` adds a survey field type + iframe formatter; `qualtricsxm_insights` adds insight entities/admin.

---

# Installing & configuring

- Enable the module and configure at `/admin/config/content/qualtricsxm` (permission `administer qualtricsxm settings`, restricted): API token and base URL.
- Browse surveys at `/admin/config/content/qualtricsxm/surveys` (same admin permission).
- Grant `access qualtricsxm survey` to roles allowed to view embedded surveys at `/qualtricsxm/survey/{survey_id}`.
- Optionally enable `qualtricsxm_embed` and `qualtricsxm_insights`.

---

- `Qualtricsxm::httpRequest()` calls the Qualtrics API via Drupal `httpClient` (Guzzle) with a 15s timeout and default TLS verification (not disabled).
- The API token is sent in an `X-API-TOKEN` header (not in the URL).
- The API base URL and token come from admin config, not from request input — no request-driven fetch, so no SSRF.
- URL path params for the API call are `urlencode()`d.
- The survey page `/qualtricsxm/survey/{survey_id}` requires `access qualtricsxm survey`.
- The survey is embedded via an `inline_template` iframe whose `src` = admin base URL + survey id (Twig auto-escapes the attribute).
- `administer qualtricsxm settings` is marked `restrict access: true`.
- Submodule `qualtricsxm_embed` provides a `field_qualtricsxm_survey` field type, dropdown widget and iframe formatter.
- Submodule `qualtricsxm_insights` provides insight entities with add/edit/delete admin forms.
- Survey list/fetch failures are logged and degrade gracefully ('Survey is unavailable').
- No secret is written to markup or the client (token stays server-side in the header).
- The module makes outbound calls only to the configured Qualtrics endpoint.
- Suited to embedding Qualtrics surveys and surfacing survey metadata in Drupal.
- Hardening: store the API token in a Key entity rather than plain config.
- No anonymous mutation or disclosure endpoints were found.
- TLS verification is left at Drupal's secure default; no `verify => false`.
