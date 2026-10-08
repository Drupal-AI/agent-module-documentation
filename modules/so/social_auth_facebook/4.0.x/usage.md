Social Auth Facebook lets users register and log in to a Drupal site with their Facebook (Meta) account. It is a Social Auth "network" implementation built on the Social API / Social Auth framework and the league/oauth2-facebook OAuth2 client.

---

The module registers a Social Auth **Network plugin** (`social_auth_facebook`, short name `facebook`) that wires Facebook's OAuth2 provider into Social Auth's shared login flow. Enabling it adds a login route `/user/login/facebook` (and OAuth callback `/user/login/facebook/callback`), a Facebook button in the Social Auth Login block, and a settings form at `/admin/config/social-api/social-auth/facebook` (a tab under *Social API → Social Auth → Facebook*), gated by the `administer social api authentication` permission from Social Auth. Credentials and options are stored in the `social_auth_facebook.settings` config object: `client_id` (the Facebook App ID), `client_secret` (App secret), `graph_version` (Facebook Graph API version, e.g. `17.0`, stored without the leading `v`), `scopes`, and `endpoints`. You create a Facebook app at Meta for Developers, copy the site's callback URL into the app's *Valid OAuth Redirect URIs*, and paste the App ID/secret into the settings form. At runtime the `FacebookAuthManager` service drives authentication (`authenticate()`, `getUserInfo()`, `getAuthorizationUrl()`, `requestEndPoint()`), Social Auth maps the returned Facebook profile to a Drupal user, and (when the Rules module is present) the module exposes `social_auth_facebook.user_login` and `social_auth_facebook.user_created` events. It depends on `social_auth` (and transitively `social_api`) and requires PHP 8.1+ and the `league/oauth2-facebook` library.

---

- Let visitors sign in to the site with their Facebook account (social login).
- Auto-register new Drupal users from their Facebook profile on first login.
- Add a "Log in with Facebook" button to the Social Auth Login block.
- Provide a one-click `/user/login/facebook` entry point for authentication.
- Store the Facebook App ID and secret in `social_auth_facebook.settings` for the OAuth flow.
- Pin the Facebook Graph API version used for requests via the `graph_version` setting.
- Request specific Facebook permission `scopes` during authorization.
- Configure which Graph API `endpoints` are called to fetch profile data.
- Copy the site's OAuth redirect/callback URL to register it in the Meta app.
- Restrict who can configure the integration with the `administer social api authentication` permission.
- Trigger a Rules reaction when a user logs in via Facebook (`social_auth_facebook.user_login`).
- Trigger a Rules reaction when a user is created via Facebook (`social_auth_facebook.user_created`).
- Offer Facebook alongside other Social Auth networks (Google, etc.) on one login block.
- Call `FacebookAuthManager::getAuthorizationUrl()` to build the Facebook authorization redirect.
- Fetch the authenticated user's Facebook profile with `FacebookAuthManager::getUserInfo()`.
- Query arbitrary Graph API paths via `FacebookAuthManager::requestEndPoint()`.
- Route Facebook logins through an outbound HTTP proxy (honored from site settings).
- Reduce password fatigue by delegating authentication to Facebook.
- Migrate app credentials by exporting/importing the `social_auth_facebook.settings` config.
- Present a branded Facebook logo (bundled SVG) on the login UI.
- Support decoupled/SSO scenarios where Facebook is the identity provider.
- Upgrade older 3.x sites: `app_id`/`app_secret` config keys are migrated to `client_id`/`client_secret`.
