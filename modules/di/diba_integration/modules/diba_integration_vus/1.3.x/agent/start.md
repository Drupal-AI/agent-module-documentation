<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DiBa VUS (diba_integration_vus) — agent index

VUS (Validació d'Usuaris) corporate-authentication submodule of DiBa Integration. Validates users against the DiBa VUS web service (Guzzle HTTP, XML) and reads the corporate Oracle mailbox directory (`oci8`) for admin reports. Deps: `diba_integration`, core user/field/taxonomy. Requires the PHP `oci8` extension for the Oracle reports. Configure route: `diba_integration_vus.settings`.

## Config object
`diba_integration_vus.settings` (schema `config/schema/…`, defaults `config/install/…`). Keys: `_enabled`, `_user_scape` (escape list), `_validation` (0 Drupal / 1 VUS+Drupal / 2 VUS-or-Drupal / 3 VUS-only), `_post` (allow POST SSO), `_redirect`, `_email_mandatory`, `_autouser`, `_autouser_role`, `_sincro_nom`/`_sincro_ens`/`_sincro_perfil`/`_sincro_continuous`, `_ws_serv`/`_ws_usr`/`_ws_clau`/`_ws_app` (web service), `_diba_domains`, password/login-error message keys, `_user_oracle`/`_db_oracle`. The Oracle password is NOT in config — it lives in State key `diba_integration_vus.oracle_password`.

## Routes / permissions
- `diba_integration_vus.settings` — `/admin/config/people/vus`, `VusSettingsForm`, perm `administer vus` (restrict access).
- `diba_integration_vus.busties` — `/admin/config/people/vus/busties`, `BustiesController::content`, perm `access vus`.
- `diba_integration_vus.counts` — `.../counts`, `CountsController::content`, `access vus`.
- `diba_integration_vus.errors` — `.../errors`, `ErrorsController::content`, `access vus`.

## Services (`.services.yml`)
- `…vus_manager` → `Service/VusManager` — `getWsData()` (Guzzle POST + XML parse), `checkAccess()`, `validateUser()`, `createUser()`/`updateUser()`, ens/perfils taxonomy sync (`getOrCreateTerm`), `login()`.
- `…oracle` → `Service/DibaOracleService` — `oci_connect` (`SET ROLE ALL`), batched parameterized `oci_bind_by_name` lookups of username↔mailbox, status block, per-domain counts.
- `…request_subscriber` → `EventSubscriber/VusPostSubscriber` — anonymous POST `user`/`pass` SSO (kernel REQUEST).
- `…route_subscriber` → `Routing/PasswordRememberSubscriber` — disables `user.pass` route in VUS-only mode.
- `…http_middleware` → `StackMiddleware/RedirectMiddleware` — replaces the response with a stored post-login redirect.
- `Hook/DibaIntegrationVusHooks` — `hook_form_*_alter` for user_login/user/user_register/user_pass; per-mode validators, corporate password-field hiding, failed-login logging.

## Controllers / forms
- `Controller/BaseVusController` (+ Busties/Counts/Errors) — admin reports; all use `->accessCheck(FALSE)` user queries gated by the `access vus` route permission; render markup escaped via `Html::escape`.
- `Form/BustiesFilterForm` — GET-query filter (text + match filter + page size).
- `Form/VusSettingsForm` — settings; creates `vus_ens`/`vus_perfils` vocabularies + user reference fields on demand; stores Oracle password in State.

## Solution docs
- `agent/config/settings.md` — settings keys, validation modes, web-service/Oracle credentials, provisioning, sync.
- `agent/reports/admin-reports.md` — busties / counts / errors report pages and the Oracle lookup service.
