# Social Auth LinkedIn — agent index

Adds LinkedIn OAuth2 login/registration to Drupal as a [Social Auth](https://www.drupal.org/project/social_auth)
network plugin. Provides `/user/login/linkedin`, a LinkedIn button in the Social Auth login block,
and a settings form for the OAuth2 client id/secret. Depends on `social_auth` (and Social API);
external lib `league/oauth2-linkedin`. No permissions of its own, no Drush. Provides a config schema.

- **Set up the LinkedIn app + settings form, config keys, callback URL, scopes (legacy vs OIDC)** →
  [configure/settings.md](configure/settings.md)
- **The Network plugin & OAuth2 manager: login flow, what's inherited from social_auth, extending** →
  [api/auth-manager.md](api/auth-manager.md)

Key facts:
- Network plugin `LinkedInAuth` (`@Network id="social_auth_linkedin", short_name="linkedin"`) →
  `class_name = \League\OAuth2\Client\Provider\LinkedIn`, `auth_manager = LinkedInAuthManager`.
- Config object `social_auth_linkedin.settings`: `client_id`, `client_secret`, `scopes`, `endpoints`.
- Settings UI is Social Auth's generic form: route `social_auth.network.settings_form` / network `linkedin`
  (info.yml `configure` points at the legacy `social_auth_linkedin.settings_form`). Path:
  *Configuration » User authentication » LinkedIn* (`admin/config/social-api/social-auth/linkedin`).
- Redirect, callback, CSRF/state validation, user matching & account creation live in `social_auth`.
- Default scopes `r_liteprofile`, `r_emailaddress` are LinkedIn **legacy** scopes (see configure doc).
