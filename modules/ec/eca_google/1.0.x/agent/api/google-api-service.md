<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# eca_google.google_api service + auth-config trait

Source: `src/GoogleApiService.php`, `src/GoogleAuthActionConfigTrait.php`,
`eca_google.services.yml`. This is the whole public surface of the base module.

## Service registration

`eca_google.services.yml`:

```
eca_google.google_api:
  class: Drupal\eca_google\GoogleApiService
  arguments: ['@google_api_client.client', '@google_api_service_client.client', '@entity_type.manager', '@logger.factory']
```

Logger channel: `eca_google`.

## `GoogleApiService` methods

- `getService(string $service_name, string $auth_type, string $client_id): ?object` — entry point.
  Dispatches on `$auth_type`: `api_client` → `getServiceApiClient()`, `service_account` →
  `getServiceAccount()`; any other value is logged as error and returns NULL. Wraps everything in
  try/catch, logging `Failed to initialize Google @service service: @message` and returning NULL.
- `getServiceApiClient()` (private) — loads a `google_api_client` entity by id, calls
  `googleApiClientService->setGoogleApiClient()` then `getServiceObjects()`, returns
  `$service_objects[$service_name]` (e.g. the `Google\Service\Sheets` object) or NULL if the client
  is missing / the service isn't configured on it.
- `getServiceAccount()` (private) — same flow against the `google_api_service_client` entity storage
  and `googleApiServiceClientService`.
- `validateApiAccess(string $service_name, string $auth_type, string $client_id): bool` — returns
  `getService(...) !== NULL`; used by action forms/execute for pre-flight checks.
- `getClients(?string $auth_type = NULL): array` — loads all `google_api_client` and/or
  `google_api_service_client` entities.
- `getClientOptions(): array` — builds select options keyed `"$type:$id"` with labels
  `"<client label> (API Client|Service Account)"`.
- `parseAuthClientId(string $auth_client_id): ?array` — splits `"auth_type:client_id"` on the first
  `:`; returns `['auth_type'=>…, 'client_id'=>…]`, or NULL if no `:` or an unknown auth type.

## `auth_client_id` format

Every Google action stores a single string `auth_client_id = "<auth_type>:<client_id>"` where
`auth_type` is `api_client` (OAuth2) or `service_account`, and `client_id` is the config-entity id.
Examples: `api_client:my_oauth`, `service_account:reporting_sa`.

## `GoogleAuthActionConfigTrait`

Reusable by any Google action plugin:

- `getAuthClientIdDefaultConfig(): array` → `['auth_client_id' => '']`.
- `addGoogleAuthConfigurationForm()` — adds a **required** `select` `auth_client_id` titled "Google
  API Client", options from `$this->googleApiService->getClientOptions()`, with an empty option.
- `validateApiClientId()` — form validation: errors if the value lacks `:` or the parsed auth type is
  not `api_client`/`service_account`.

## Credentials & TLS

This module stores no keys/tokens and makes no direct HTTP calls; credential storage, token refresh
and transport all live in `google_api_client` / the google-api-php-client library. Logged values are
limited to entity ids, service names, auth types and Google error messages.

## Extending the suite

A new Google service submodule injects `eca_google.google_api`, calls
`getService('<service>', $auth_type, $client_id)` and wraps the returned google-api-php-client object.
`eca_google_sheets` is the reference implementation.
