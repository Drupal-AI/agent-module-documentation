# Plugins — Oauth2Client and Oauth2GrantType

Two plugin types. Discovery is attribute-based (annotations also supported); plugins live in
`src/Plugin/Oauth2Client/` and `src/Plugin/Oauth2GrantType/`.

## 1. `oauth2_client` plugins (a provider definition)

Manager service `oauth2_client.plugin_manager` (id `oauth2_client`). Write a class extending
`Oauth2ClientPluginBase` with the `#[Oauth2Client(...)]` attribute
(`Drupal\oauth2_client\Attribute\Oauth2Client`). Attribute parameters:

| Param | Req | Meaning |
|---|---|---|
| `id` | ✓ | Plugin id (used in the config entity and the `oauth2_client.code` route). |
| `name` | ✓ | `TranslatableMarkup` human name. |
| `grant_type` | ✓ | One of `authorization_code`, `client_credentials`, `resource_owner`. |
| `authorization_uri` | ✓ | Provider authorize endpoint. |
| `token_uri` | ✓ | Provider token endpoint. |
| `resource_owner_uri` | — | Resource-owner details endpoint. |
| `scopes` | — | Default scopes array (null = none). |
| `scope_separator` | — | Default `,`. |
| `request_options` | — | Extra params merged into the token request. |
| `success_message` | — | Flag plugins may use to show a message on token store. |
| `collaborators` | — | Assoc array of League collaborator classes: `grantFactory`, `requestFactory`, `httpClient`, `optionProvider`. |
| `deriver` | — | Deriver class. |

The base class builds a `League\OAuth2\Client\Provider\GenericProvider` from those values
(`getProvider()`) and implements token retrieval/refresh logic in `getAccessToken()`.

### Token storage trait (pick one)

Each client plugin **must** use a storage trait that implements `storeAccessToken()` /
`retrieveAccessToken()` / `clearAccessToken()`:

- `StateTokenStorage` — one token in Drupal **State**, shared by all users (service-account style).
- `TempStoreTokenStorage` — token in the **private tempstore**, per-user (user-delegated style).

### Optional per-plugin interfaces

- `Oauth2ClientPluginRedirectInterface::getPostCaptureRedirect(): RedirectResponse` — where the
  user lands after the authorization code is captured.
- `Oauth2ClientPluginAccessInterface::codeRouteAccess(AccountInterface): AccessResultInterface` —
  access control on the `oauth2_client.code` capture route (default access is the module's
  `RouteAccess` check keyed on the plugin existing).

Minimal example (authorization code, shared token):

```php
#[Oauth2Client(
  id: 'my_provider',
  name: new TranslatableMarkup('My Provider'),
  grant_type: 'authorization_code',
  authorization_uri: 'https://provider.example/oauth/authorize',
  token_uri: 'https://provider.example/oauth/token',
)]
class MyProvider extends Oauth2ClientPluginBase {
  use StateTokenStorage;
}
```

## 2. `oauth2_grant_type` plugins (how a token is obtained)

Manager service `plugin.manager.oauth2_grant_type` (id `oauth2_grant_type`). Attribute
`#[Oauth2GrantType(id, label, description?, deriver?)]`; extend `Oauth2GrantTypePluginBase` and
implement `Oauth2GrantTypeInterface::getAccessToken(Oauth2ClientPluginInterface): ?AccessTokenInterface`.
Grants that need a username/password implement `GrantWithCredentialsInterface`
(`setUsernamePassword(OwnerCredentials)`), used by `resource_owner`.

Shipped grant plugins: `authorization_code`, `client_credentials`, `resource_owner`,
`refresh_token`. To replace an existing one, override its `class` via
`hook_oauth2_grant_type_info_alter()` (see hooks/alters.md).
