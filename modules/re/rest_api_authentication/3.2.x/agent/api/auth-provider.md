<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The authentication provider

## Service & registration

`rest_api_authentication.services.yml`:

```yaml
rest_api_authentication.authentication.rest_api_authentication:
  class: Drupal\rest_api_authentication\Authentication\Provider\RestAPI
  arguments: ['@config.factory', '@entity_type.manager', '@logger.factory', '@rest_api_authentication.logger']
  tags:
    - { name: authentication_provider, provider_id: rest_api_authentication, priority: 150 }
```

Priority 150 means it is considered ahead of core `basic_auth` (100) / `cookie` when it claims
a request. The module also registers a `page_cache_request_policy` (`DisallowAPIRequests`) so
protected API responses are not served from the page cache, a `RouteSubscriber` (which adds the
provider to the `user.login.http` route's `_auth` list), and the `rest_api_authentication.logger`
audit-logging service.

## `applies(Request)` — when it takes over

Returns TRUE only when `enable_authentication == 1` **and** either:

- the routed path (`$request->getPathInfo()`) contains `/jsonapi/`, or
- the request carries a `_format` query parameter (`$request->query->has('_format')`).

It explicitly returns FALSE for `/admin/config/services/jsonapi/` (the JSON:API UI). Everything
else (normal pages) is left to core providers. In 3.2.x the gate matches the routed path and the
parsed query bag rather than substring-matching the raw URI, so the decision no longer depends on
where `_format` sits in the query string (the earlier `?_format=` substring check could be evaded
by reordering query parameters, e.g. `?x=1&_format=json`). `DisallowAPIRequests::check()` uses the
same two conditions to deny page-cache delivery.

## `authenticate(Request)` — the flow

1. `/user/login` is passed through (returns NULL) so clients can still get a session.
2. Determine the **application**: from the `auth-method` request header (its value is the
   application id), else the configured `default_application_id` (only if that app exists and has
   `is_default`). No app resolvable → `400 MISSING_HEADER`; unknown id → `400 INVALID_APPLICATION_ID`.
3. Read the app's `authentication_method` and dispatch to the validator:

   | id | method | validator |
   |---|---|---|
   | `0` | basic_auth | `ApiAuthenticationBasicAuth::validateApiRequest` |
   | `1` | api_key | `ApiAuthenticationApiToken::validateApiRequest` |
   | `2` | oauth | (premium — falls through, returns NULL) |
   | `3` | jwt | (premium — falls through, returns NULL) |
   | `4` | external_oauth | (premium — falls through, returns NULL) |

4. On success the matched Drupal user is loaded and returned and the request proceeds; on failure
   a JSON-style error is thrown (`UnauthorizedHttpException` for 401, `AccessDeniedHttpException`
   for 403). Every attempt is recorded via the `RestApiLogger` service
   (`rest_api_authentication.logger`) into the `rest_api_authentication_logs` DB table (viewable on
   the Audit Logs form). `handleException()` rewrites a bare `AccessDeniedHttpException` into an
   `UnauthorizedHttpException` ("Invalid consumer origin.").

## Basic-auth method specifics

`ApiAuthenticationBasicAuth::validateApiRequest` reads the credentials from a configurable
`custom_header` (falling back to `Authorization`/`Authorisation`), HTML-escapes the header,
requires a `Basic` type, base64-decodes `username:password`, then verifies them through core
`\Drupal::service('user.auth')->authenticate()`. Blocked users are rejected with `403 USER_BLOCKED`.

## API-key method specifics

`ApiAuthenticationApiToken::validateApiRequest` accepts either an `api-key` header
(base64 of `username:token`) or an `Authorization: Basic <base64 username:token>` header. It
splits out the username, loads the user by name, rejects a missing or blocked user, and compares
the presented token against `rest_api_authentication.settings:api_token` using the constant-time
`hash_equals()` function (avoiding timing side channels). The configured `api_token` is a single
site-wide value for this method.

## Token revoke endpoint

`/rest_api/revoke` (`rest_api_authentication.token_revoke`) is publicly routable
(`_access: 'TRUE'`); the controller itself enforces access: it flood rate-limits by client IP
(5 failed attempts per 300 seconds), requires a `Basic` Authorization header, verifies the
credentials via core `user.auth`, rejects blocked users, requires the HTTP method to be `POST`,
and then returns a premium-feature notice (actual revocation is a premium capability).

## Application-management controllers

`RestApiAuthenticationController::deleteApplication($app_id)` and `::setDefaultApplication($app_id)`
mutate the `applications` map in config. Both validate a CSRF token
(`rest_api_auth_delete_<app_id>` / `rest_api_auth_set_default_<app_id>`) from the `token` query
parameter and throw `AccessDeniedHttpException` on mismatch, in addition to the route's
`administer site configuration` permission.

## No hooks / plugins / drush

The module exposes no plugin type, no Drush commands, and no public API beyond this provider and
the logger service. To customize behavior you would decorate the provider service or the
validators. Premium methods (OAuth/JWT/external OAuth/headless SSO) call miniOrange services; the
free surface (enable flag, api_key/basic methods, audit logging) is self-contained.
