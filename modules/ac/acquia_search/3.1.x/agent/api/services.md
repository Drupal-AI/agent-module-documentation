<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# API — services, preferred core, events

Services from `acquia_search.services.yml`.

## Resolving the core to use

- **`acquia_search.preferred_core_factory`** (`PreferredCoreServiceFactory`) — call
  `->get($server_id)` to obtain a `PreferredCoreService` for a Search API server. This is the
  supported entry point.
- **`acquia_search.preferred_core`** (`PreferredCoreService`) — **deprecated** in 3.1.x,
  removed in 4.0.x. It is the factory's result for the legacy `acquia_search_server` id kept
  for BC. Use the factory instead.

`PreferredCoreService` answers "which Acquia Solr core does this server map to?" — it lists
possible cores, applies `override_search_core`, and selects the preferred one for the current
Acquia environment. The read-only/backend logic in `acquia_search.module`
(`hook_search_api_server_load`) uses it to decide whether to disable the server or flag it
read-only.

## Talking to the Acquia Search API

- **`acquia_search.api_client`** (`AcquiaSearchApiClient`) — HMAC-authenticated HTTP client
  (built on `acquia_connector.subscription` credentials + `http_client_factory`) that queries
  Acquia's Search API for the subscription's cores. Results are cached in the
  `cache.acquia_search.indexes` bin (memory + `cache.data` chain).
- **`acquia_search.solarium.guzzle`** (`AcquiaGuzzle`) — Guzzle adapter wired into Solarium so
  Solr requests are HMAC-signed.

## Event subscribers (wired automatically)

- `acquia_search.search_subscriber` (`SearchSubscriber`) — signs/monitors Solr search requests,
  integrates the flood limiter.
- `acquia_search.subscription_data` (`AcquiaSearchData`) — contributes Acquia subscription data.
- `acquia_search.possible_cores.*` (`LocalOverride`, `AcquiaHosting`, `DefaultCore`) — the three
  strategies that build the list of possible cores (local override wins, then Acquia hosting
  detection, then a computed default).
- `acquia_search.prequery.edismax` (`EdisMax`) — switches a query to the eDisMax parser when the
  index has `use_edismax` enabled.

## Events

`Drupal\acquia_search\AcquiaSearchEvents` defines the event name constants the module
dispatches (e.g. the pre-query hook the eDisMax subscriber listens on). Subscribe with a
tagged `event_subscriber` service to observe or alter Solr query behavior.

## Runtime helpers

`Drupal\acquia_search\Helper\Runtime::isAcquiaServer($server)` tells whether a Search API
server is an Acquia-managed one — used throughout the module's load/alter logic.
