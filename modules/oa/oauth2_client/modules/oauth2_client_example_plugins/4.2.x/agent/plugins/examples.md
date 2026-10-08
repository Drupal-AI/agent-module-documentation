# The four example Oauth2Client plugins

All live in `src/Plugin/Oauth2Client/` and extend `Oauth2ClientPluginBase`. They exist to be
read/copied. (`ClientCredentialsExample.php` exists but is empty — there is no client_credentials
example plugin.)

## `authcode_example` — AuthCodeExample
```php
#[Oauth2Client(
  id: 'authcode_example',
  name: new TranslatableMarkup('Example for Authorization Code grant'),
  grant_type: 'authorization_code',
  authorization_uri: 'https://oauth.mocklab.io/oauth/authorize',
  token_uri: 'https://oauth.mocklab.io/oauth/token',
  success_message: TRUE,
)]
class AuthCodeExample extends Oauth2ClientPluginBase { use StateTokenStorage; }
```
Plainest case: authorization-code grant, one shared token in State, `success_message` on.

## `resource_owner_example` — ResourceOwnerExample
Same shape but `grant_type: 'resource_owner'`, endpoints on `http://example.com/oauth/token`,
`StateTokenStorage`. Shows the username/password grant (credentials passed to
`getAccessToken($id, $ownerCredentials)`).

## `authcode_redirect_example` — AuthCodeRedirectExample
`authorization_code` + `resource_owner_uri: 'https://oauth.mocklab.io/userinfo'`, uses
`TempStoreTokenStorage` (per-user token) and implements `Oauth2ClientPluginRedirectInterface`:
```php
public function getPostCaptureRedirect(): RedirectResponse {
  return new RedirectResponse(Url::fromRoute('<front>')->toString(TRUE)->getGeneratedUrl());
}
```
Shows how to control where the user lands after the code-capture route runs.

## `authcode_access_example` — AuthCodeAccessExample
`authorization_code`, `TempStoreTokenStorage`, implements `Oauth2ClientPluginAccessInterface`:
```php
public function codeRouteAccess(AccountInterface $account): AccessResultInterface {
  return AccessResult::allowedIfHasPermissions($account, ['access content']);
}
```
Shows how to gate the `oauth2_client.code` capture route per plugin.

**Storage trait takeaway:** State = one token shared by everyone (service account);
TempStore = a token per user (user-delegated access).
