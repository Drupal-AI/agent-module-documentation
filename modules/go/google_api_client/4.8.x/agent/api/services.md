<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# API: client services

The module exposes two services (`google_api_client.services.yml`) — one per account type. Both
follow the same two-step pattern: **set the account, then get service objects**.

## `google_api_client.client` — OAuth accounts

Class `Drupal\google_api_client\Service\GoogleApiClientService`. Public methods:

| Method | Purpose |
|---|---|
| `setGoogleApiClient(GoogleApiClientInterface $account, ?\Google_Client $client = NULL)` | Load an OAuth `google_api_client` account into the service, apply its stored access token, and refresh it if expired (revokes + clears the token on failure). Call this first. |
| `getServiceObjects($blank_client = FALSE, $return_object = TRUE)` | Return `[service_name => Google\Service\* object]` for the account's selected services, built from the cached service→class map. Use these to call the Google API. |

```php
$svc = \Drupal::service('google_api_client.client');
$account = \Drupal::entityTypeManager()->getStorage('google_api_client')->load($id);
$svc->setGoogleApiClient($account);
$services = $svc->getServiceObjects();   // e.g. ['calendar' => Google\Service\Calendar]
$events = $services['calendar']->events->listEvents('primary');
```

`setGoogleApiClient()` returns FALSE (and leaves the account unauthenticated) when there is no
valid/refreshable token — always check the account is authenticated first
(`$account->getAuthenticated()`), because live calls require real Google credentials + a completed
OAuth flow.

## `google_api_service_client.client` — service accounts

Class `GoogleApiServiceClientService`. Same shape for the `google_api_service_client` config
entity:

| Method | Purpose |
|---|---|
| `setGoogleApiClient(GoogleApiServiceClientInterface $account, ?\Google_Client $client = NULL)` | Build a `Google\Client` from the account's `auth_config` service-account JSON + scopes (no interactive consent). |
| `getServiceObjects()` | Return the instantiated `Google\Service\*` objects for the account's services. |

## Account entity accessors

`GoogleApiClient` (content entity) getters/setters incl. `getClientId()`, `getClientSecret()`,
`getDeveloperKey()`, `getScopes()`, `getServices()`, `getAccessToken()` / `setAccessToken()`
(token stored in State), `getAuthenticated()` / `setAuthenticated()`, `getAccessType()`,
`getOwner()`. The service classes use these; you rarely touch the token directly.
