<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# EngageBay — connect & embed

## Connect
`/engagebay/configure` (`EngageBayConfigurationForm`, `access administrator pages`). Posts username/password to `EngageBayAPI::login()` (`https://app.engagebay.com/rest/api/login/get-domain`). On success stores in `engagebay.settings`: `domain`, `email`, `rest_api_key`, `js_api_key`.

## API service
`EngageBayAPI` (`src/Service/EngageBayAPI.php`) wraps `\Drupal::httpClient()` (Guzzle):
- `login($user,$pass)`, `getForms()`, `getLandingPages()`, `getLandingPage($id)`.
- Auth via an `Authorization` header set from the REST API key.
- Base URIs are fixed HTTPS EngageBay hosts; default TLS verification applies (no `verify=>false`).

## Embed dialogs (CKEditor)
- `/engagebay/dialog/form/{filter_format}` → `EngageBayFormDialog`.
- `/engagebay/dialog/landingpage/{filter_format}` → `EngageBayLandingPageDialog`.
- Both require `_entity_access: 'filter_format.use'`; add the `Form` / `LandingPage` CKEditor plugins to a text format's toolbar.

## Body-placeholder replacement
`engagebay.module` scans node bodies for `{engagebayform_id}…{/engagebayform_id}` (and landing-page markers) and, when `rest_api_key` is set, replaces them by `file_get_contents()` of the hosted EngageBay URL. Hosts are fixed to `share.ebforms.com` / `<domain>.eb-sites.com`; the id segment comes from body content.
