# User Default Page — config entity & redirect logic

## Config entity: `user_default_page_config_entity`

Managed at `/admin/config/people/user_default_page` (route `user_default_page.action`, permission
`administer site configuration`). Add/edit form: `UserDefaultPageConfigEntityForm`. Schema:
`user_default_page_config_entity.schema.yml`.

Fields (getters on `UserDefaultPageConfigEntityInterface`):
- `label`, `id`
- `roles` — target role IDs (`getUserRoles()`)
- `users` — comma-separated UID string (`getUsers()`)
- `login_redirect` / `login_redirect_message` (`getLoginRedirect()` / `getLoginRedirectMessage()`)
- `logout_redirect` / `logout_redirect_message` (`getLogoutRedirect()` / `getLogoutRedirectMessage()`)
- `weight` (`getWeight()`) — tie-breaker across matching role rules

Enter redirect paths as internal URLs, e.g. `/node/5`.

## Login redirect (`hook_user_login`)

1. Skips entirely on the one-time-login route `user.reset.login`.
2. Iterates all entities. For a **role** match (`array_intersect(entity roles, user roles)`) it keeps
   the `login_redirect` of the highest-`weight` matching entity. A **UID** match
   (`strpos(users, uid . ',')`) overrides with that entity's redirect+message.
3. Re-checks an ignore list (`['user.reset.login','user.reset']`), extensible via
   `hook_user_default_page_login_ignore_whitelist_alter(&$ignored_routes)`.
4. Shows `login_redirect_message` (if set) then redirects.

## Logout redirect (`hook_user_logout`)

- Skips `autologout.alt_logout` / `autologout.ajax_logout`.
- Picks the highest-`weight` entity whose roles match (and no explicit users) OR whose `users` list
  contains the UID; uses its `logout_redirect` (+message, passed as `?upd=<entity id>`).

## `user_default_page_redirect($path)`

- If `$path` does not start with `http` or `node`, prepends scheme+host+base path.
- If `rename_admin_paths` is enabled, rewrites `/admin/`→`/<admin_path_value>/` and
  `/user`→`/<user_path_value>` per that module's config.
- Validates with `\Drupal::service('path.validator')->getUrlIfValid($path)`. If invalid and the
  `redirect` module is enabled, looks up a matching redirect entity. Otherwise logs + warns.
- Only issues a `RedirectResponse` for a validated URL — the destination is admin config, so there is
  no open-redirect surface from request input.

## Landing-page message (`hook_page_attachments`)

Reads `?upd` from the query, loads that entity, and adds its logout message (anonymous) or login
message (authenticated) as a status message.
