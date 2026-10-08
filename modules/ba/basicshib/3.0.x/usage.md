BasicShib provides Shibboleth (SAML SSO) external authentication for Drupal: a Shibboleth Service Provider (SP) authenticates the user and exposes attributes to the web server, and BasicShib reads those attributes to log the matching Drupal user in, optionally auto-creating the account and mapping InCommon Grouper groups to Drupal roles.

---

The login flow is: a visitor follows a Shibboleth login link/block to the SP handler
(`/Shibboleth.sso/Login`) with `target` pointing back at `/basicshib/login`; after SP
authentication the request returns to `LoginController::login()`, which calls
`AuthenticationHandler::authenticate()`. That reads the configured key attributes from the
web-server request via `AttributeMapper` — `name` (default `eppn`), `mail` (default `eppn`),
and `session_id` (default `Shib-Session-ID`) — read from Symfony's `ServerBag`
(`$_SERVER[<attr name>]`). It loads the Drupal user whose name equals the `name` attribute
(`UserProviderPluginDefault::loadUserByName`); if none exists and an `auth_filter` allows
creation it creates one (`status = 1`, no local password), then calls `user_login_finalize()`
— there is no password check, by design for pre-authenticated SSO. A `RequestEventSubscriber`
runs on every request and logs the user out if the tracked Shib session id disappears or
changes. Three swappable plugin types drive behavior: **user_provider** (load/create the
account), **auth_filter** (allow/deny creation and existing-user login, and per-request session
checks), and **grouper** (map Grouper groups to Drupal roles). With Grouper enabled,
`AuthorizationHandler::authorize()` reads the `isMemberOf` attribute (`HTTP_ISMEMBEROF`),
compares the user's groups to admin-defined **Policies** and **Authorizations** (config
entities), and adds/removes Drupal roles accordingly (optionally stripping non-Grouper,
authenticated, or administrator roles). Config lives in `basicshib.settings` (handlers,
attribute map, messages, redirect path, plugin selection) and `basicshib.auth_filter`
(create/remove toggles, default all off); admin UIs are under `/admin/config/basicshib`
(permissions `administer basicshib`, `administer authorization`, `administer policies`,
`administer auth_filter`). BasicShib requires an external SP, which must be set up to protect
the attributes the module reads.

---

- Add Shibboleth / InCommon single sign-on to a Drupal site fronted by a Shibboleth SP.
- Log users in from federated identity (eppn) without local Drupal passwords.
- Auto-create Drupal accounts on first Shibboleth login (when creation is enabled).
- Map the SP `eppn` attribute to the Drupal username and email.
- Configure custom attribute names to match a particular SP/IdP release policy.
- Place a "Shibboleth login" block or menu link that routes through the SP login handler.
- Redirect users to a chosen path (or `after_login` target) after a successful SSO login.
- Terminate the Drupal session automatically when the Shibboleth SP session ends or changes.
- Map InCommon Grouper groups (`isMemberOf`) to Drupal roles on each login.
- Grant a Drupal role automatically when a user belongs to a configured Grouper policy.
- Remove Drupal roles a user no longer has a matching Grouper group for, at login.
- Optionally strip the authenticated or administrator role when not backed by Grouper.
- Define reusable Grouper Policies and group them into Authorizations per Drupal role.
- Assign Authorizations to roles from the role edit form (`/admin/people/roles`).
- Block login for suspended accounts (blocked users are rejected before finalize).
- Customize all user-facing login error messages (blocked, disallowed, creation-denied, redirect).
- Deny account auto-creation so only pre-provisioned users can log in.
- Swap in a custom `user_provider` plugin to load/create users from a different store.
- Add a custom `auth_filter` plugin to enforce extra login rules (e.g. attribute allow-lists).
- Add a custom `grouper` plugin for a bespoke group→role mapping scheme.
- Provide SSO for a university/enterprise site that already uses Shibboleth federation.
- Enforce that a valid Shib session accompanies every authenticated request via the subscriber.
- Prevent external open-redirects after login (targets are validated as internal).
- Localize/override the login link label shown in the block and menu.
