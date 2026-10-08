<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# alt_login — configuration & settings

## Install / enable
`drush en alt_login`. No hard dependencies. Install `token` for the token-tree UI and `address` to unlock
the first+last-name login method. If you use alias login over HTTP Basic Auth, `basic_auth` must be enabled
(its authentication service is overridden — see api/display-and-auth.md).

## Route & access
- `alt_login.admin` → path `/admin/config/people/alt_login`, form `Drupal\alt_login\Settings`, title
  "Alternative login settings", requirement `_permission: access administration pages`.
- Admin menu link `alt_login.admin` ("Usernames & logins") under `user.admin_index`
  (`alt_login.links.menu.yml`). `configure` in the info file points here.

## Config object `alt_login.settings`
Schema: `config/schema/alt_login.schema.yml` (`type: config_object`). Defaults in
`config/install/alt_login.settings.yml`:

| key | type | default | meaning |
|---|---|---|---|
| `aliases` | sequence of string | `[username]` | Which `AltLoginMethod` plugin IDs are accepted for login. Set via checkboxes on the form. |
| `display` | string | `''` | Token template for the display name shown to authenticated viewers. Empty = fall back to the account name. |
| `display_anon` | text | `Member [user:uid]` | Token template for the display name shown to anonymous viewers. |
| `name_mode` | string | `alt_login_generate_from_address` | Legacy; not read by 2.0.x code. `alt_login_update_8001()` clears an even older `name_mode`. |
| `login` | sequence | `{}` | Legacy/unused in 2.0.x. |

## Settings form (`Settings.php`)
- Extends `ConfigFormBase`; form ID `alt_login_settings`; editable config `alt_login.settings`.
- `aliases`: `#type checkboxes`, `#required`, options from `alt_login.method_manager->getOptions()`; each
  option's `#description` is the plugin's attribute description. Submit stores `array_filter($values)`.
- `display`: textfield, placeholder `[user:name]`, element-validated by `validateDisplayTemplate()` which
  **rejects `[user:display-name]`** (would recurse in `hook_user_format_name_alter`).
- `display_anon`: textfield (tokens `[user:uid]`).
- Token-tree link is shown when `token` is enabled (`#theme token_tree_link`, types `['user']`); otherwise a
  "install token" hint. A static warning notes that changing these can confuse existing users.

## Behavioral note
When `username` is NOT among `aliases`, the account form hides the username field and it is auto-populated
(email for new users, or first+last from the address field) — see api/display-and-auth.md. When `username`
IS enabled, other active aliases are appended to the username field description as a hint.
