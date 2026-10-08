# Social Auth Apple — auth flow & extension points

## Network plugin (`Plugin\Network\AppleAuth`)

`@Network` id `social_auth_apple`, short_name `apple`, type `social_auth`, wraps
`\League\OAuth2\Client\Provider\Apple`, auth_manager `AppleAuthManager`, button image
`img/apple_logo.svg`. Routes map: redirect → `social_auth.network.redirect`, callback →
`social_auth_apple.callback`, settings_form → `social_auth_apple.settings_form`.
`getExtraSdkSettings()` supplies `teamId` / `keyFileId` / `keyFilePath` to the provider.

## The POST→GET callback quirk (`Controller\AppleAuthController::callback()`)

Apple uses `response_mode=form_post` when `name`/`email` scopes are requested, so it **POSTs** to
the callback, but Social Auth's `OAuth2ControllerBase::callback()` reads from GET. The override:

```php
if ($request->isMethod('POST')) {
  $url = Url::createFromRequest($request)->mergeOptions(['query' => $request->request->all()]);
  return new RedirectResponse($url->toString());   // 302 back to same path as GET
}
return parent::callback($network);                  // normal Social Auth handling
```

So Apple's POST body (`code`, `state`, `user`, …) is bounced into the query string and re-entered
as a GET. `state` (CSRF) is then validated normally by the base controller (see below).

## State / CSRF validation (inherited, not overridden here)

`social_auth`'s `OAuth2ControllerBase::processCallback()` stores `oauth2state` in the session on
redirect and, on callback, rejects the request with "Invalid OAuth2 state" when the returned
`state` query param is empty or does not match. `AppleAuthManager::getState()` returns the League
client's state. This module does not weaken that check.

## `AppleAuthManager` (service `social_auth_apple.manager`)

Extends `social_auth`'s `OAuth2Manager`. Constructor args: `@config.factory`, `@logger.factory`,
`@request_stack`. Overrides:

| Method | Behavior |
|---|---|
| `authenticate()` | Exchanges the `code` query param for an access token (`authorization_code` grant); logs errors to channel `social_auth_apple`. |
| `getUserInfo()` | Builds a `SocialAuthUser` from the Apple resource owner: name = first (+ last) name or email fallback, id, token, email, extra details. Sets first/last name. |
| `getAuthorizationUrl()` | Default scopes `['name','email']`, merged with any comma-separated extra `scopes` config. |
| `requestEndPoint($method,$path,$domain=null,$options=[])` | Authenticated request to `$domain` (default `https://appleid.apple.com`) + `$path`; returns parsed response or logs an `IdentityProviderException`. |
| `getState()` | Returns the client state (used for CSRF validation). |

## Extending

- Decorate/subclass `AppleAuthManager` to change how Apple profile fields map to Drupal users (override `getUserInfo()`).
- User matching/creation, redirect-after-login, and session keys are all handled by Social Auth's `UserAuthenticator` / `OAuth2ControllerBase` — configure those in the Social Auth settings, not here.
