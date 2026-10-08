# Configuration

OpenID Connect HarID has no settings page of its own — you configure it as a
**client** inside the OpenID Connect module. Everything below happens in the
OpenID Connect admin UI.

## Add a HarID client

1. Go to **Configuration → People → OpenID Connect**
   (`/admin/config/people/openid-connect`).
2. Add a new client and choose **HarID** as the client type
   (`/admin/config/people/openid-connect/add/harid`).

## Fill in the client form

On the HarID client form you'll find the standard OpenID Connect fields plus
three HarID-specific checkboxes:

- **Client ID** (`client_id`) — the client id HarID issued for your service.
- **Client secret** (`client_secret`) — the matching secret from HarID. Enter it
  here in the client configuration; keeping it in config (rather than in code)
  keeps the credential out of your repository. If you manage secrets through
  environment variables, supply the value from there.
- **Redirect URL** — shown on the form. Copy this into your HarID service
  registration (see https://harid.ee/en/pages/dev-info) so HarID will accept the
  return trip.
- **Require strong session** (`require_strong_session`, default off) — when
  ticked, the login must come through a strong ID-card / Mobile-ID / Smart-ID
  session; the module adds the `session_type` scope to the request and blocks any
  login that isn't strong.
- **Require personal code** (`require_personal_code`, default off) — when ticked,
  the HarID account must carry a personal identity code; the module adds the
  `personal_code` scope and blocks accounts without one.
- **Use test IdP** (`use_test_idp`, default off) — when ticked, the client talks
  to `test.harid.ee` instead of the live `harid.ee`. Turn it on for development,
  off for production.

Save the client. The requested scopes are always `openid profile email roles`,
with `session_type` and/or `personal_code` added automatically when you enable the
matching requirement.

## Setting options from the command line

The same options can be set with Drush, for example:

```bash
drush cset openid_connect.settings.harid settings.require_strong_session true -y
```

## What happens at login

- Before a login is accepted, the module denies it if you required a strong
  session but the session isn't strong, or if you required a personal code but the
  account has none.
- On every successful HarID login, the module sets the Drupal user's language from
  HarID's `ui_locales` when that language is enabled on your site.

Account matching, registration, and all the token and CSRF handling are done by
the OpenID Connect module — configure those (how HarID users map to Drupal
accounts, whether new accounts are created, and so on) in OpenID Connect's own
settings.

## Show the login button

Place the **OpenID Connect login** block where you want the HarID button to
appear (for example on the user login form), and HarID will be offered as a login
option.
