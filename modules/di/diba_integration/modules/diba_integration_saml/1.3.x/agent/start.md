<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DiBa SAML (diba_integration_saml) — agent index

Corporate SAML SSO submodule of DiBa Integration. Delegates SAML protocol validation to `samlauth`; adds DiBa login-policy business rules and IdP/SP config helpers. Deps: `diba_integration`, core user/field, `samlauth` (^4), `externalauth` (^2), ext-dom, ext-libxml. Configure route: `diba_integration_saml.settings`.

## Config object
`diba_integration_saml.settings` (schema `config/schema/diba_integration_saml.schema.yml`, defaults `config/install/…settings.yml`). Key keys: `diba_integration_saml_enabled`, `_validation_mode` (0 local / 1 combined / 2 hybrid), `_allow_local_login`, `_user_escape`, `_autoprovision`, `_default_role`, `_redirect`, `_use_samlauth`, `_samlauth_login_path`, `_idp_metadata_xml`, `_sp_entity_id`, `_sp_x509_certificate`, `_sp_private_key`, `_sp_acs_path`, `_sp_sls_path`, `_idp_entity_id`/`_idp_sso_url`/`_idp_slo_url`/`_idp_x509_certificate`, `_attribute_uid`/`_email`/`_name`/`_unique_id`, `_use_friendly_names`, `_link_existing_users`, `_allow_admin_linking`, `_allowed_domains`, `_extra_site_urls`, password-message keys.

## Routes / permissions (`.routing.yml`, `.permissions.yml`)
- `diba_integration_saml.settings` — `/admin/config/people/diba_saml`, `SamlSettingsForm`, perm `administer saml` (restrict access).
- `diba_integration_saml.status` — `/admin/config/people/diba_saml/status`, `SamlStatusController::content`, perm `access saml`.
- `diba_integration_saml.sp_metadata` — `/diba-saml/metadata`, `SamlSpMetadataController::metadata`, perm `administer saml`.

## Services (`.services.yml`)
- `…saml_manager` → `Service/SamlManager` — policy: enabled?, validation mode, corporate-domain/escape lists, attribute mapping, `resolveDrupalUser()`, `buildLoginUrl()`, `getPostLoginUrl()`.
- `…idp_metadata_parser` → `Service/IdpMetadataParser` — DOM/XPath extraction of IdP entity ID, SSO/SLO URLs, X.509 cert (`LIBXML_NONET`).
- `…form_hooks` → `Hook/SamlFormHooks` — `#[Hook]` theme, `form_user_login_form_alter`, `form_user_pass_alter`.
- `…login_form_validator` → `Form/LoginFormValidator` — replacement login validator; SAML redirect + corporate password-reset block.

## Notable classes
- `Controller/SamlSpMetadataController` — builds combined multi-env SP metadata XML (one ACS/SLS per `_extra_site_urls` + current host).
- `Controller/SamlStatusController` — diagnostics render array (`#theme diba_integration_saml_status`), also reads `samlauth.authentication`.
- `Controller/SamlAcsController` — a self-contained ACS `consume()` handler; NOT bound to any route in `.routing.yml` (the live ACS is samlauth's own `/saml/acs`). Present but unreachable.
- `Form/SamlSettingsForm::syncSamlauthConfiguration()` — writes resolved values into `samlauth.authentication`.

## Solution docs
- `agent/config/settings.md` — settings keys, validation-mode behavior, IdP-metadata import, samlauth sync, SP metadata.
