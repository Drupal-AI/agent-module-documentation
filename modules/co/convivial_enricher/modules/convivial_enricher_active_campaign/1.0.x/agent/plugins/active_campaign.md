<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# `active_campaign` datasource + ActiveCampaign REST adaptor

## Plugin `ActiveCampaignEnricherDatasource`

`modules/convivial_enricher_active_campaign/src/Plugin/EnricherDatasource/ActiveCampaignEnricherDatasource.php`.
Id `active_campaign`, label *"Active Campaign"*. Extends `EnricherDatasourceBase`; DI adds the
adaptor (`convivial_enricher_active_campaign.api`) and `cache.default`.

### Settings (`defaultConfiguration()` + `buildConfigurationForm()`)

- `active_campaign_api_key` (required textfield) — the per-user ActiveCampaign API key; stored in
  the enricher config entity's `datasources[].settings`. Sent as the `Api-Token` request header.
- `active_campaign_base_url` (url) — account base URL; requests target `{base_url}/api/3/…`.
- `allow_list.contact_properties` / `contact_tags` / `contact_fields` (textareas) — newline-
  separated `fnmatch` patterns; only matching keys survive.
- `privacy.enabled` (checkbox, default TRUE) + `privacy.property_name` (default `privacy_accepted`)
  — opt-in gate for the contact's own properties.
- `cache_settings.{account_tags,contact_tags,contact}.{enabled,expiry}` — per-call caching; expiry
  is any `strtotime()` string (defaults `+1 day` / `+1 hour` / `+1 hour`).

Schema: `convivial_enricher.datasource.active_campaign` (config/schema).

### `fetchAndProcessData($email_hash)`

1. `initializeActiveCampaignApiCredentials()` → `adaptor->setApiKey()` + `setBaseUrl()` from config.
2. `getContactFromEmailHash($email_hash)` → `adaptor->makeApiCall('contacts', ['email_hash' => …])`,
   `json_decode`, `checkCachedUserIdEmailHashForChanges()`, return `$response->contacts[0]`.
3. If a contact was found: `filterContactPropertiesByAcceptList()` (properties),
   `getContactTagsFilteredByAcceptList()` (contact `contactTags` → account `tags` name match), and
   `getContactFieldsFilteredByAcceptList()` (per-field `fieldValues` + `field` title lookup). Each
   uses `filterKeyValueSetOnAcceptList()` (`fnmatch` per pattern).
4. Privacy: if `isPrivacyEnabled()`, the contact's own properties are added only when
   `hasUserAllowedTracking()` (the configured opt-in property on the contact is truthy). Tags and
   fields are always emitted (subject to allow-lists).
5. Each surviving `name => value` becomes `createCookie($name, $value)` → cookie
   `convivial_enricher_<name>` (default `+1 day`). Fetch errors are caught and
   `logger->warning()`-logged (channel `convivial_enricher`); enrichment continues.

### Hash-mismatch guard

`checkCachedUserIdEmailHashForChanges($response, $email_hash)` caches `email_hash` keyed by
`md5(api_key . base_url . 'active_campaign_datasource-contact-' . contact_id)` in `cache.default`;
if a later request presents a different hash for the same contact id it throws
`ContactHashMismatchException` (see the exception's own docblock for the spoofing scenario it
targets — a newsletter-address takeover). This is a best-effort guard, not an access control.

## REST adaptor `ActiveCampaignPhpApiAdaptor`

`modules/convivial_enricher_active_campaign/src/ActiveCampaignPhpApiAdaptor.php` (service
`convivial_enricher_active_campaign.api`, args `@http_client`, `@logger.factory`,
`@cache.discovery`).

- `makeApiCall($endpoint, $query_parameters = [])`: returns cached body if
  `setCacheDetailsForNextApiCall()` set a `cid` and a hit exists; otherwise
  `getResponseFromApi()` → `httpClient->request('GET', $url, ['headers' => ['Api-Token' =>
  $apiKey]])`. On success caches the body (if a cid was set) under
  `md5($apiKey . $baseUrl . 'convivial_enricher_active_campaign_api-' . $cid)`. `RequestException |
  GuzzleException | InvalidArgumentException` are caught and `warning()`-logged (channel
  `convivial_enricher_active_campaign`), returning `FALSE`.
- `generateRequestUrlFromEndpointPathAndParameters()` builds `Url::fromUri($baseUrl . '/api/3/' .
  $endpoint, ['query' => $params])`; empty base URL or empty API key throw `InvalidArgumentException`.
- Uses the standard Drupal `http_client` (Guzzle) with default TLS — no `verify => false`, no
  disabled cert checking. The API key travels only in the `Api-Token` header, not in the URL/query.

### Cache call types

`account_tags` (all account tags), `contact_tags` (a contact's tag ids), `contact` (the contact
record). Three lookups per enrichment; caching each independently is the module's rate-limit
strategy (ActiveCampaign: 5 req/s/account).
