<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AWS Cognito service, token validation, token storage & Drush

## Service wiring (`cognito.services.yml`)

- `cognito.cognito_identity_provider` — `Aws\CognitoIdentityProvider\CognitoIdentityProviderClient`,
  built by `CognitoIdentityProviderClientFactory::create(@settings)`.
- `cognito.aws` — `Aws\Cognito`, built by `CognitoFactory::create(@settings, @cognito.cognito_identity_provider, @http_client)`.
  Injects the AWS client, `client_id`, `user_pool_id`, and Drupal's Guzzle `http_client`.
- `cognito.token` — `CognitoToken(@user.data, @cognito.aws, @current_user, @datetime.time)`.
- `cognito.messages` — `CognitoMessages(@config.factory)`.
- `plugin.manager.cognito.cognito_flow` — `CognitoFlowManager`.

## `Aws\Cognito` (extends `CognitoBase`)

Each public method wraps an AWS SDK call in `CognitoBase::wrap()`, which returns a
`Aws\CognitoResult` and **swallows** both `CognitoIdentityProviderException` and generic
`\Exception`, packaging the exception into `new CognitoResult(NULL, $e)`. Callers branch on
`->hasError()` / `->getErrorCode()` (AWS error code, e.g. `UsernameExistsException`,
`PasswordResetRequiredException`) / `->isChallenge()` (a `ChallengeName` such as
`NEW_PASSWORD_REQUIRED`).

Key methods:

- `authorize($username, $password)` → `adminInitiateAuth` with `AuthFlow: ADMIN_NO_SRP_AUTH`; on
  success **validates the returned `IdToken`** (see below) and throws if it fails to validate
  (caught by `wrap()` → error result).
- `refreshAccessToken($refreshToken)` → `adminInitiateAuth` with `AuthFlow: REFRESH_TOKEN_AUTH`;
  also validates the new `IdToken`.
- `signUp`, `resendConfirmationCode`, `confirmSignup`, `forgotPassword`, `confirmForgotPassword`,
  `changePassword($accessToken, …)`, `getUser($accessToken)`, `updateUserAttributes`,
  `verifyUserAttribute`, `getUserAttributeVerificationCode` — user-scoped calls (email as username).
- `adminGetUser`, `adminSignup` (`adminCreateUser`, `DesiredDeliveryMediums: [EMAIL]`),
  `adminEnableUser`, `adminDisableUser`, `adminUpdateUserAttributes`,
  `adminRespondToNewPasswordChallenge` — pool-admin calls using the configured `user_pool_id`.

Note `adminUpdateUserAttributes()` always additionally sets `email_verified => 'true'` (there is a
standing `@TODO` in source not to auto-verify — `drupal.org/node/2907479`). It is only reachable
from a user editing their own email (with their current password) or an admin with
`administer users`.

## ID-token validation (`validateToken()`)

Called on every `authorize`/`refreshAccessToken`. Steps:

1. `\JOSE_JWT::decode($idToken)` (from `gree/jose`) and read the header `kid`.
2. `GET https://cognito-idp.{region}.amazonaws.com/{user_pool_id}/.well-known/jwks.json` via
   Drupal's Guzzle `http_client` (default TLS verification; the URL is built from server config,
   not from the token). Non-200 → returns FALSE. There is a `@TODO` noting the JWKS could be cached
   — currently it is fetched on every auth.
3. Find the JWKS key whose `kid` matches the token header, convert the JWK to a PEM public key
   (`\JOSE_JWK::toKey()`), and call `$jwt->verify($public_key, 'RS256')`. The algorithm is pinned to
   **RS256** (guards against `alg: none`/HS confusion). A signature failure throws
   `JOSE_Exception_VerificationFailed`, propagated out and caught by `wrap()`. If no `kid` matches,
   returns FALSE → the caller throws "Token failed to validate".

The signature **is** cryptographically verified against the pool's JWKS. The validator does not
additionally assert the `iss`/`aud`/`exp`/`token_use` claims, but in every code path the token
being validated is the one AWS just returned over the SDK's TLS channel in response to an
authenticated admin auth call — it is never a client-supplied token. Clients never submit an ID
token to this module for validation.

## `CognitoToken` (token storage)

Stores tokens from an `AuthenticationResult` in `user.data` under module `cognito`, keyed by the
**current user's uid**:

- `AccessToken` and `IdToken` stored as `['token' => …, 'expires' => now + ExpiresIn]`;
  `RefreshToken` stored raw.
- `getAccessToken()` / `getIdToken()` return the stored token if unexpired; otherwise call
  `cognito.aws->refreshAccessToken(storedRefreshToken)`, re-store, and return the fresh one.
- `adminGetAccessToken($uid)` reads another uid's stored access token (used by other code paths);
  `adminDeleteAuthTokens($uid)` clears Access + Refresh tokens.

Tokens live only in the `users_data` table (server-side); they are exposed to the browser only
through the `cognito_auth_token` REST resource, which returns **the current user's own** tokens
(see [api/http-and-rest.md](../api/http-and-rest.md)). No token is placed in a URL, redirect, or
log by this module.

## Drush — `cognito:diff-users` (alias `diff-users`)

`Commands/CognitoCommands::report($cognitoUserFile)` (`drush.services.yml`). Reads a JSON file
exported from Cognito, extracts each user's `email` attribute, queries `users_field_data.mail`, and
prints two tables: Drupal users absent from Cognito, and Cognito users absent from Drupal. Read-only
reconciliation aid; the file path is resolved relative to CWD if not absolute. CLI-only.
