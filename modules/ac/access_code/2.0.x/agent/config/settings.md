<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings & install

## Install / enable

Depends only on core `user`. Enable with `drush en access_code -y` (or the UI). Installing runs
`access_code_schema()` which creates the `access_code` DB table. No third-party libraries, no
Composer requirements beyond core.

## Settings form — `Form\SettingsForm`

- Route `access_code.settings` at **`/admin/config/people/access_code`**, permission
  `administer account settings`. Menu link defined in `access_code.links.menu.yml`
  (parent `user.admin_index`).
- `ConfigFormBase`; editable config object: **`access_code.settings`**. Built with the
  `access_code.manager` service injected.

### Config keys (written by `submitForm()`)

| Key | Widget / options | Default | Meaning |
|-----|------------------|---------|---------|
| `auto_code_length` | select 4–12 | `8` | Length of an auto-generated code, **excluding** the prefix. |
| `auto_code_prefix` | textfield (≤ 20) | `''` | Optional string prepended to generated codes. |
| `auto_code_format` | radios `alpha` / `numbers` / `letters` | `alpha` | Character set for generated codes (`alpha` = digits + uppercase letters). |
| `expiration_default` | select `none` … `10 years` | `1 month` | Expiration auto-filled when creating a *new* code on a new user. |
| `blocked_roles` | checkboxes (roles, minus anonymous/authenticated) | `[]` | Roles whose members may **not** use access-code login; enforced in `AccessCodeManager::validateAccessCode()` and disables the code fields on their user form. |
| `display_input` | checkbox | `0` (off) | When on, the `/user/ac` login field is a plain `textfield` (shows typed characters) instead of a masked `password` field. |

No `config/schema/*` or `config/install/*` ships with the module — the object is created only when
the settings form is first saved, and Drupal has no typed-config schema for it (expect a
"missing schema" warning under strict config checking). `hook_uninstall` clears `auto_code_length`,
`auto_code_prefix`, `auto_code_format`, `expiration_default` and `display_input` (but not
`blocked_roles`).

## Generation & expiration behaviour

- `AccessCodeManager::generateRandomCode()` reads `auto_code_length` / `auto_code_format` /
  `auto_code_prefix`, enforces a minimum length of 4, and retries up to 10 times to obtain a code
  unique across all users (`checkUniqueCode()`); returns `NULL` and logs an error if it cannot.
- On a new user, if `expiration_default` is not `none`, the expiration field is pre-filled that far
  in the future. Expirations are stored as Unix timestamps; the form rejects dates in the past and
  beyond year 2037.

## Per-user management

Codes are set on the user add/edit form, not here — see
[../api/login-and-codes.md](../api/login-and-codes.md) for the fields, permission gating and the
`change own access code` / `change any access code` permissions.
