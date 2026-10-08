<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# azure_oauth_sso — login flow & token service

All handled by `Controller\OauthLogin` (uses the `BaseOAuth` trait) and
`Service\OAuthTokenService`. One controller method serves both legs of the OAuth dance on the same
route `/oauth/login` (`azure_oauth_sso.oauthLogin`, `_permission: access content`,
`no_cache: TRUE`).

## 1. Redirect to Azure

`OauthLogin::oauthLogin()`: if the request has no `code` and no `error` and the current user is
anonymous, it builds the Microsoft authorize URL and returns a `TrustedRedirectResponse`:

```
https://login.microsoftonline.com/<ad_tenant>/oauth2/v2.0/authorize
  ?client_id=<client_id>&response_type=code
  &redirect_uri=<host>/oauth/login&response_mode=query
  &scope=https://graph.microsoft.com/User.Read offline_access&state=<state>
```

Tenant/client come from `BaseOAuth::getAdTenant()` / `getClientId()`; the redirect URI is
`BaseOAuth::getRedirectUri()` = `<scheme+host>/oauth/login`. Scope requests Graph `User.Read` plus
`offline_access` (to obtain a refresh token). The `testOauthLogin()` method (`/oauth/test-login`,
used by the settings "Test Configuration" link) builds the same authorize URL.

## 2. Callback → token exchange

When Azure redirects back with `?code=…`, the same `oauthLogin()` method (if the user is still
anonymous) calls `generateToken()`:

```php
$res = $client->post(
  'https://login.microsoftonline.com/' . $this->getAdTenant() . '/oauth2/v2.0/token', [
    'form_params' => [
      'grant_type'    => 'authorization_code',
      'client_id'     => $this->getClientId(),
      'redirect_uri'  => $this->getRedirectUri(),
      'code'          => $this->authCode,
      'client_secret' => $this->getClientSecret(),
    ],
  ]
);
```

On success it stores `$this->accessToken = 'Bearer ' . access_token` and
`$this->refreshToken = refresh_token`. A 400/401 response redirects back to `/oauth/login`. The
client is a plain `new GuzzleHttp\Client()` (default TLS verification).

## 3. Match or provision the Drupal user — `loginUser()`

1. `getPersonalData()` calls Microsoft Graph `GET /v1.0/me?$select=…` (via
   `OAuthTokenService::apiCall()`, `Authorization: <accessToken>`), selecting the mapped Graph
   properties plus `displayName,department`. Returns the decoded profile (`$apiRes`).
2. **Match by email**: `$email = $apiRes['mail']`; an entity query on `user.mail` (with
   `accessCheck(TRUE)`) is run.
   - **Found** → load the user, copy any mapped Graph properties whose value changed onto the
     Drupal fields (`azure_oauth_sso.fields_mapping.custom_attr_table`), set `field_access_token`
     and `field_refresh_token`, `save()`, then `user_login_finalize()`.
   - **Not found** → provision: resolve a role from `roles_mapping` (`ad_group` → the group object
     ID returned by `getRolesPerGroup()`, or `department_field` → the `department` value; else
     `default_role`), `create()` a user from the mapped Graph values, `addRole($role)`,
     `status = 1`, store both tokens, `save()`, `user_login_finalize()`.
3. Finally the callback returns a `RedirectResponse` to `<front>`.

`getRolesPerGroup()` calls Graph
`GET /me/transitiveMemberOf/microsoft.graph.group?$count=true` and returns the last group `id`.

## 4. Profile photo (optional)

If `fields_mapping.user_picture == 1`, `getMyPhoto()` fetches `GET /me/photo/$value`, writes it
under the `user_picture` field's file directory, compares MD5 against the current picture
(`areImagesDifferent()`), and, if changed, saves a `File` entity and sets it on the user.

## Token service — `Service\OAuthTokenService`

Service id `azure_oauth_sso.token_service` (args `@current_user`, `@entity_type.manager`,
`@config.factory`).

- `getToken()` — returns the current user's `field_refresh_token` value.
- `refreshToken()` — POSTs `grant_type=refresh_token` (+ `client_id`, `client_secret`, stored
  `refresh_token`) to the `/oauth2/v2.0/token` endpoint, updates `field_access_token` /
  `field_refresh_token` on the user, and returns the new `Bearer …` token.
- `apiCall($url, $params, $method)` — generic Guzzle request; on a 400/401 it calls
  `refreshToken()` once and retries with the fresh `Authorization` header. Image responses are
  returned as raw body bytes, otherwise JSON-decoded.

Retrieve a token in custom code:

```php
$token = \Drupal::service('azure_oauth_sso.token_service')->getToken();
```

## Logout (optional)

`azure_oauth_sso.module`: with `enable_sso_logout`, `hook_user_logout` clears both token fields and
redirects to Microsoft's `/common/oauth2/v2.0/logout`. With `options_login == 'redirect'`,
`hook_preprocess_page` redirects `/user/login` straight into `/oauth/login`, and
`hook_menu_links_discovered_alter` points logout at `azure_oauth_sso_custom_logout()`.
