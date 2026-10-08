<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# RoleAssign with User CSV Import — agent index

Glue submodule of **user_csv_import**. Makes the CSV import form's **Roles** checkboxes show
only the roles allowed by the **RoleAssign** module. Depends on `user_csv_import` + `roleassign`.
No config, permissions, schema, services or Drush of its own.

## What it does (the whole module)

Implements `hook_form_alter()` for the `user_csv_import_form`. It reads RoleAssign's assignable
roles and intersects them with the form's role options:

```php
function roleassign_with_user_csv_import_form_alter(&$form, $form_state, $form_id) {
  if ($form_id == 'user_csv_import_form') {
    $assignable_roles = array_filter(\Drupal::config('roleassign.settings')->get('roleassign_roles'));
    if (!empty($assignable_roles) && is_array($assignable_roles)) {
      $form['config_options']['roles']['#options'] =
        array_intersect_key($form['config_options']['roles']['#options'], array_flip($assignable_roles));
    }
  }
}
```

Key facts:
- The behaviour is driven entirely by **`roleassign.settings` → `roleassign_roles`** (a list of
  assignable role ids), owned by the RoleAssign module. This submodule reads it; it does not set it.
- If `roleassign_roles` is empty, the form is left showing all roles (no filtering).
- Read the assignable roles: `drush cget roleassign.settings roleassign_roles`.
- Parent module docs → [../../../../2.0.x/agent/start.md](../../../../2.0.x/agent/start.md)
