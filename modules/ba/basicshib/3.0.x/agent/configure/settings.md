# Configuring BasicShib

Prereq: a Shibboleth **SP** (e.g. Apache mod_shib) in front of Drupal, configured to
authenticate users and expose attributes to the web server, and to protect `/basicshib/login`
so only SP-authenticated requests reach it. BasicShib requires no Drupal module dependencies.

## Routes / admin UI

| Route | Path | Access |
|---|---|---|
| `basicshib.login_controller_login` | `/basicshib/login` | `_role: anonymous`, `no_cache` |
| `basicshib.logout` | `/basicshib/logout` | logged-in user |
| `basicshib.settings` / `.core_settings_form` | `/admin/config/basicshib/coresettings` | `administer basicshib` |
| `basicshib.grouper_settings_form` | `/admin/config/basicshib/groupersettings` | `administer basicshib` |
| `entity.authorization.*` | `/admin/config/basicshib/authorization…` | `administer authorization` (collection also `grouperEnabled`) |
| `entity.policies.*` | `/admin/config/basicshib/policies…` | `administer policies` (collection also `grouperEnabled`) |

`configure` route = `basicshib.settings`. Menu/action/task links live under those paths.

## Login link / block

Two ways to start login (README):
- Menu link to `/Shibboleth.sso/login?target=https://<SITE>/basicshib/login`, or
- the **Shibboleth login** block (`basicshib_login`), which renders
  `AuthenticationHandler::getLoginUrl()` (builds the SP login URL with a validated internal
  `target`/`after_login`). Block hidden for authenticated users; label = `login_link_label`.

## Core settings (`basicshib.settings`)

Edited on the *BasicShib settings* form; defaults from `config/install/basicshib.settings.yml`:

- `handlers.login` = `/Shibboleth.sso/Login`, `handlers.logout` = `/Shibboleth.sso/Logout`.
- `attribute_map.key`: `name: eppn`, `mail: eppn`, `session_id: Shib-Session-ID`.
  `attribute_map.optional`: extra `{id,name}` attributes. **These names are looked up in
  `$_SERVER` via `AttributeMapper` (`$request->server->get(<name>)`)** — set them to match your
  SP's server (environment) variable names.
- `plugins`: `user_provider` (default `basicshib`), `grouper` (default `grouper_default`),
  `auth_filter` (sequence, default `[basicshib]`).
- `plugin_enabled.grouper_enabled` (bool, default false) — toggles Grouper authorization.
- `messages.*` — user-facing error strings (generic/blocked/disallowed/creation/external-redirect).
- `default_post_login_redirect_path` (default `/user`); `login_link_label` (default
  `Shibboleth login`); `extended_logging.{logging,messaging}` (both false).

Drush example:
`drush config:set basicshib.settings attribute_map.key.name 'eppn' -y`.

## Auth-filter settings (`basicshib.auth_filter`)

From `config/install/basicshib.auth_filter.yml` — all toggles **default FALSE**:

- `create.allow` — allow auto-creating a Drupal user on first SSO login.
- `remove_non_grouper.allow` — remove Drupal roles with no matching Grouper group at login.
- `remove_authenticated.allow` — remove the authenticated role at login if not in Grouper.
- `remove_administrator.allow` — remove the administrator role at login if not in Grouper
  (README warns: with no Grouper→admin policy this can strip admin from everyone).

Each has an `error` message string shown when the action is denied.

## Grouper (role mapping)

Enable via the *Grouper settings* form (`plugin_enabled.grouper_enabled = true`). Then two more
tabs appear:

1. **Policies** (`basicshib.policies.*` config entities): label + `policy` (a `;`-delimited set
   of Grouper group paths) + description.
2. **Authorizations** (`basicshib.authorization.*` config entities): a Drupal role → one or more
   Policies. Can also be assigned from the role edit form (`/admin/people/roles`) — BasicShib's
   `hook_form_user_role_form_alter` adds Policy checkboxes and writes a
   `basicshib.authorization.<role>` config entity on submit.

At login (`AuthorizationHandler::authorize()`), the `isMemberOf` attribute (default server var
`isMemberOf` / `HTTP_ISMEMBEROF`) is split on `;`, compared to the policy map, and roles are
added/removed; `$account->save()` if changed. The Grouper plugin reads its group→role map from
`basicshib.grouper_settings` (`role_<n>` keys).

## Session enforcement

`RequestEventSubscriber` (KernelEvents::REQUEST, priority 100) calls
`AuthenticationHandler::checkUserSession()` on every request: for an authenticated user whose
login was tracked, if the current `Shib-Session-ID` attribute is missing or differs from the
tracked value (`SessionTracker`, stored in the Drupal session), it clears the tracker and calls
`user_logout()`. auth_filter plugins can add further per-request `checkSession()` rejections.

## Post-login redirect (open-redirect guard)

`LoginController::getRedirectResponse()` takes `after_login` (or `default_post_login_redirect_path`),
validates it with `getUrlIfValidWithoutAccessCheck()`, and throws `BLOCKED_EXTERNAL` if
`$url->isExternal()`, so external redirect targets are refused (message
`messages.external_redirect_error`).
