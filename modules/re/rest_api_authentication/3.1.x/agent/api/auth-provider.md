<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The authentication provider

## Service & registration

`rest_api_authentication.services.yml`:

```yaml
rest_api_authentication.authentication.rest_api_authentication:
  class: Drupal\rest_api_authentication\Authentication\Provider\RestAPI
  tags:
    - { name: authentication_provider, provider_id: rest_api_authentication, priority: 150 }
```

Priority 150 means it is considered ahead of core `basic_auth` (100) / `cookie` when it claims
a request. Also registers a `page_cache_request_policy` (`DisallowAPIRequests`) so protected
API responses are not served from the page cache, and a `RouteSubscriber`.

## `applies(Request)` — when it takes over

Returns TRUE only when `enable_authentication == 1` **and** the request URI contains either
`/jsonapi/` or `?_format=`. It explicitly returns FALSE for `/admin/config/services/jsonapi/`
(the JSON:API UI). Everything else (normal pages) is left to core providers.

## `authenticate(Request)` — the flow

1. `/user/login` is passed through (returns NULL) so clients can still get a session.
2. Determine the **application**: from the `auth-method` request header (its value is the
   application id), else the configured `default_application_id` (only if that app has
   `is_default`). No app resolvable → `400 MISSING_HEADER`; unknown id → `400 INVALID_APPLICATION_ID`.
3. Read the app's `authentication_method` and dispatch to the validator:

   | id | method | validator |
   |---|---|---|
   | `0` | basic_auth | `ApiAuthenticationBasicAuth::validateApiRequest` |
   | `1` | api_key | `ApiAuthenticationApiToken::validateApiRequest` |
   | `2` | oauth | (premium) |
   | `3` | jwt | (premium) |
   | `4` | external_oauth | (premium) |

4. On success the matched Drupal user is returned and the request proceeds; on failure a JSON
   error (`401`/`400`) is thrown. Every attempt is recorded via the `RestApiLogger` service
   (`rest_api_authentication.logger`) into a DB table (viewable on the Audit Logs form).

## API-key method specifics

`ApiAuthenticationApiToken` accepts either an `api-key` header (base64 of `username:token`) or
an `Authorization: Basic <base64 username:token>` header, and compares the token against
`rest_api_authentication.settings:api_token`.

## Token revoke endpoint

`/rest_api/revoke` (`rest_api_authentication.token_revoke`) is publicly routable
(`_access: 'TRUE'`); the controller itself validates Basic Auth credentials and the HTTP
method before revoking.

## No hooks / plugins / drush

The module exposes no plugin type, no Drush commands, and no public API beyond this provider
and the logger service. To customize behavior you would decorate the provider service or the
validators. Premium methods (OAuth/JWT/external OAuth/headless SSO) call miniOrange services;
the free surface (enable flag, api_key/basic methods, audit logging) is self-contained.
