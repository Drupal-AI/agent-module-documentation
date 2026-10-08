# Network plugin, auth manager & Rules events

## Social Auth Network plugin

`Drupal\social_auth_facebook\Plugin\Network\FacebookAuth` (extends Social Auth's
`NetworkBase`). It is a plugin of the **Social Auth `Network` type** (defined by `social_api` /
`social_auth`), not a new plugin type. Annotation:

```php
@Network(
  id = "social_auth_facebook",
  short_name = "facebook",
  social_network = "Facebook",
  img_path = "img/facebook_logo.svg",
  type = "social_auth",
  class_name = "\League\OAuth2\Client\Provider\Facebook",
  auth_manager = "\Drupal\social_auth_facebook\FacebookAuthManager",
  routes = { redirect / callback / settings_form -> social_auth.network.* },
  handlers = { settings: { class: FacebookAuthSettings, config_id: "social_auth_facebook.settings" } }
)
```

`initSdk()` builds a `League\OAuth2\Client\Provider\Facebook` from `client_id`, `client_secret`,
the computed `redirectUri`, and `graphApiVersion = 'v' . graph_version` (adds an outbound proxy
from `http_client_config` if set). `validateConfig()` fails if `graph_version` is empty.

## `FacebookAuthManager` service (`social_auth_facebook.manager`)

Drives the OAuth handshake within Social Auth's flow. Public methods:

- `getAuthorizationUrl(): string` — the Facebook authorization URL to redirect the user to.
- `authenticate(): void` — exchange the returned code for an access token.
- `getUserInfo(): ?SocialAuthUserInterface` — the authenticated Facebook profile mapped for
  Social Auth (id, name, email, picture…).
- `requestEndPoint(string $method, string $path, ?string $domain = NULL, array $options = []): mixed`
  — call an arbitrary Graph API path with the access token.
- `getState(): string` — the OAuth2 state parameter (CSRF).

Typical use is automatic: Social Auth's controllers call these during
`/user/login/facebook` → `/user/login/facebook/callback`. Call them directly only for custom
flows.

## Settings handler

`Drupal\social_auth_facebook\Settings\FacebookAuthSettings` (config_id
`social_auth_facebook.settings`) exposes `getClientId()`, `getClientSecret()`, `getGraphVersion()`
etc. to the Network plugin.

## Rules events (only when the `rules` module is enabled)

Declared in `social_auth_facebook.rules.events.yml`:

- `social_auth_facebook.user_login` — "User has logged in via Facebook login" (context: `account`).
- `social_auth_facebook.user_created` — "User has been created via Facebook login" (context: `account`).

React to these in a Rules configuration to run actions on Facebook login/registration.
