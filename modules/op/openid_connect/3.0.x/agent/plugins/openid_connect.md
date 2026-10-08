# Plugin type — `openid_connect_client`

The module defines one plugin type: an **OpenID Connect client** (one per identity provider).

- Manager: `plugin.manager.openid_connect_client` (`Drupal\openid_connect\Plugin\OpenIDConnectClientManager`)
- Discovery dir: `src/Plugin/OpenIDConnectClient/`
- Interface: `Drupal\openid_connect\Plugin\OpenIDConnectClientInterface`
- Base class: `Drupal\openid_connect\Plugin\OpenIDConnectClientBase` (implements most methods)
- Annotation: `@OpenIDConnectClient` (`Drupal\openid_connect\Annotation\OpenIDConnectClient`) with `id` + `label`
- Alter hook: `hook_openid_connect_client_info_alter()` (alter id `openid_connect_client_info`)

Built-in clients: `generic` (Generic OAuth 2.0, with `.well-known` auto-discovery), `google`,
`okta`, `github`, `facebook`, `linkedin`.

## Implement a client

```php
namespace Drupal\my_module\Plugin\OpenIDConnectClient;

use Drupal\openid_connect\Plugin\OpenIDConnectClientBase;

/**
 * @OpenIDConnectClient(
 *   id = "my_idp",
 *   label = @Translation("My IdP")
 * )
 */
class MyIdpClient extends OpenIDConnectClientBase {

  // Required: return the three endpoint URLs.
  public function getEndpoints(): array {
    return [
      'authorization' => 'https://idp.example.com/authorize',
      'token'         => 'https://idp.example.com/token',
      'userinfo'      => 'https://idp.example.com/userinfo',
    ];
  }
}
```

The base class already implements `authorize()` (redirects to the authorization endpoint with a
CSRF `state` token and optional `prompt`), `retrieveTokens($code)` (exchanges the code at the
token endpoint), `retrieveUserInfo($access_token)`, `usesUserInfo()`, the client ID / secret /
`prompt` / `iss_allowed_domains` configuration form, and default scopes `['openid','email']`.

## Methods you may override

| Method | Purpose |
|---|---|
| `getEndpoints()` | **Required.** authorization / token / userinfo (+ optional `end_session`) URLs |
| `defaultConfiguration()` | Add provider-specific settings (merge with `parent::defaultConfiguration()`) |
| `buildConfigurationForm()` / `validate` / `submit` | Extra config fields (call parent first) |
| `getClientScopes()` | Override the default `['openid','email']` scope set |
| `authorize()` / `retrieveTokens()` / `retrieveUserInfo()` | Customize the OAuth flow if the provider deviates |

Add matching config schema under `openid_connect.client.plugin.{id}` (see the `*base` anchor in
`config/schema/openid_connect.schema.yml`) so your extra settings validate and export. Once the
class is discovered, the plugin appears on the client add form
(`/admin/config/people/openid-connect/add/{plugin_id}`).
