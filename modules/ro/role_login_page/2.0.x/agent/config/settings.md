<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration — role_login_page

There is **no config schema and no config object**. Each login page is a **row in the database
table `role_login_page_settings`** (defined in `role_login_page.install`, `hook_schema`). You create
and edit these rows through the admin forms below; they are **not** exportable via configuration
management.

## Admin routes (all require `administer role login settings`)

| Route | Path | Handler | Purpose |
| --- | --- | --- | --- |
| `role_login_page.settings` | `/admin/config/login/role_login_settings` | `Form\RoleLoginPageSettings` | Add a login page |
| `role_login_page.settings_list` | `/admin/config/login/role_login_settings/list` | `Controller\RoleLoginPageController::_role_login_page_settings_list` | List defined pages (the `configure` link) |
| `role_login_page.settings_edit` | `/admin/config/login/role_login_settings/edit/{rl_id}` | `Form\RoleLoginPageSettingsEdit` | Edit a page |
| `role_login_page.settings_delete` | `/admin/config/login/role_login_settings/delete/{rlid}` | `Form\RoleLoginPageSettingsDelete` | Delete a page (confirm form) |

Menu link lives under *Configuration* (`system.admin_config`). Add/list action buttons appear on the
list and add/edit pages (`role_login_page.links.action.yml`).

## Fields on the add / edit form

| Field (form key) | Column | Required | Meaning |
| --- | --- | --- | --- |
| Login page url (`loginmenu_url`) | `url` | yes | Path (no base URL, no leading scheme) where the page appears, e.g. `staff-login` or `portal/login`. Becomes the route `/{url}`. |
| Username label (`username_label`) | `username_label` | no | Label for the username/email field. Default `User Name or Email`. |
| Password label (`password_label`) | `password_label` | no | Label for the password field. Default `Password`. |
| Submit button text (`submit_text`) | `submit_text` | no | Submit button caption. Default `Login`. |
| Page title (`page_title`) | `page_title` | no | The route `_title` shown on the page. |
| Redirect path (`redirect_path`) | `redirect_path` | no | Internal path to send the user to after a successful login. Empty / `/` / `<front>` → `/`. |
| Roles (`roles`) | `roles` | yes | Multi-select of roles allowed to log in through this page; stored comma-joined (e.g. `editor,staff`). |
| Form parent class (`parent_class`) | `parent_class` | no | CSS class added to the form element for theming. |
| Role mismatch error text (`role_mismatch_error_text`) | `role_mismatch_error_text` | no | Message shown when credentials are valid but the account holds none of the allowed roles. Default `You do not have permissions to login through this page.` |
| Invalid credentials error text (`invalid_credentials_error_text`) | `invalid_credentials_error_text` | no | Message shown when authentication fails. Default `Invalid credentials.` |

## Save-time behaviour and validation

- **URL normalisation** — on save, characters `! * ( ) ; : @ + $ , [ ] <space>` in the URL are
  replaced with `-` (`str_replace`), so the stored path is route-safe.
- **URL uniqueness / collision** — the add form validates the resulting URL as a well-formed URL and
  rejects it if `path.validator` already resolves it (`The menu URL already exists`). The edit form
  additionally rejects a URL already used by another row and rejects paths that look like external
  URLs (`http://`, `https://`, `www…`, or containing `.`).
- **Redirect path is checked as an internal route** — if `redirect_path` is non-empty it must resolve
  through `\Drupal::service('path.validator')->getUrlIfValid()` **and** yield a real route name;
  otherwise `Please enter a valid redirect path.` `getUrlIfValid()` returns FALSE for external URLs,
  so an off-site redirect cannot be saved.
- **Cache clear** — after any add/edit/delete, `_role_login_page_settings_cache_clear()` runs
  `drupal_flush_all_caches()` and redirects back to the list. The full flush is what makes the new/
  changed dynamic route (`Routing\RoleLoginRoutes::routes()`) take effect, since routes are generated
  from the table at rebuild time.

## Runtime behaviour of a saved page

- The page is registered with `_user_is_logged_in: 'FALSE'` — **anonymous only**. An authenticated
  user visiting it is redirected away by core's access system.
- On submit: `user.auth`→`authenticate()` verifies credentials; `_role_login_page_validate_login_roles()`
  requires the account to hold **at least one** of the page's roles. Mismatch → role-mismatch error,
  no login. Success → `user_login_finalize()` then the request `destination` is set to `redirect_path`
  (or `/`).

## Operational notes

- Definitions are **not** configuration — they will not travel with `drush cim`/`cex`. Recreate pages
  per environment, or migrate the `role_login_page_settings` table.
- All pages authenticate against the **same** user accounts. The role list gates *who may enter this
  page* and the redirect sets *where they land*; it does not partition credentials. For hard
  separation of who can authenticate at an entrance, combine with an IP/domain restriction module.
- `src/Access/RoleLoginPageAccess.php` exists but is not referenced by any route — the anonymous gate
  is enforced by the route requirement, not by that class.
