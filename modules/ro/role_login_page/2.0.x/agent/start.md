<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Role login page (role_login_page) — agent index

Lets an administrator define **multiple standalone login pages**, each at its own URL, each
restricted to a set of **roles**, each with its own field labels and post-login **redirect**.
These are *additional* login forms — core's `/user/login` is untouched. Version **2.0.3**,
core `^8 || ^9 || ^10 || ^11`. One permission: `administer role login settings`. No Drush
commands, no plugin types, **no config schema** (page definitions live in a database table,
not in configuration).

## What it actually does

Do not read this as a simple "post-login redirect by role" module. It creates whole new login
**pages**:

1. **Storage** — each page is a row in the custom table `role_login_page_settings`
   (`role_login_page.install`, `hook_schema`): `url`, `roles` (comma-joined role IDs),
   `username_label`, `password_label`, `submit_text`, `page_title`, `parent_class`,
   `redirect_path`, `role_mismatch_error_text`, `invalid_credentials_error_text`.
2. **Dynamic routes** — `Routing\RoleLoginRoutes::routes()` (wired via `route_callbacks` in
   `role_login_page.routing.yml`) reads every row and registers a route at `/{url}` whose form is
   `Form\RoleLoginForm`, whose title is the row's `page_title`, and whose requirement is
   `_user_is_logged_in: 'FALSE'` — **anonymous only**. Routes are rebuilt on every cache clear
   (`drupal_flush_all_caches()` is called after any add/edit/delete).
3. **The login form** (`Form\RoleLoginForm`) — builds `name` + `pass` + submit from the row's
   labels (each `Html::escape()`-d, then passed through `t()`), optionally adds `parent_class` to
   the form element. `validateForm()`/`submitForm()` authenticate with
   `\Drupal::service('user.auth')->authenticate($username, $password)`; then
   `_role_login_page_validate_login_roles($uid, $roles)` (in `.module`) checks the account holds
   **at least one** of the page's roles. Mismatch → the row's role-mismatch error, no login.
   Match → `user_login_finalize()`, then the request's `destination` query is **set** to
   `redirect_path` (or `/` when empty/`<front>`), so the user lands there.

**Key correctness fact:** all of these pages authenticate against the **same user table**. A
distinct page changes *where a user lands* and *which roles may enter*, not *which passwords are
valid* — it is presentation + a role gate, not credential separation. For "these accounts must not
authenticate at this entrance at all", use `disable_login_by_domain`, an IP restriction
(`access_filter`, `restrict_route_by_ip`), or a separate site.

## Admin surface

- `admin/config/login/role_login_settings` — **add** page form (`Form\RoleLoginPageSettings`).
- `admin/config/login/role_login_settings/list` — list of defined pages (`Controller\RoleLoginPageController`); this is the `configure` link.
- `admin/config/login/role_login_settings/edit/{rl_id}` — edit (`Form\RoleLoginPageSettingsEdit`).
- `admin/config/login/role_login_settings/delete/{rlid}` — delete confirm (`Form\RoleLoginPageSettingsDelete`).

All four require the `administer role login settings` permission. Field-by-field detail and the
save-time validation (URL uniqueness, internal redirect check) are in `agent/config/settings.md`.

## Redirect safety (worth stating plainly)

The `redirect_path` is administrator-set and validated on save via
`\Drupal::service('path.validator')->getUrlIfValid()` requiring a real route name — so it is an
**internal, routed** path, never external. On submit the module **overwrites** the request
`destination` with that path (falling back to `/`). So the landing target here cannot be steered
by a `?destination=` request parameter, unlike core's default. No open-redirect surface was found.

## Files

- `role_login_page.info.yml` — `configure: role_login_page.settings_list`; core `^8 || ^9 || ^10 || ^11`.
- `role_login_page.module` — `hook_help`, `hook_permission`, `_role_login_page_validate_login_roles()`, `_role_login_page_settings_cache_clear()`.
- `role_login_page.routing.yml` — the four admin routes + `route_callbacks` for the dynamic login pages.
- `role_login_page.permissions.yml` — `administer role login settings`.
- `role_login_page.install` — `hook_schema` for `role_login_page_settings`.
- `role_login_page.links.menu.yml` / `.links.action.yml` — admin menu + add/list action buttons.
- `src/Routing/RoleLoginRoutes.php` — dynamic route generator.
- `src/Form/RoleLoginForm.php` — the actual login form (auth + role gate + redirect).
- `src/Form/RoleLoginPageSettings.php` / `…Edit.php` / `…Delete.php` — add / edit / delete admin forms.
- `src/Controller/RoleLoginPageController.php` — the settings list table.
- `src/Access/RoleLoginPageAccess.php` — an anonymous-only access checker that is **not wired** to any route (dead code; the anonymous gate is done by `_user_is_logged_in: 'FALSE'` instead).

## Configuration

See `agent/config/settings.md`.
