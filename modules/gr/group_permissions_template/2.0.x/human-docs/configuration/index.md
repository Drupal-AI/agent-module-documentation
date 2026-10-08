# Configuration

Configuring Group Permissions Template has three steps: create the templates,
enable the template field on the group type, and link a template to each group
that should use it.

## 1. Create a permission template

1. Log in as a trusted administrator.
2. Go to **`/admin/group/group_permissions_template`** (the template listing).
3. Add a template and choose the **group type** it is based on.
4. Set the permissions you want the template to carry, and save.

Each template you create is stored as exportable configuration, so it can be moved
between environments with your other config.

## 2. Enable the Permission Templates field on the group type

For groups to be able to use a template, the group type needs the **Permission
Templates** field on its group form.

1. Go to the group type's **Manage form display**:
   `/admin/group/types/manage/[group_type]/form-display` (replace
   `[group_type]` with your group type's machine name).
2. Enable the **Permission Templates** field there and save.

## 3. Link a template to a group

1. Edit an individual group of that type.
2. In the **Permission Templates** field, select the template you want to apply.
3. Save the group.

On save, the template's permissions are applied to the group (via the Group
Permissions module).

## How changes propagate

- **Unset the template** on a group and save — the group's permissions are reset
  at that save action.
- **Change a template's permissions** — when saved, all group instances linked to
  that template are updated accordingly.

Because a single template change ripples out to every group linked to it, review a
template carefully before editing or bulk-applying it. Applying templates is a
privileged action: keep the module's permissions restricted to trusted
administrators. The template only *configures* group permissions — the actual
access enforcement is still handled by Group and Group Permissions.
