<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Hybrid Login (hybrid_login) — agent index

**Customizable login-page block plus form/route alters that surface an external (SAML) login option and can hide Drupal's own login/register/reset UI. It does not perform authentication itself.**

- **Version:** 1.0.x  ·  **Core:** ^10 || ^11  ·  **Package:** User
- **Configure:** `/admin/config/people/hybrid_login` (`HybridLoginConfigurationForm`, config `hybrid_login.settings`) — requires `administer site configuration`.
- **Block:** `hybrid_login_block` (`HybridLoginBlock`) — themed login panel with a button linking to a configurable path (e.g. `/saml/login`).
- **Alters:** `hook_form_user_login_form_alter` / `hook_form_user_pass_alter` hide login/reset/create links; `RouteSubscriber` sets `_access:'FALSE'` on `user.pass` / `user.register` when their options are off.
- **No authentication code:** no credential verification, no `user_login_finalize()`, no tokens — purely presentational.

**Security:** admin config route is permission-gated (`administer site configuration`); no anonymous, mutating or auth endpoints. The module never authenticates a user, so it presents no auth-bypass surface — login security rests with the external SAML module the button targets. Note the name is misleading: this is login-page theming, not a login mechanism.

See [configure/settings.md](configure/settings.md).