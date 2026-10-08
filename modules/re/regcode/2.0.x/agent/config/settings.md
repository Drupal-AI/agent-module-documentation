<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Install, configuration, routes, forms, Drush, and Views

## Install & enable

```bash
composer require drupal/regcode
drush en regcode -y
```

Depends on core **`views`** only. `rules` is a `test_dependency`, not required at runtime. No
sub-modules ship in 2.0.x (`tests/modules/regcode_alterer` is a test fixture, not installable
functionality). Enabling creates the `regcode` table (`regcode_schema()`) and imports the config
objects `regcode.settings` and `views.view.regcode`.

## Permission & routes

Single permission **`administer registration codes`** (`regcode.permissions.yml`) gates every admin
route:

| Route | Path | Provider |
|---|---|---|
| `view.regcode.page_admin` | `/admin/config/people/regcode` | View `views.view.regcode` (the code list; menu link `regcode.admin_list` under *People*) |
| `regcode.admin_create` | `/admin/config/people/regcode/create` | `RegcodeAdminCreateForm` |
| `regcode.admin_manage` | `/admin/config/people/regcode/manage` | `RegcodeAdminManageForm` |
| `regcode.admin_settings` | `/admin/config/people/regcode/settings` | `RegcodeAdminSettingsForm` (`configure` route) |

Tabs are defined in `regcode.links.task.yml`; the list is the base route.

## Config object `regcode.settings`

Defaults (`config/install/regcode.settings.yml`), schema (`config/schema/regcode.schema.yml`,
type `config_object`):

| Key | Type | Default | Meaning |
|---|---|---|---|
| `regcode_field_title` | label | `Registration Code` | Label of the code field on the register form. |
| `regcode_field_description` | text | `Please enter your registration code.` | Help text under the field. |
| `regcode_optional` | boolean | `false` | If TRUE, users can register **without** a code (field not required). |
| `regcode_generate_format` | string | `alpha` | Default format for the generate form (`alpha`/`numeric`/`alphanum`/`hexadec`). |
| `regcode_generate_case` | boolean | `false` | Default "uppercase generated codes" toggle. |

`RegcodeAdminSettingsForm` (a `ConfigFormBase`) edits only the first three keys;
`regcode_generate_*` are used as defaults on the create form. (`getVocabTerms()` also reads an
undeclared `regcode_vocabulary` key — legacy tagging, not set by the settings form.)

## Registration-form behaviour (`regcode.module`)

- `regcode_entity_extra_field_info()` registers `regcode` as an extra form field on the `user`
  entity form display; the field is rendered only when that display component is present
  (`regcode_form_user_register_form_alter()`).
- The field is **required** unless `regcode_optional` is TRUE **or** the current user has
  `administer users` (so admins can create accounts without a code).
- `?regcode=XYZ` in the register URL pre-fills and disables the field (value is validated later, not
  printed raw).
- Validation: `regcode_code_element_validate()` → `registration_code::validateCode()`; on failure it
  sets a form error via `regcode_errormsg()`.
- Submit: `regcode_user_register_form_submit_handler()` → `registration_code::consumeCode($code,
  $uid)` after the account is created, logging the redemption.

## Create / generate codes

`RegcodeAdminCreateForm` (`/create`): fields *Registration code* (blank = generate; used as prefix
when generating >1), *Maximum uses* (0 = unlimited, default 1), *Code size* (default 12), *Format*,
*uppercase*, *Active from* / *Expires on* dates, and *Number of codes*. It calls
`generate()` then `save(..., MODE_SKIP)` per code.

Drush (`RegcodeDrushCommands`):

```bash
drush regcode:validate CODE                # is CODE valid?
drush regcode:consume CODE UID             # redeem CODE, attribute to user UID
drush regcode:generate --length=12 --output=alpha --case --qty=5 --maxuses=1 --active=1
```

## Bulk clean

`RegcodeAdminManageForm` (`/manage`) offers three checkbox operations mapped to
`clean()`: *Delete all* (`CLEAN_TRUNCATE`), *Delete all expired* (`CLEAN_EXPIRED`), *Delete all
inactive* (`CLEAN_INACTIVE`). "This operation cannot be undone."

## Views integration (`regcode.views.inc`)

`hook_views_data()` exposes the `regcode` table (base = `rid`, join to `users` on `uid`) with
fields/filters/sorts for every column. The shipped View `views.view.regcode` provides the admin
listing page. `regcode_views_default_views_alter()` injects **Views Bulk Operations** actions
(activate / deactivate / delete, plus legacy mailer/tag actions) **only when
`views_bulk_operations` is enabled**.

## Upgrade note

`regcode_update_10200()` migrates the default View's empty-text area from `full_html` to
`plain_text` (only if unchanged from the shipped default). All procedural `regcode_*()` API
functions in `regcode.module` are deprecated (removed in 3.0.0) in favour of the service.
