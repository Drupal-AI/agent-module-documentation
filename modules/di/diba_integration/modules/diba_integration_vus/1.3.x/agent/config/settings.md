<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# diba_integration_vus — configuration, validation & provisioning

Config: `diba_integration_vus.settings`. Form: `Form/VusSettingsForm` at `/admin/config/people/vus` (`administer vus`). Core service: `Service/VusManager`. Login integration: `Hook/DibaIntegrationVusHooks` + `EventSubscriber/VusPostSubscriber`.

## Install / enable
`ddev drush en diba_integration_vus -y`. The Oracle reports need the PHP `oci8` extension; without it the web-service login still works but the busties/counts/errors pages show an Oracle-error state. Module weight is set to `-500` on install.

## Validation modes (`_validation`, `VusManager::VALIDACIO_*`)
Set in `DibaIntegrationVusHooks::formUserLoginFormAlter()`:
- `0` DRUPAL — native Drupal validators only.
- `1` VUS_I_DRUPAL (combined) — validators `::validateName`, `::validateAuthentication`, then `webserviceValidateCallback`, `::validateFinal` — local first, VUS second.
- `2` VUS_O_DRUPAL (exclusive) — `setHybridValidation()`: if the account's email is a DiBa domain (`isDibaMail()`), replace validators with VUS-only; otherwise local.
- `3` VUS (VUS-only) — validators `[webserviceValidateCallback, ::validateFinal]`.
Usernames in `_user_scape` (comma list) always use local Drupal validation. A `logFailedLoginCallback` is appended to record why a login failed (strategy + VUS code/reason).

## Web-service validation (`VusManager::getWsData`)
Posts to `_ws_serv` with `GuzzleHttp` (`form_params`, `application/x-www-form-urlencoded`; default TLS verification applies). Credentials array = `ws_usuari`=`_ws_usr`, `ws_clau`=`_ws_clau`, `usuari_vus`=`OPS$<UPPER(user)>`, `clau_vus`=password, optional `aplicacio`=`_ws_app`. The XML body is parsed with `simplexml_load_string(...)` → array. `checkAccess()` grants when `codi === 0`, or `codi === 1` with no app and reason in {303,304,305}. On success `extractUserData()`/`extractEnsAndPerfils()` normalize username/name/email/organic + ens/perfils. `_ws_app` scopes results to one corporate application (recommended when syncing ens/perfils).

## POST single-sign-on (`VusPostSubscriber::checkForLoginSubmit`)
On every kernel REQUEST, when the user is anonymous and `_enabled` and `_post` and `_validation > 0`: reads scalar POST `user`/`pass`, strips `ops$`, `Html::escape`s both, calls `VusManager::validateUser()` and, on success, `login()`. This is the corporate-portal "accés restringit" SSO entry. `login()` finalizes the session and stores a `RedirectResponse` (per `_redirect`: `<front>`/`<user>`/path) in `RedirectMiddleware`, which returns it in place of the normal response.

## Provisioning (`VusManager::validateUser` → `createUser`)
If VUS access is granted and no Drupal user matches the name, a new user is created (name = VUS username, mail = VUS email, random password, activated) and `_autouser_role` is added (never anonymous/authenticated). `createUser()` enforces `_email_mandatory` and rejects a duplicate email. Note: the form-based validator (`webserviceValidate`) additionally honors `_autouser` (fails early when off and the local user is missing); the direct `validateUser()` path used by the POST subscriber creates the account whenever the remote VUS grants access. Existing users are updated via `updateUser()` only when `_sincro_continuous` is on.

## Synchronization (`updateUser`, `getOrCreateTerm`)
- Name → the user field named in `_sincro_nom`.
- Ens → `user_vus_ens` reference field, terms in `vus_ens` (created on demand). Enabled by `_sincro_ens`.
- Perfils → `user_vus_perfils` reference field, terms in `vus_perfils`. Enabled by `_sincro_perfil`.
`VusSettingsForm::submitForm()` creates the vocabulary, the `field_<vid>_id` term field, and the `user_<vid>` entity-reference user field the first time a sync option is enabled (`createVocabularyUserMap()`). Term lookups use an entity query with `->accessCheck(FALSE)` (admin-driven login-time sync).

## Password / user forms (`DibaIntegrationVusHooks`)
- `formUserFormAlter` — in VUS/VUS-or-Drupal modes, for a DiBa-mail user not in the escape list, hides `pass`/`current_pass`/`password_policy_status` (+ password-expiration fields) and shows the corporate-reset warning.
- `formUserRegisterFormAlter` — makes email required when `_email_mandatory`.
- `formUserPassAlter` — renders `_password_*_message` (HTML-capable, admin-set) and, in non-Drupal modes, adds `validateNotDibaCallback` to block corporate identifiers from `/user/password`.
- `PasswordRememberSubscriber::alterRoutes` — in VUS-only mode sets `_access => 'FALSE'` on the `user.pass` route entirely.

## Credentials storage
Web-service user/token (`_ws_usr`/`_ws_clau`) and Oracle user (`_user_oracle`) live in config. The Oracle password is stored via the State API (`state:diba_integration_vus.oracle_password`), not config; the settings form leaves it blank to keep the current value. `_db_oracle` selects the Oracle node (`psi.world`/`tsi.world`/`isi.world`).
