# miniOrange OAuth Login (OAuth2/OIDC client) — agent index

Makes Drupal an OAuth 2.0 / OpenID Connect **client**. Users authenticate at an external
provider (Entra ID, Keycloak, Okta, Google, Cognito, …) via the Authorization Code flow; the
module matches the returned email to an existing Drupal user and logs them in. Free version:
one provider, existing users only (no auto-create). Config route `oauth_login_oauth2.config_clc`.
No module-defined permissions (admin pages use core `administer site configuration`); no Drush.

- **Configure the provider, every settings key, the routes/endpoints, and the login/callback flow** →
  [configure/settings.md](configure/settings.md)

Key facts:
- Settings live in config object `oauth_login_oauth2.settings` (schema `oauth_login_oauth2.schema.yml`).
- Login initiation: `/moLogin` (route `oauth_login_oauth2.moLogin`, `_access: TRUE`). Callback:
  `/mo_callback` (`oauth_login_oauth2.mo_login`, `_access: TRUE`). Test SSO: `/testSSO` (admin).
- User matching is by **email attribute** → `user_load_by_mail()` → `user_login_finalize()`.
  No auto-provisioning in the free tier; unknown emails get an error page.
- Client secret is encrypted at rest via `Utilities::encrypt/decrypt` (key = sha256 of site private key).
- Outbound token/userinfo calls go through `Utilities::callService()` (Guzzle).
