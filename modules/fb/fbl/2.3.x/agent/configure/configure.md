<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Field Based Login

- **Route:** `fbl.configuration` → `/admin/config/people/fbl` (permission `administer fbl`, `_admin_route`).
- **Form:** `Drupal\fbl\Form\FblConfiguration` (`fbl_configuration_form`), a `ConfigFormBase`.
- **Config object:** `fbl.settings`, all settings nested under key `field_based_login`.

## Settings keys (`fbl.settings:field_based_login`)

| Key | Type | Default | Meaning |
|---|---|---|---|
| `field` | string | `''` | Machine name of the user account field used as a login identifier. Empty = disabled. |
| `allow_user_name` | boolean | `1` | Allow logging in with the normal username. |
| `allow_user_email` | boolean | `0` | Allow logging in with email. |
| `user_email_source` | string | `display_name` | For email login, resolve name from `account_name` or `display_name`. |
| `label` | text | `''` | Overrides the login form username field `#title` (escaped). |
| `field_desc` | text | `''` | Sets the login form username field `#description` (escaped). |

## Form behavior

- The **field** dropdown is populated only with **user-bundle** fields of type `string`, `integer`, or
  `telephone` (`entity_field.manager` → `getFieldDefinitions('user','user')`). Base fields are excluded
  (requires a non-empty target bundle).
- **Validation** (blocks save):
  - If no `field` is chosen **and** `allow_user_name` is off → error (must pick at least one login method).
  - If the chosen field has **duplicate values** across users → error (`checkForDuplicates`, groups
    `user__{field}` by `{field}_value`). The field must be unique.
  - Warnings (non-blocking): field is not marked required; some users have no value for the field.
- **Submit** strips tags from `label` and `field_desc`, then saves under `field_based_login`.

## Runtime effect (set by `fbl.module`, no code to read)

- `fbl_form_alter` prepends `fbl_login_name_validate` to `user_login_form` `#validate`, and applies
  `label`/`field_desc` to the name field.
- On login, the entered value is looked up by `field` (entity query on `{field}.value`), then by
  username (if `allow_user_name`), then by email (if `allow_user_email`); the first match rewrites the
  form `name` to that account's real username so **core** authenticates the password. A field match on
  **>1 account is rejected** with an error.
- `fbl_user_register_validate` (on `user_form`/`user_register_form`) rejects saving a value for `field`
  that already exists on another account, keeping the identifier unique.

## Config translation

`fbl.config_translation.yml` exposes `fbl.settings` for translation (translate `label`/`field_desc`).
Requires the core Config Translation module (optional; not a hard dependency).
