# API — the runtime token service

Service id **`oauth2_client.service`** → `Oauth2ClientServiceInterface`
(`Drupal\oauth2_client\Service\Oauth2ClientService`). This is what application code calls.

```php
/** @var \Drupal\oauth2_client\Service\Oauth2ClientServiceInterface $svc */
$svc = \Drupal::service('oauth2_client.service');

$plugin = $svc->getClient('my_provider');            // Oauth2ClientPluginInterface (throws InvalidOauth2ClientException if unknown)
$token  = $svc->getAccessToken('my_provider', NULL); // AccessTokenInterface|null — existing valid token, or fetch/refresh a new one
$token  = $svc->retrieveAccessToken('my_provider');  // read from storage only, no fetch
$svc->clearAccessToken('my_provider');               // delete the stored token
```

`getAccessToken($pluginId, ?OwnerCredentials $credentials)` — for the `resource_owner`
(password) grant, pass a `Drupal\oauth2_client\OwnerCredentials` value object (username +
password); other grants pass `NULL`.

## Token lifecycle (in `Oauth2ClientPluginBase::getAccessToken()`)

1. Read the stored token (via the plugin's storage trait).
2. If present and not expired → return it.
3. If expired but has a refresh token → use the `refresh_token` grant to get a new one.
4. If expired with no refresh token and grant is `authorization_code`/`resource_owner` →
   throw `NonrenewableTokenException` (interactive re-auth needed).
5. Otherwise run the plugin's grant to fetch a new token, then `storeAccessToken()`.

## Credentials at runtime

The plugin never hard-codes client id/secret. `CredentialProvider`
(`oauth2_client.service.credentials`) loads them from the matching `oauth2_client` **config
entity**: if `credential_provider === 'key'` it reads a Key entity's values; otherwise
(`oauth2_client`) it reads `\Drupal::state()->get($credential_storage_key)`. Expected keys:
`client_id`, `client_secret`.

## Interactive (authorization_code) redirect capture

- The provider must redirect back to route **`oauth2_client.code`**
  (`/oauth2-client/{plugin}/code`), whose absolute URL is `Oauth2ClientPluginBase::getRedirectUri()`
  — register that as the provider's callback/redirect URL.
- `Controller\OauthResponse::code` handles the callback, stores the token, and (if the plugin
  implements `Oauth2ClientPluginRedirectInterface`) follows `getPostCaptureRedirect()`.
- Route access is the `_oauth2_client_route_access` check (`Access\RouteAccess`); a plugin can
  further restrict it via `Oauth2ClientPluginAccessInterface::codeRouteAccess()`.

## Exceptions

`InvalidOauth2ClientException` (unknown plugin id), `NonrenewableTokenException` (interactive
token expired, no refresh), `AuthCodeRedirect` (control-flow to send the user to the provider).
