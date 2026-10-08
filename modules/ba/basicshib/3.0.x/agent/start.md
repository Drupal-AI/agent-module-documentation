# BasicShib — agent index

Shibboleth (SAML SSO) external authentication. An external Shibboleth **SP** authenticates the
user and exposes attributes to the web server; BasicShib reads them to log in / auto-create the
matching Drupal user and (optionally) map InCommon **Grouper** groups to Drupal roles. No module
deps. Provides permissions, config schema, and three plugin types.

- **Login/logout flow, routes, settings (attribute map, handlers, messages, redirect),
  auth_filter config, Grouper Policies/Authorizations, blocks** →
  [configure/settings.md](configure/settings.md)
- **The three plugin types (`user_provider`, `auth_filter`, `grouper`) and how to implement one** →
  [plugins/plugins.md](plugins/plugins.md)
- **Permissions and what each admin route gates** → [permissions/permissions.md](permissions/permissions.md)

Key facts:
- `/basicshib/login` (`_role: anonymous`) → `LoginController::login` → `AuthenticationHandler::authenticate()`:
  reads key attrs `name`(def `eppn`), `mail`(def `eppn`), `session_id`(def `Shib-Session-ID`)
  from `$_SERVER` via `AttributeMapper`, loads user by name, else creates (if allowed), then
  `user_login_finalize()` — **no password** (by design for pre-auth SSO).
- `RequestEventSubscriber` (priority 100) runs `checkUserSession()` every request; logs out on
  missing/mismatched tracked `Shib-Session-ID` (`SessionTracker` in the Drupal session).
- Grouper: when `plugin_enabled.grouper_enabled`, `AuthorizationHandler::authorize()` reads
  `isMemberOf` (`HTTP_ISMEMBEROF`) and adds/removes roles per Policies/Authorizations config entities.
- Config: `basicshib.settings` + `basicshib.auth_filter` (create/remove toggles, all default FALSE).
  Config entities `basicshib.authorization.*`, `basicshib.policies.*`. Admin UI `/admin/config/basicshib`.
- Identity is taken from web-server (SP) attributes; the SP must protect `/basicshib/login`.
