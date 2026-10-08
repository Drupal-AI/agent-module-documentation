# BasicShib plugin types

Three annotation-based plugin types, each with its own manager (`BasicShibPluginManager`,
subdir `Plugin/basicshib/<type>`, annotation `@BasicShib<Type>`). The active plugin(s) are
selected in `basicshib.settings:plugins`. Implement one by dropping a class in
`src/Plugin/basicshib/<type>/` in your module.

## 1. user_provider — load / create the account

- Manager id `plugin.manager.basicshib.user_provider`; discovery dir
  `Plugin/basicshib/user_provider`; annotation `@BasicShibUserProvider`; interface
  `UserProviderPluginInterface`. Selected via `plugins.user_provider` (default `basicshib`).
- Interface:
  - `loadUserByName($name)` → `UserInterface|null` (default: `loadByProperties(['name'=>$name])`,
    returns the user only if exactly one matches).
  - `createUser($name, $mail)` → `UserInterface|null` (default: creates `status = 1`, **no
    password** — the login controller saves it).
- Use to source identities from an external store or apply a username normalization.

## 2. auth_filter — allow/deny + per-request checks

- Manager id `plugin.manager.basicshib.auth_filter`; dir `Plugin/basicshib/auth_filter`;
  annotation `@BasicShibAuthFilter`; interface `AuthFilterPluginInterface`. Selected via
  `plugins.auth_filter` (a **sequence** — all listed filters run; default `[basicshib]`).
- Interface:
  - `isUserCreationAllowed()` → bool (default reads `basicshib.auth_filter:create.allow`).
  - `isExistingUserLoginAllowed(UserInterface $account)` → bool (default TRUE; blocked accounts
    are already rejected in the handler).
  - `getError($code, ?UserInterface $account)` → string; `$code` is
    `ERROR_CREATION_NOT_ALLOWED` (1) or `ERROR_EXISTING_NOT_ALLOWED` (2).
  - `checkSession(Request $request, AccountProxyInterface $account)` → int; return
    `AuthenticationHandlerInterface::AUTHCHECK_IGNORE` to allow, any other value to force logout
    (called every request by `checkUserSession`). Default returns `AUTHCHECK_IGNORE`.
- Use to enforce extra rules (attribute allow-lists, affiliation checks, time-of-day, etc.).

## 3. grouper — map groups → Drupal roles

- Manager id `plugin.manager.basicshib.grouper`; dir `Plugin/basicshib/grouper`; annotation
  `@BasicShibGrouper`; interface `GrouperPluginInterface`. Selected via `plugins.grouper`
  (default `grouper_default`). Only used when `plugin_enabled.grouper_enabled` is true.
- Interface:
  - `getUserRoles($account)` → array (default returns `$account->getRoles()`).
  - `getMap($userRoles)` → array mapping Grouper group path → Drupal role. Default builds it
    from `basicshib.grouper_settings:role_<n>` (`;`-delimited group paths per role).
- `AuthorizationHandler::authorize()` consumes the map plus the `isMemberOf` attribute to
  add/remove roles at login.

## Notes

- Annotation classes (`src/Annotation/BasicShib*`) declare `id` and (for user_provider) `name`.
- Plugin caches: `basicshib_<type>_plugins` on `cache.discovery`.
- A working reference set lives in `tests/modules/basicshib_test` (test-only auth_filter and
  grouper plugins).
