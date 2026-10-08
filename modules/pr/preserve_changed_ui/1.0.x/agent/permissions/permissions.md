<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions

Defined in `preserve_changed_ui.permissions.yml`. Both are declared `restrict access: true`.

| Permission | Title | Gates |
| --- | --- | --- |
| `administer preserve_changed_ui configuration` | Administer preserve_changed_ui configuration | Access to the settings form route `preserve_changed_ui.settings_form` (`/admin/config/system/preserve-changed-ui`). |
| `preserve_changed_ui allow preserve changed time` | Allow Preserve Changed Time | Whether the "Preserve changed time" checkbox is shown on the node edit form. Users without it get `#access = FALSE` on the field (checkbox hidden). |

Grant via Drush:

```bash
drush role:perm:add editor 'preserve_changed_ui allow preserve changed time'
drush role:perm:add administrator 'administer preserve_changed_ui configuration'
```

Note: the `preserve_changed_ui allow preserve changed time` permission controls only the visibility
of the checkbox in `hook_form_node_form_alter`. The save-time logic in `hook_entity_presave` does not
re-test it.
