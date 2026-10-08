<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure CAS Attributes

One config object, `cas_attributes.settings`, edited at
`/admin/config/people/cas/attributes` (route `cas_attributes.settings`).

## Full shape (with install defaults)

```yaml
sitewide_token_support: false      # store attributes in the session so [cas:attribute:?] works anywhere
token_allowed_attributes: []       # lower-cased allow-list; empty = all attributes
field:
  sync_frequency: 0                # 0 Never | 1 Initial registration only | 2 Every login
  overwrite: false                 # replace an existing field value?
  mappings: {}                     # user field name => string containing tokens
role:
  sync_frequency: 0                # 0 Never | 1 Initial registration only | 2 Every login
  deny_login_no_match: false       # refuse CAS login when no role matched
  deny_registration_no_match: false# refuse CAS auto-registration when no role matched
  mappings: []                     # ordered list of role-mapping conditions
```

`field.mappings` always offers `name` (username) and `mail`, plus every **bundle** field on
the user entity whose type is `string`, `list_string` or `integer`. Values are token strings:

```yaml
field:
  mappings:
    mail: '[cas:attribute:email]'
    name: '[cas:attribute:displayname]'
    field_department: '[cas:attribute:ou:first]'
```

Each entry in `role.mappings` is:

| Key | Values | Meaning |
|---|---|---|
| `rid` | role id | role to grant (the `authenticated` role is never offered) |
| `attribute` | string | CAS attribute name; compared case-insensitively |
| `value` | string | value to compare against (a regex, including delimiters, for `regex_any`) |
| `method` | `exact_single` \| `exact_any` \| `contains_any` \| `regex_any` | comparison, see [api/events.md](../api/events.md) |
| `negate` | bool | grant the role when the comparison **fails** |
| `remove_without_match` | bool | remove the role when the comparison fails — **also removes manually assigned roles** |

A mapping row is discarded on save unless `rid`, `attribute` and `value` are all non-empty.

## Read the live setup

```bash
drush cget cas_attributes.settings
drush cget cas_attributes.settings role.mappings
drush cget cas_attributes.settings field.mappings
drush cget cas_attributes.settings field.sync_frequency     # 0/1/2
```

## Write it with Drush

Scalars are easy:

```bash
drush cset cas_attributes.settings sitewide_token_support 1 -y
drush cset cas_attributes.settings field.sync_frequency 2 -y
drush cset cas_attributes.settings field.overwrite 1 -y
drush cset cas_attributes.settings role.sync_frequency 2 -y
drush cset cas_attributes.settings role.deny_login_no_match 1 -y
drush cset cas_attributes.settings 'field.mappings.mail' '[cas:attribute:mail]' -y
```

Lists/maps are easiest from PHP:

```bash
drush php:eval '
  \Drupal::configFactory()->getEditable("cas_attributes.settings")
    ->set("token_allowed_attributes", ["mail", "displayname"])
    ->set("field.mappings", ["mail" => "[cas:attribute:mail]"])
    ->set("role.mappings", [[
      "rid" => "staff",
      "attribute" => "eduPersonAffiliation",
      "value" => "faculty",
      "method" => "contains_any",
      "negate" => FALSE,
      "remove_without_match" => TRUE,
    ]])
    ->save();
'
```

`token_allowed_attributes` is stored **lower-cased** (the form lower-cases and trims each
line before saving).

## Via the UI

1. *Configuration → People → CAS → CAS Attributes* (`/admin/config/people/cas/attributes`).
2. **General Settings** — tick *Sitewide token support* to expose `[cas:attribute:?]`
   everywhere; the *Allowed Attributes* textarea (one name per line) then appears.
3. **User Field Mappings** — pick when mappings apply, whether to overwrite, then type token
   strings into the per-field textfields.
4. **User Role Mappings** — pick when they apply, the two deny checkboxes, then fill the
   *Role Mapping* fieldsets. A blank row is always appended for adding another; existing rows
   get a *Remove this mapping?* checkbox.

## Gotchas

- Field-mapping tokens work **even with sitewide token support off** — the subscriber passes
  the attributes straight into the token replacement. Sitewide support is only needed for
  tokens used elsewhere (webforms, blocks) and for the *Available Attributes* page.
- `field.sync_frequency: 1` ("Initial registration only") requires CAS's *Auto register
  users* setting to be enabled, otherwise no registration event fires.
- `deny_login_no_match` is evaluated **regardless of `role.sync_frequency`** — the role check
  runs on every `CasPreLoginEvent` even when sync frequency is Never.
- `remove_without_match` will strip a role a human granted by hand. Use with care.
- Only `string`, `list_string` and `integer` user fields appear in the mappings form; there is
  no support for entity references, dates or multi-value fields.
- Two `post_update` hooks converted 2.x serialized mappings to plain arrays
  (`cas_attributes_post_update_unserialize_mappings`) and defaulted
  `token_allowed_attributes` — run `drush updb` after upgrading from 2.x.
