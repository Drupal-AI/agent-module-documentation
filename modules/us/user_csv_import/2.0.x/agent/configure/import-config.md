<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The import form, its options & saved config

There is **no separate settings page**. Options are set on the import form
(`user_csv_import_form`) at `/admin/people/import`, and can be persisted for next time.

## Form options

| Option | Notes |
|---|---|
| **Roles** (checkboxes) | Roles granted to every imported user. **Authenticated is mandatory** (locked on). |
| **Separator character** | CSV delimiter, default `,` (use `;` for French Excel). |
| **Default password** | Applied to all imported users unless a per-row `pass` column overrides it. Default literal `change me`. |
| **Status** | `1` Active / `0` Blocked. Use Active if sending a welcome email so users can log in. |
| **Registration email type** | `none` (send nothing) or `register_admin_created` ("Welcome (new user created by administrator)"). |
| **Select fields to import** (checkboxes) | Which user fields the CSV columns map to. **`name` and `mail` are mandatory** (locked on). |
| **Save configuration** | If ticked, persists the options below to `user_csv_import.importconfig`. |
| **CSV file upload** | `.csv` only. |

Two submit buttons: **Import users** and **Generate sample CSV** (downloads a template built
from the ticked fields — see [api/import.md](../api/import.md)).

## Saved config object

Only written when **Save configuration** is ticked (`submitForm()`):

```yaml
# user_csv_import.importconfig  (no config schema is shipped)
roles: { authenticated: authenticated, editor: editor }   # checkbox values
status: '1'                 # '1' Active, '0' Blocked
password: 'change me'       # default password
registration_email_type: register_admin_created   # or 'none'
config_fields: { name: name, mail: mail, timezone: timezone }
```

Read/write via the config API:

```php
\Drupal::configFactory()->getEditable('user_csv_import.importconfig')
  ->set('password', 'Welcome123!')
  ->set('status', '1')
  ->set('roles', ['authenticated' => 'authenticated', 'editor' => 'editor'])
  ->set('registration_email_type', 'register_admin_created')
  ->save();
```

`drush cget user_csv_import.importconfig`. These values only **pre-fill** the form; an import
uses whatever is currently on the submitted form.

## CSV structure

- **Row 1**: field machine names as column headers (lower-case), e.g.
  `name,mail,field_first_name,field_last_name,field_phone`.
- **Following rows**: one user each, values in the same column order.
- `name` and `mail` are required columns. Most core field types import except **Image** and
  **Taxonomy term**. A `pass` column sets a per-user cleartext password (stored hashed).
