<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings (configure)

All configuration is one config object, `samlauth_restrict_to_ou.settings`, edited on a single form.

- Route: `samlauth_restrict_to_ou.settings` → `/admin/config/people/saml-restrict`.
- Form: `Drupal\samlauth_restrict_to_ou\Form\SettingsForm` (`ConfigFormBase`; form id
  `samlauth_restrict_to_ou_settings`; `getEditableConfigNames()` = `['samlauth_restrict_to_ou.settings']`).
- Permission required: `administer samlauth_restrict_to_ou` (declared `restrict access: true`).
- Menu link: `samlauth_restrict_to_ou.settings`, parent `user.admin_index`, weight 100.
- Schema: `config/schema/samlauth_restrict_to_ou.schema.yml`. Install defaults:
  `config/install/samlauth_restrict_to_ou.settings.yml`.

## Config keys

| Key | Type | Install default | Form element | Meaning |
|---|---|---|---|---|
| `enabled` | boolean | `false` | checkbox "Restrict Login to OUs" | Master switch. When `false`, the subscriber returns immediately and **every** SAML user is allowed. |
| `saml_attribute_name` | string | `'dn'` | textfield "SAML Attribute Name" | Machine name of the SAML attribute holding the OU/DN data. Not `#required`; the form falls back to `dn` as the shown default. |
| `allowed_ous` | string | `''` | textarea "Allowed OUs" | Newline-separated list of OU names, **without** any `ou=` prefix. Case-insensitive. |
| `strict_mode` | boolean | `false` | checkbox "Enable Strict Mode" | `false` (default) = user must belong to **any one** listed OU (OR). `true` = user must belong to **all** listed OUs (AND). |
| `denied_message` | string | `'Your Organizational Unit is not authorized to access this site.'` | textarea "Access Denied Message" | Message shown to a rejected user. Rendered as HTML markup on the response (see events/user-sync.md). |

The form wraps `saml_attribute_name`, `allowed_ous`, `strict_mode` and `denied_message` in a
`#states` container that is only visible when `enabled` is checked (UI convenience only — the values
persist regardless).

## submitForm() normalization (`SettingsForm.php:114`)

`allowed_ous` is cleaned before saving: `\r` stripped, split on `\n`, each line `trim()`ed,
empty lines dropped (`array_filter`), re-joined with `\n`. `saml_attribute_name` and `denied_message`
are `trim()`ed; `enabled`/`strict_mode` are cast to `(bool)`. The saved `allowed_ous` is therefore a
clean newline-separated string that the subscriber re-splits the same way at read time.

## Drush / programmatic equivalent

```bash
ddev drush cset samlauth_restrict_to_ou.settings enabled true -y
ddev drush cset samlauth_restrict_to_ou.settings saml_attribute_name dn -y
ddev drush cset samlauth_restrict_to_ou.settings strict_mode false -y
# allowed_ous is a single newline-joined string, e.g. "Staff\nFaculty":
ddev drush cset samlauth_restrict_to_ou.settings allowed_ous "$(printf 'Staff\nFaculty')" -y
```

Note: `SettingsForm` injects `entity_field.manager` (`EntityFieldManagerInterface`) in its
constructor but does not use it — a leftover dependency, harmless.
