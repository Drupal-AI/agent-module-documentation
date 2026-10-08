# Permissions

Defined in `simple_klaro.permissions.yml`. Both are flagged `restrict access: true`, so the
permissions UI warns before granting them to a role.

| Permission | Title | Grants |
|-----------|-------|--------|
| `administer simple klaro` | Administer Simple Klaro | Access the settings form at `/admin/config/system/simple-klaro` (route `simple_klaro.settings`). This is the only thing gated by the module's route. |
| `bypass simple klaro` | Bypass Simple Klaro | Use the site **without** the Klaro consent manager. `simple_klaro_page_attachments()` returns early for these users, so no config/library is attached; `PreferencesDialog::blockAccess()` also forbids the re-open block for them. |

Notes for operators:

- Grant `bypass simple klaro` deliberately. A user holding it sees pages with no consent gating, so
  their session is not representative of a normal visitor's — verifying "does the tracker fire only
  after consent?" while holding it will not reflect the visitor experience.
- Neither permission is granted to any role by default.

Grant via Drush:

```bash
drush role:perm:add editor 'bypass simple klaro'
drush role:perm:add administrator 'administer simple klaro'
```
