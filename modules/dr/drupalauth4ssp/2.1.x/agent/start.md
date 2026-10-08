<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DrupalAuth for SimpleSAMLphp (drupalauth4ssp) — agent index

Turns a Drupal site into the login front-end for a co-hosted **SimpleSAMLphp Identity
Provider (IdP)**. Users authenticate at Drupal's normal login form; the companion
SimpleSAMLphp `drupalauth` authsource reads the resulting Drupal session and issues SAML
assertions to the service providers (SPs) that trust the IdP. This is the *opposite*
direction to `simplesamlphp_auth` (which makes Drupal an SP). Core `^10 || ^11`; no Drupal
module dependencies.

Configure at `/admin/config/people/drupalauth4ssp` (`configure: drupalauth4ssp.settings`).
Provides one permission and config schema; no drush commands, no plugin types.

- **Settings form, config keys (`returnto_list`, `idp_logout_returnto`), set via drush/PHP** →
  [configure/settings.md](configure/settings.md)
- **The admin permission** → [permissions/permissions.md](permissions/permissions.md)
- **How the login/return + logout flow works — the `SspHandler` service, routes, controller,
  event subscriber, and the user_login/logout/TFA hooks** → [api/ssp-handler.md](api/ssp-handler.md)

Key facts:
- Composer requires the SimpleSAMLphp module `drupalauth/simplesamlphp-module-drupalauth ~2.10.0 || ~2.11.0`
  (installed into the SimpleSAMLphp tree by the `simplesamlphp/composer-xmlprovider-installer`
  plugin — it is a SimpleSAMLphp module, not a Drupal one). `info.yml` declares no `dependencies:`.
- Service `drupalauth4ssp.ssp_handler` → `Drupal\drupalauth4ssp\SspHandler`
  (args `@config.factory`, `@path.matcher`, `@request_stack`).
- Service `drupalauth4ssp.event_subscriber` → `Drupal\drupalauth4ssp\EventSubscriber\DrupalAuthForSSPSubscriber`
  (args `@current_user`, `@drupalauth4ssp.ssp_handler`).
- Routes: `drupalauth4ssp.settings` (`/admin/config/people/drupalauth4ssp`, perm
  `administer drupalauth4ssp configuration`) and `drupalauth4ssp.redirect`
  (`/drupalauth4ssp/redirect`, `_user_is_logged_in: 'TRUE'`,
  `RedirectController::redirectToServiceProvider`).
- Config object `drupalauth4ssp.settings`: `returnto_list` (sequence of allowed URL patterns,
  install default `['*']`), `idp_logout_returnto` (uri). Schema in
  `config/schema/drupalauth4ssp.schema.yml`.
- Permission: `administer drupalauth4ssp configuration` (`restrict access: true`).
- Implements `hook_user_login`, `hook_user_logout`, and form alters for `user_login_form`,
  `tfa_entry_form`, and `tfa_base_overview`. Optionally integrates with `drupal/tfa`
  (a composer `suggest`; `require-dev` for tests).
- SimpleSAMLphp itself must be installed and configured as an IdP outside Drupal; this module
  does not manage it.
