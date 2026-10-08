<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions

Defined in `search_autocomplete.permissions.yml`:

| Permission | Gates |
|---|---|
| `administer search autocomplete` | The admin UI (`/admin/config/search/search_autocomplete`), the add/edit/delete entity forms, and the `autocompletion_configuration` config entity's `admin_permission`. Also required by the `search_autocomplete.view_autocomplete` helper route. |
| `use search autocomplete` | Allows a user to use autocompletion on the configured fields on the front end. |

Grant with drush:

```bash
drush role:perm:add authenticated 'use search autocomplete'
drush role:perm:add content_editor 'administer search autocomplete'
```

Access to editing/deleting a specific configuration is further controlled by the entity's own
`editable` / `deletable` flags via `AutocompletionConfigurationAccessControlHandler`.
