<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure automatic role assignment

Form: **`/admin/config/content/form_mode_manager/role-assign`**
(route `form_mode_manager.admin_settings_roles_assign`, form `FormModeManagerRolesForm`,
permission `administer site configuration`). Config object:
**`form_mode_user_roles_assign.settings`**.

## Config shape

```yaml
form_mode_user_roles_assign.settings:
  form_modes:
    user_<form_mode>:            # 'user_' + the user form-mode machine name
      assign_roles:
        <role_id>: <role_id>     # roles to assign for that form mode
```

Example — a user form mode `partner` should assign the `partner` role:

```yaml
form_modes:
  user_partner:
    assign_roles:
      partner: partner
```

## How it is applied (`FormAlter`)

- Only runs when the current route is a Form Mode Manager route for the `user` entity type
  (`_form_mode_manager_entity_type_id === 'user'`) **and** the path matches the register/create
  pattern `/(user/register/…)|(admin/people/create/…)/`.
- It reads `form_modes.user_<mode>.assign_roles` and adds each role id to
  `$form['account']['roles']['#default_value']` — i.e. the roles are **pre-checked defaults** on
  the registration form for that mode.
- Requires the corresponding user form mode to be set up in Form Mode Manager (so the register
  route for that mode exists).

## Drush

```bash
# assign the 'partner' role on the 'partner' user form mode registration:
drush php:eval '\Drupal::configFactory()->getEditable("form_mode_user_roles_assign.settings")
  ->set("form_modes.user_partner.assign_roles", ["partner" => "partner"])->save();'

drush cget form_mode_user_roles_assign.settings form_modes.user_partner.assign_roles
```
