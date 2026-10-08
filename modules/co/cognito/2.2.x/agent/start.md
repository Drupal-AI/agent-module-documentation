<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Amazon Cognito (cognito) — agent index

Replaces Drupal's native account/auth flows with **Amazon Cognito user-pool** flows. When enabled,
registration, login, password reset, email change and account block/enable all proxy to Cognito
through the **AWS SDK** (`aws/aws-sdk-php`), and local Drupal accounts are created/linked via the
**External Authentication** (`externalauth`) module. It is **not** a redirect/OAuth SSO client — it
uses the server-side `ADMIN_NO_SRP_AUTH` username(email)/password admin flow against a user pool.
Package `Authentication`. Core `^10.1 || ^11`. License GPL-2.0-or-later. Installed **2.2.0**
(version dir `2.2.x`).

## Dependencies

- Drupal module: **`externalauth:externalauth`** (required; also a test dependency). No submodules.
- PHP libraries (`composer.json`): **`aws/aws-sdk-php` `~3.32`**, **`gree/jose` `^2.2`** (JWT
  decode/verify), **`php >=5.6`**.

## Configuration model (important)

The AWS connection is **not** an admin form — it lives in `settings.php` as `$settings['cognito']`
(`region`, `credentials.key`, `credentials.secret`, `user_pool_id`, `client_id`), read by
`CognitoIdentityProviderClientFactory` and `CognitoFactory`. The only admin route
(`/admin/config/people/cognito/settings`, permission `administer cognito`) edits **UI message
strings** and nothing about the AWS connection. The default flow requires an app client **without**
a generated client secret and with `ADMIN_NO_SRP_AUTH` enabled (per README).

## What it provides (from source)

- **AWS service** `cognito.aws` (`Aws\Cognito`, via `CognitoFactory`) — thin wrappers over
  `CognitoIdentityProviderClient`: `authorize`, `refreshAccessToken`, `signUp`, `confirmSignup`,
  `forgotPassword`, `confirmForgotPassword`, `changePassword`, `adminSignup`/`adminCreateUser`,
  `adminEnableUser`/`adminDisableUser`, `adminUpdateUserAttributes`, `adminRespondToNewPasswordChallenge`,
  `getUser`/`updateUserAttributes`, `verifyUserAttribute`, and **ID-token validation** against the
  pool's JWKS.
- **Token service** `cognito.token` (`CognitoToken`) — stores Access/Id/Refresh tokens in
  `user.data` keyed by uid, auto-refreshes expired tokens.
- **Form overrides** — a `RouteSubscriber` + `hook_entity_type_alter` swap the core `user.login`,
  `user.pass`, `user.admin_create` forms and the user register/profile/admin-register form classes
  for Cognito equivalents (`Form/Email/*`), selected by the **`CognitoFlow`** plugin type (only
  `Email` flow ships).
- **HTTP/REST surface** — HTTP JSON login controller (`/cognito/user/login`), REST resources
  `cognito_user_registration` (`POST /cognito/user/register`) and `cognito_auth_token`
  (`GET /cognito/auth-token`), and anonymous confirm / authenticated verify-email callbacks.
- **Permission** `administer cognito` (`restrict access: true`). **Config** `cognito.settings`
  (two booleans + seven message strings) with schema. **Drush** `cognito:diff-users` (diff a
  Cognito user-export file against Drupal users). Menu link under People admin. No install/update
  hooks; one hook (`hook_entity_type_alter`).

## Solution docs

- **settings.php connection, `cognito.settings` config, messages, permission, plugin type** →
  [config/settings.md](config/settings.md)
- **AWS Cognito service, JWT/JWKS validation, token storage/refresh, Drush** →
  [services/aws-cognito.md](services/aws-cognito.md)
- **Overridden auth forms, flow plugin, route subscriber, `hook_entity_type_alter`** →
  [forms/auth-flow.md](forms/auth-flow.md)
- **HTTP login controller, REST resources, confirm/verify-email callbacks, routing** →
  [api/http-and-rest.md](api/http-and-rest.md)
