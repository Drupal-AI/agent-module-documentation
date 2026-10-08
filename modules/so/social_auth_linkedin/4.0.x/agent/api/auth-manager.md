# Network plugin & OAuth2 manager

The module is two small classes plus a config object; the login machinery is inherited from
`social_auth` / `social_api`.

## Network plugin — `src/Plugin/Network/LinkedInAuth.php`

```php
@Network(
  id = "social_auth_linkedin",
  short_name = "linkedin",
  social_network = "LinkedIn",
  img_path = "img/linkedin_logo.svg",
  type = "social_auth",
  class_name = "\League\OAuth2\Client\Provider\LinkedIn",   // the OAuth2 client
  auth_manager = "\Drupal\social_auth_linkedin\LinkedInAuthManager",
  routes = {
    "redirect": "social_auth.network.redirect",
    "callback": "social_auth.network.callback",
    "settings_form": "social_auth.network.settings_form",
  },
  handlers = { "settings": { "class": "\Drupal\social_auth\Settings\SettingsBase",
                             "config_id": "social_auth_linkedin.settings" } }
)
class LinkedInAuth extends NetworkBase {}
```

The class body is empty — `NetworkBase` builds the `league` LinkedIn client from the config object's
`client_id`/`client_secret` and the callback URL. The `redirect`/`callback` routes are **owned by
`social_auth`**, so state/CSRF validation, user lookup, account creation and login all happen there;
this module does not implement its own controller.

## OAuth2 manager — `src/LinkedInAuthManager.php`

Extends `social_auth`'s `OAuth2Manager`. Constructed with `config.factory`, `logger.factory`,
`request_stack` (service `social_auth_linkedin.manager`). Key methods:

| Method | Behaviour |
|---|---|
| `getAuthorizationUrl()` | Requests scopes `['r_liteprofile','r_emailaddress']` plus comma-separated `scopes` from config; returns the LinkedIn authorize URL. |
| `authenticate()` | Exchanges `?code=` (from the callback request) for an access token via `getAccessToken('authorization_code', …)`; logs errors to the `social_auth_linkedin` channel. |
| `getUserInfo()` | Builds a `SocialAuthUser` from the LinkedIn resource owner: full name, id, token, email, avatar, plus first/last name. |
| `requestEndPoint($method,$path,$domain=null,$options=[])` | Authenticated API call (default domain `https://api.linkedin.com`); returns parsed response or NULL on error. |
| `getState()` | Delegates to the league client's CSRF `state`. |

## Login flow (end to end)

1. User hits `/user/login/linkedin` → `social_auth`'s redirect controller sends them to LinkedIn's
   authorize URL (`getAuthorizationUrl()`), storing an anti-CSRF `state`.
2. LinkedIn redirects back to `/user/login/linkedin/callback` → `social_auth`'s callback controller
   validates `state`, then calls `authenticate()` + `getUserInfo()`.
3. `social_auth` matches the LinkedIn id/email to an existing user or creates a new account, then logs
   them in. Failures are logged to dblog under `social_auth_linkedin`.

## Extending

- Add scopes/endpoints: use the config object (see configure/settings.md), no code.
- Call the LinkedIn API for an authenticated user: inject `social_auth_linkedin.manager` and use
  `requestEndPoint()` after a token is set.
- To support LinkedIn's OpenID Connect product you would need a different provider `class_name`
  and scopes — not configurable in this module as shipped.
