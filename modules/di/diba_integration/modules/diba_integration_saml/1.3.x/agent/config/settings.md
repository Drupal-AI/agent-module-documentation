<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# diba_integration_saml — configuration & login policy

Config: `diba_integration_saml.settings`. Form: `Form/SamlSettingsForm` at `/admin/config/people/diba_saml` (`administer saml`). Policy service: `Service/SamlManager`. Login integration: `Hook/SamlFormHooks` + `Form/LoginFormValidator`.

## Install / enable
Requires `samlauth` and `externalauth`. `ddev drush en diba_integration_saml -y`. Module weight is set to `-500` on install so its form_alter runs before others. Then open the settings form, paste IdP metadata, and set the validation mode.

## Validation modes (`_validation_mode`, `SamlManager::VALIDATION_*`)
- `0` LOCAL — only local Drupal auth; no SAML enforcement.
- `1` COMBINED — `SamlFormHooks::replaceLoginValidators()` swaps in `LoginFormValidator::validateLoginSubmission`, which tries local auth (`user.auth` service) first and, on failure, redirects to SAML login.
- `2` HYBRID (default) — the login validator is added only when the typed identifier is corporate (`SamlManager::isCorporateIdentifier()` — email domain in `_allowed_domains`, or a local user whose email is corporate); such users are always redirected to SAML, others fall through to core validation.
- Escape list `_user_escape` (comma/space list, lowercased): these usernames always authenticate locally, in any mode.
- When `_allow_local_login` is off and mode ≠ LOCAL, the name/pass/submit/request-password elements are hidden (`#access = FALSE`).

The redirect target is `SamlManager::buildLoginUrl()` — `_samlauth_login_path` (default `/saml/login`) when `_use_samlauth` and samlauth is installed, else `Url::fromUri(_idp_sso_url)`. `LoginFormValidator::redirectToSaml()` appends `?username=<typed>&return_to=<request uri>` and sets a `RedirectResponse` on the form state.

## Login-form additions
`SamlFormHooks::formUserLoginFormAlter()` also adds a themed SSO call-to-action link (`_show_sso_link`, text `_sso_link_text`) in non-local modes. `formUserPassAlter()` renders configurable password-recovery messages (`#theme diba_integration_saml_password_message`) and, in non-local modes, appends `LoginFormValidator::validateNotCorporatePasswordReset` which blocks a corporate identifier from using `/user/password`.

## IdP metadata import (`Service/IdpMetadataParser`)
`SamlSettingsForm::submitForm()` calls `IdpMetadataParser::parse($_idp_metadata_xml)`. Parsing uses `DOMDocument::loadXML(..., LIBXML_NONET | LIBXML_NOCDATA)` (no network access) and XPath over the SAML metadata / xmldsig namespaces to extract `idp_entity_id`, `idp_sso_url` (HTTP-Redirect binding), `idp_slo_url`, and the first `X509Certificate` (re-wrapped in PEM). Parsed values overwrite the corresponding `_idp_*` config keys; a parse failure raises a form error and leaves manual values.

## samlauth sync (`syncSamlauthConfiguration()`)
On every save (when samlauth is installed) the resolved values are written to `samlauth.authentication`: `sp_entity_id` (defaults to site URL if empty), `assertion_consumer_service_url` = site URL + `_sp_acs_path`, `single_logout_service_url` = site URL + `_sp_sls_path`, SP/IdP certs, `idp_single_sign_on_service`/`…_log_out_service`, `use_attribute_friendly_name`, `unique_id_attribute`, `map_users`/`map_users_name`/`map_users_mail`, `user_name_attribute`/`user_mail_attribute`, `create_users` (= `_autoprovision`), `link_existing_users` (= `_link_existing_users`), `allow_all_roles` (= `_allow_admin_linking`). Request/response signing (`security_authn_requests_sign` etc.) is enabled only when both an SP cert AND private key are configured; otherwise it is disabled with an admin warning (avoids OneLogin `sp_certs_not_found_and_required`).

## SP metadata (`Controller/SamlSpMetadataController::metadata`)
`/diba-saml/metadata` (`administer saml`) builds combined SP metadata XML with `WantAssertionsSigned=true`, an optional signing `KeyDescriptor` from `_sp_x509_certificate`, persistent NameID format, and one `AssertionConsumerService` (HTTP-POST) + one `SingleLogoutService` (HTTP-Redirect) per base URL — the current `getSchemeAndHttpHost()` plus each line of `_extra_site_urls`. Handed to the IdP team for multi-environment registration.

## Provisioning (`SamlManager::resolveDrupalUser`)
Maps assertion attributes → `loadUser()` by name then mail → `syncUser()` (fills empty email/init). If no match and `_autoprovision` is on, `createUser()` builds a unique sanitized username, random password, status 1, and adds `_default_role` (never anonymous/authenticated). `getPostLoginUrl()` resolves `_redirect` (`<front>`/`<user>`/user-input path).

Note: `Controller/SamlAcsController::consume()` exists but has no route entry, so the module's own ACS path is not reachable — assertion consumption is handled by samlauth's `/saml/acs`.
