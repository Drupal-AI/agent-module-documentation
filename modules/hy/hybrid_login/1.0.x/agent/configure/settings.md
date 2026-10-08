<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Hybrid Login settings

Edit at `/admin/config/people/hybrid_login`
(`administer site configuration`). Config object `hybrid_login.settings`:

- **hide_drupal_login** — hides the Drupal name/pass/submit fields on
  `/user/login` (does not touch the Hybrid Login block itself).
- **show_create_account** — when off, removes the create-account link and the
  `RouteSubscriber` denies access to `user.register`.
- **show_password_reset** — when off (or when Drupal login is hidden), removes
  the reset link and denies access to `user.pass`.
- **login_title / login_description** — text shown in the block.
- **login_logo** — a `managed_file` (png/jpg/jpeg), rendered at `medium` image
  style; marked permanent on save.
- **login_button_text** — button label (default "Login").
- **login_url_path** — relative path the button links to, typically
  `/saml/login` (depends on the external auth module you install separately).
- **password_reset_description** — markup shown on `/user/password`.

**Placement:** the effect is only visible once you place the *Hybrid Login*
block (category Forms) on the login page via Block layout. Clear cache after
changing settings, as recommended in the README.

**Important:** this module contains no authentication logic. To actually log
users in via an external service you must install and configure that service
(e.g. SAML Auth) — Hybrid Login only renders the entry point and adjusts which
core login UI is shown.
