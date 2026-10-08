<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# SAML Service Provider (saml_sp) — agent index

API/toolkit module that makes Drupal a **SAML 2.0 Service Provider** (validates IdP responses via
`onelogin/php-saml`). It does not log users in by itself — the `saml_sp_drupal_login` submodule
does. Admin UI: `/admin/config/people/saml_sp` (route `saml_sp.admin`, permission
`configure saml sp`).

- **SP settings, IdP config entities, endpoints (ACS/metadata/logout)** →
  [configure/settings-and-idp.md](configure/settings-and-idp.md)
- **Programmatic API: start auth, build settings/metadata, load IdPs, authn contexts** →
  [api/authentication.md](api/authentication.md)
- **Alter hooks (`hook_saml_sp_settings_alter`, `..._authn_context_class_refs_alter`)** →
  [hooks/alters.md](hooks/alters.md)

Key facts:
- **Endpoints** (routes): `/saml/consume` (ACS, `saml_sp.consume`), `/saml/metadata.xml`
  (`saml_sp.metadata`), `/saml/logout` (`saml_sp.logout`).
- **IdPs** = `idp` config entities (config name `saml_sp.idp.<id>`; keys: `entity_id`, `login_url`,
  `logout_url`, `x509_cert` (sequence), `app_name`, `nameid_field`, `authn_context_class_ref`).
  Managed at `/admin/config/people/saml_sp/idp_collection`.
- **Site settings** = `saml_sp.settings` (contact.technical/support, organization, `security.*`
  signing flags, `signatureAlgorithm`, `entity_id`, `cert_location`, `key_location`,
  `new_cert_location`, `strict`, `valid_until`, `debug`).
- Services: two event subscribers (SP cert-expiry warning; proxy configuration). No plugins,
  no Drush. Permission `configure saml sp`. Requires library `onelogin/php-saml`.
