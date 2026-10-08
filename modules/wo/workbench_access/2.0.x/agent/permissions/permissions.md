<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions

Defined in `workbench_access.permissions.yml`. The `access_scheme` config entity's
`admin_permission` is `administer workbench access`.

| Permission | Gates | restrict access |
|---|---|---|
| `administer workbench access` | Configure the module and its access schemes (add/edit/delete schemes, settings form). | yes |
| `assign workbench access` | Assign users and roles to **all** editorial sections. | yes |
| `assign selected workbench access` | Assign users/roles only within sections the assigner already belongs to. | yes |
| `batch update workbench access` | Perform batch section assignment from the content overview page. | no |
| `bypass workbench access` | Automatically granted access to **every** section (super-editor). | yes |
| `use workbench access` | Marks a role's members as assignable to sections. | no |
| `view workbench access information` | View the editorial-section access status shown on each content page. | no |

## Notes

- Access is **additive / deny-only**: Workbench Access only removes access from untrusted
  users. An editor still needs a normal edit permission (e.g. *Article: Edit any content*)
  in addition to section membership.
- `bypass workbench access` short-circuits all section checks — grant sparingly.
- `use workbench access` must be on a role before its users can be assigned to sections.

List them live:

```bash
drush php:eval 'echo implode("\n", array_keys(
  \Drupal::service("user.permissions")->getPermissions()));' | grep -i "workbench access"
```
