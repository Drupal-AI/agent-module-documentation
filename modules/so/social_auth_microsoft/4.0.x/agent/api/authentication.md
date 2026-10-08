<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Authentication flow, network plugin & auth manager

Social Auth Microsoft contributes only the Microsoft-specific pieces; the request handling,
session, account matching and login are all done by the base `social_auth` controller and services.

## The `@Network` plugin

`src/Plugin/Network/MicrosoftAuth.php` — `class MicrosoftAuth extends NetworkBase {}` with an
`@Network` annotation (a `social_api` Network plugin, discovered by `plugin.network.manager`):

- `id = "social_auth_microsoft"`, `short_name = "microsoft"`, `social_network = "Microsoft"`, `type = "social_auth"`.
- `class_name = "\Stevenmaguire\OAuth2\Client\Provider\Microsoft"` — the League OAuth2 provider instantiated by `NetworkBase::initSdk()` with `clientId` / `clientSecret` / `redirectUri` from config.
- `auth_manager = "\Drupal\social_auth_microsoft\MicrosoftAuthManager"`.
- `routes` map: `redirect` → `social_auth.network.redirect`, `callback` → `social_auth.network.callback`, `settings_form` → `social_auth.network.settings_form`.
- `handlers.settings` → `SettingsBase` with `config_id = "social_auth_microsoft.settings"`.

There is no `initSdk()` override, so the base builds the client from config only (no extra provider
options such as tenant are passed).

## The auth manager service

`social_auth_microsoft.manager` → `Drupal\social_auth_microsoft\MicrosoftAuthManager`
(extends `Drupal\social_auth\AuthManager\OAuth2Manager`). Constructor args:
`@config.factory`, `@logger.factory`, `@request_stack` — it reads config object
`social_auth_microsoft.settings`. Overridden methods:

| Method | What it does |
|--------|--------------|
| `getAuthorizationUrl()` | Base scopes `['wl.basic', 'wl.emails']`, merges any comma-separated extra `scopes` from config, then `client->getAuthorizationUrl(['scope' => …])`. |
| `authenticate()` | Exchanges `?code` for a token: `client->getAccessToken('authorization_code', ['code' => request->query->get('code')])`; logs `IdentityProviderException` to channel `social_auth_microsoft`. |
| `getUserInfo()` | `client->getResourceOwner($token)` (a `MicrosoftResourceOwner` from `apis.live.net/v5.0/me`) → builds a `SocialAuthUser(name, id, token, email, NULL picture, extraDetails)`. `email` is `emails.preferred`, `id` is the account id. |
| `requestEndPoint($method,$path,…)` | Authenticated call to `https://graph.microsoft.com{path}` for the configured extra `endpoints`. |
| `getState()` | Returns `client->getState()` (the League provider's generated OAuth state). |

## End-to-end flow (handled by base `social_auth`)

1. User hits `/user/login/microsoft` → `OAuth2ControllerBase::redirectToProvider()` builds the
   authorization URL via the manager, stores the OAuth `state` in the session, and issues a
   `TrustedRedirectResponse` to `login.live.com`.
2. Microsoft returns to `/user/login/microsoft/callback` → `OAuth2ControllerBase::callback()` →
   `processCallback()`: it compares the returned `state` against the session value, then
   `authenticate()`s, pulls `getUserInfo()`, and hands the `SocialAuthUser` to
   `social_auth.user_authenticator`.
3. `UserAuthenticator::authenticateUser()` resolves the Drupal account in this order:
   - by **provider id** — `getDrupalUserId($providerId)` looks up the `social_auth` entity record
     for this Microsoft account id; if found, log that user in;
   - else, if the profile has an email, **by email** — `loadUserByProperty('mail', $email)`; if a
     Drupal user with that address exists, add a `social_auth` record linking this Microsoft account
     to it and log in;
   - else **create** a new user (`UserManager::createNewUser()`) — random password, username derived
     from the Microsoft name, status per site registration settings — and log in.
   - If the visitor is already logged in and this Microsoft account is new, it is **associated** with
     the current account instead.
   Registration is skipped (error shown) when `user.settings:register = admin_only` or
   `social_auth.settings:user_allowed = login`. User 1 and configured roles can be blocked via
   `social_auth.settings`.

## Events (from base `social_auth`) you can subscribe to

`SocialAuthEvents::USER_CREATED`, `USER_LOGIN`, `USER_FIELDS` (alter the fields of a new account),
`BEFORE_REDIRECT`, `FAILED_AUTH`. The Microsoft record's `additional_data` holds whatever the
configured `endpoints` returned.

## Stored account link

Each successful match/creation writes a `social_auth` content entity row
(`plugin_id = social_auth_microsoft`, `provider_user_id`, `user_id`, `token`, `additional_data`).
A user's linked providers are listed at `/user/{user}/social-auth/profiles`.
