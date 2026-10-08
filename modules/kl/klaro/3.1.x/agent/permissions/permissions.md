# Permissions

Defined in `klaro.permissions.yml`:

| Permission | Machine name | Gates | Notes |
|---|---|---|---|
| Administer Klaro! | `administer klaro` | All Klaro settings, text forms, and the `klaro_app` / `klaro_purpose` entity collections (it is the entities' `admin_permission`). | `restrict access: true` — trusted admins only. |
| Use Klaro! UI | `use klaro` | Letting a user (re-)open the Klaro consent manager to configure their preferences. | Safe for regular/authenticated users. |

- Grant at **People → Permissions** (`/admin/people/permissions`).
- Give `use klaro` broadly so visitors can revisit their choices via a "Cookie settings"
  trigger; reserve `administer klaro` for site administrators.
