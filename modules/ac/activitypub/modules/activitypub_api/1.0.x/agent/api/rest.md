<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ActivityPub API — REST/OAuth2 base

## Enable
`drush en activitypub_api` (pulls `rest`, `simple_oauth`). Configure at
`/admin/config/services/activitypub/api`. This module ships no client endpoints; it is a dependency
for API-exposing modules (e.g. `activitypub_mastodon_api`).

## Access model
`ActivityPubApiRestBase::getBaseRouteRequirements()` adds `_user_authenticated_and_has_actor_check` to
every resource route when `$addAccessCheckRequirement` is TRUE (the default). That check
(`\Drupal\activitypub\Access\AuthenticatedUserHasActorCheck`, tag `access_check`, applies_to
`_user_authenticated_and_has_actor_check`) requires the request's user to be authenticated **and** own
an `activitypub_actor`. Resources set `permissions()` to `[]` — access is the actor check + OAuth2
authentication, not a Drupal permission. A subclass can set `$addAccessCheckRequirement = FALSE` to
publish an anonymous endpoint (used by the Mastodon `apps` registration route, which instead gates on
its own permission).

## Request handling
`ActivityPubApiTrait::getRawBaseRoute()` routes to `RequestHandler::handleRaw` and sets
`_content_type_format: form|json`, so resources accept both `multipart/form-data` (file uploads) and
JSON. `handleFileUploads()` validates uploads with `getFileUploadValidators()` + a forced
`FileIsImage` check, honoring `file_maxsize`/`file_extensions`, and stores them under
`getUploadDirectory()` = `<file_directory>/<Y>/<m>`.

## OAuth2 helpers (`ActivityPubApiOauth2Trait`)
- `createConsumer($data)` creates a `consumer` entity with random `client_id`/`secret`
  (`Crypt::randomBytesBase64()`), `grant_types: ['authorization_code']`, the requested `scopes`
  (`authorization_code_scopes`), an optional `redirect`, and a very long `access_token_expiration`
  (`Settings::get('activitypub_api_access_token_expire_time', 99999999)` — Mastodon tokens do not
  expire). Returns `client_id`/`client_secret` once (the stored secret is hashed).
- `deleteOauth2Token($token)` deletes the token and, if the client has no remaining tokens, deletes the
  consumer too.

## OAuth token endpoint compatibility
`OauthTokenRequestBodyParser` (http_middleware, priority 201) rewrites a `POST /oauth/token` request
whose `Content-Type` is `application/json` into `application/x-www-form-urlencoded` + populated
`request` parameters, so Simple OAuth's token controller can process clients that send JSON. Enabled
only when `convert_oauth_access_token_requests` is TRUE (see `ActivitypubApiServiceProvider::alter()`).

## Config keys (`activitypub_api.settings`)
`convert_oauth_access_token_requests` (bool), `file_directory`, `file_extensions`, `file_maxsize`,
`instance_name`, `instance_description`, `instance_email`, `log_payloads`, `log_responses`,
`log_status_errors`, `log_unimplemented_endpoints`. Note: `log_payloads`/`log_responses` write full
request/response bodies to the logger at debug level — keep off in production.

## Per-user management
`ApiUserController::userApi()` lists the user's OAuth consumers/tokens at
`/user/{user}/activitypub/api`; `UserDeleteTokenConfirmForm` + route `activitypub_api.user.delete_token`
revoke one (access `userApiManageConnectionsAccess`, permission `manage activitypub api connections`).
