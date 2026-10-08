<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Social Auth Google — agent index

A Google OAuth2 provider for the **Social Auth** framework: lets users register/log in with
Google. Login routing, user matching and account creation come from base `social_auth` /
`social_api`; this module adds the Google `@Network` plugin, a manager service and a settings
form. Depends on `social_auth`; needs the `league/oauth2-google` library and PHP ≥ 8.1. No
permissions or Drush of its own.

- **Settings: config object, keys, OAuth credentials, scopes, restricted domain** →
  [configure/settings.md](configure/settings.md)
- **The `GoogleAuthManager` service & the Network plugin** →
  [api/manager.md](api/manager.md)

Quick reference:
- Config object **`social_auth_google.settings`**: `client_id`, `client_secret`, `scopes`,
  `endpoints`, `restricted_domain`.
- Settings form route `social_auth_google.settings_form` →
  `/admin/config/social-api/social-auth/google` (permission `administer social api authentication`).
- Network plugin id `social_auth_google` (social network "Google", config_id
  `social_auth_google.settings`).
- Service `social_auth_google.manager` (`GoogleAuthManager`).
- Always-requested scopes: `openid`, `email`, `profile` (extra scopes are comma-separated).
