<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
DrupalAuth for SimpleSAMLphp turns a Drupal site into the login experience for a SimpleSAMLphp **Identity Provider** — users authenticate against Drupal, and the companion `drupalauth` SimpleSAMLphp authsource reads that session and issues SAML assertions to the service providers that trust the IdP.

---

The direction of travel is the point, and it is the reverse of most SAML modules. `simplesamlphp_auth` makes Drupal a *service provider*: users log in elsewhere and arrive authenticated. This module makes Drupal the *identity provider's* front end: SimpleSAMLphp runs on the same virtual host, and when a service provider needs a user authenticated it sends them to Drupal's normal login form; on success `hook_user_login` writes the Drupal account ID into the SimpleSAMLphp auth state via the `SspHandler` service, and the user is redirected back to the SP's `ReturnTo` URL to complete the assertion. Because the end user only ever sees Drupal pages, there is no need to theme SimpleSAMLphp. The Drupal side is compact: the `drupalauth4ssp.ssp_handler` service, a `DrupalAuthForSSPSubscriber` response subscriber, a `/drupalauth4ssp/redirect` route/controller for resuming after a two-factor detour, a settings form at `/admin/config/people/drupalauth4ssp` behind `administer drupalauth4ssp configuration`, and hooks that also expire the SimpleSAMLphp session on Drupal logout. Config is two keys: `returnto_list` (the allowlist of SP URLs that may be used as `ReturnTo`) and `idp_logout_returnto` (where to land after IdP-initiated logout). The composer requirement is on `drupalauth/simplesamlphp-module-drupalauth ~2.10||~2.11`, a SimpleSAMLphp module installed into the SimpleSAMLphp tree, and the project suggests pairing with `drupal/tfa`, which the module has explicit integration hooks for.

---

- Use Drupal as the login UI for a SimpleSAMLphp identity provider.
- Give several applications one shared sign-on backed by Drupal accounts.
- Federate a Drupal site's users to external SAML service providers.
- Keep user management in Drupal while issuing SAML assertions.
- Return a user to the originating service provider after login via `ReturnTo`.
- Restrict which SP URLs may be used as return destinations with `returnto_list`.
- Send users to a chosen page after IdP-initiated logout (`idp_logout_returnto`).
- Restrict IdP configuration to a small set of administrators.
- Add two-factor authentication to the IdP login with `drupal/tfa`.
- Resume a federated login after a TFA setup detour (`/drupalauth4ssp/redirect`).
- Expire the SimpleSAMLphp session when a user logs out of Drupal.
- Replace per-application account stores with one Drupal directory.
- Present a single branded Drupal login page to all federated applications.
- Integrate a legacy SAML service provider with Drupal accounts.
- Provide SSO across a university or agency estate from Drupal accounts.
- Map Drupal user fields and roles to SAML attributes (on the SimpleSAMLphp side).
- Meet a SAML 2.0 requirement without a commercial IdP.
- Migrate an existing SimpleSAMLphp IdP onto Drupal's login form.
- Give partner organisations access using site accounts.
- Keep the SimpleSAMLphp `drupalauth` module in sync via composer.
