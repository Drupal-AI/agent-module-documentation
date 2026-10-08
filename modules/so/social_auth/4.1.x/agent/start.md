<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Social Auth — agent index

Base framework (on **Social API**) for OAuth2 social login/registration. It is **not** a
provider itself — concrete providers (Google, Facebook, GitHub…) are separate
`social_auth_*` modules that plug in via a Social API **Network** plugin. Fully exercising a
login needs a provider module **and** an OAuth app registered with that external provider
(client id/secret) — an external dependency. The parts below are verifiable locally.

- **Site settings, per-network settings form, integrations page, login block** →
  [configure/settings.md](configure/settings.md)
- **Services you call: UserAuthenticator, UserManager, SocialAuthDataHandler** →
  [api/services.md](api/services.md)
- **Events fired (user fields, created, login, before redirect, failed auth)** →
  [hooks/events.md](hooks/events.md)
- **Build a new provider integration (Network plugin + OAuth2 manager + controller)** →
  [extend/provider-integration.md](extend/provider-integration.md)
- **Permissions** → [permissions/permissions.md](permissions/permissions.md)

Key facts:
- Configure route `social_auth.integrations` → `/admin/config/social-api/social-auth`
  (permission `administer social api authentication`, from social_api).
- Site config object `social_auth.settings`: `post_login` (`/user`), `user_allowed`
  (`register`|`login`), `redirect_user_form` (bool), `disable_admin_login` (bool, default
  TRUE), `disabled_roles` (array), `auth` (implementer login routes).
- Per-provider creds live in each provider's own `<network>.settings` (client_id,
  client_secret, scopes, endpoints) — written by `SocialAuthSettingsForm`.
- Routes: `user/login/{network}` (redirect) and `user/login/{network}/callback`.
- Content entity `social_auth` = a stored provider↔Drupal-user identity ("Social Auth
  profile").
- Block plugin `social_auth_login`; theme hook `login_with`.
