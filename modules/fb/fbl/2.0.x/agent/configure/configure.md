<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Field Based Login

- **Route:** `fbl.configuration` → `/admin/config/people/fbl` (permission `administer fbl`, `_admin_route: TRUE`).
- **Form:** `Drupal\fbl\Form\FblConfiguration` (`fbl_configuration_form`), a `ConfigFormBase` with
  `entity_field.manager` and `database` injected.
- **Config object:** `fbl.settings`; all settings nested under the key `field_based_login`.
- **Menu:** link under `user.admin_index` (`fbl.links.menu.yml`); local task on `entity.user.collection`
  (`fbl.links.task.yml`).

## Settings keys (`fbl.settings:field_based_login`)

| Key | Type | Default | Meaning |
|---|---|---|---|
| `field` | string | `''` | Machine name of the user account field used as a login identifier. Empty = no custom-field login. |
| `allow_user_name` | boolean | `1` | Allow logging in with the normal username. |
| `allow_user_email` | boolean | `0` | Allow logging in with email. |
| `user_email_source` | string | `display_name` | For email login, resolve the name from `account_name` or `display_name`. |
| `label` | text | `''` | Overrides the login form identifier field `#title` (`Html::escape`d at render). |
| `field_desc` | text | `''` | Sets the login form identifier field `#description` (`Html::escape`d at render). |

## Form behavior (`FblConfiguration`)

- **Field dropdown** is populated only with **user-bundle** fields of type `string`, `integer`, or
  `telephone` (`entityFieldManager->getFieldDefinitions('user','user')`, requiring a non-empty target
  bundle — base fields are excluded).
- **`validateForm`** (blocks save):
  - No `field` chosen **and** `allow_user_name` off → error (pick at least one login method).
  - Chosen field has **duplicate values** across users → error (`checkForDuplicates()` groups
    `user__{field}` by `{field}_value`).
  - Non-blocking warnings: chosen field is not marked required; some users have no value for it
    (`getUserCount()` vs `getFieldDataCount()`).
- **`submitForm`** `strip_tags`es `label` and `field_desc`, then saves the whole `field_based_login` array.

## Runtime effect (`fbl.module`)

- `fbl_form_alter` prepends `fbl_login_name_validate` to `user_login_form` `#validate` and applies
  `label`/`field_desc` to the name field.
- `fbl_login_name_validate`: if `field` is set, entity-queries users on `{field}.value == input`; a single
  match is resolved to the account's real username (looked up in `users_field_data`) and written back with
  `setValue('name', …)`; more than one match is rejected with an error. It then also resolves by
  `user_load_by_name` (if `allow_user_name`) and `user_load_by_mail` (if `allow_user_email`, using
  `user_email_source`). No match → neutral "unrecognized username or password" error. Core then
  authenticates the password against the resolved username.
- `fbl_user_register_validate` (on `user_form` / `user_register_form`) rejects a duplicate `field` value,
  excluding the current user on edit.

## Config translation

`fbl.config_translation.yml` exposes `fbl.settings` (base route `fbl.configuration`) so `label` and
`field_desc` can be translated. Requires the core Configuration Translation module (optional).

## Uninstall

`fbl_uninstall` (`fbl.install`) deletes the `fbl.settings` config object.
