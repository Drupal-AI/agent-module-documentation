# Social Auth Facebook — agent index

Facebook (Meta) OAuth2 login for Drupal, built on Social Auth / Social API. Adds
`/user/login/facebook`, a settings form, and a Facebook button in the Social Auth Login block.
Depends on `social_auth` (+ `social_api`); needs the `league/oauth2-facebook` library (PHP 8.1+).
No plugin types or Drush of its own; permission comes from Social Auth.

- **Settings config (`client_id`, `client_secret`, `graph_version`, `scopes`, `endpoints`), route, permission, URLs** →
  [configure/settings.md](configure/settings.md)
- **The Social Auth Network plugin + `FacebookAuthManager` auth flow, and Rules events** →
  [api/network-and-manager.md](api/network-and-manager.md)

Key facts:
- Config object `social_auth_facebook.settings` (keys above). **No `config/install`** — the object
  does not exist until the settings form is saved (or you create it).
- Settings form route `social_auth_facebook.settings_form` →
  `/admin/config/social-api/social-auth/facebook`, permission `administer social api authentication`.
- Login URL `/user/login/facebook`; OAuth callback `/user/login/facebook/callback` (register it as
  the Valid OAuth Redirect URI in the Meta app).
- Network plugin id `social_auth_facebook` (short name `facebook`), OAuth provider
  `League\OAuth2\Client\Provider\Facebook`, auth manager `FacebookAuthManager`.
- `graph_version` is stored **without** the leading `v` (form strips it); must match e.g. `17.0`.
