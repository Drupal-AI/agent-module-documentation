# Configuration

Working with Permission Group is a three-part cycle: create a group, put
permissions in it, and assign it to the roles that should have them.

## Open the permission groups page

1. Log in as a user with the **Administer permissions** (`administer permissions`)
   permission.
2. Go to **People → Permission groups** (`/admin/people/permission_groups`).

This collection page lists your existing groups and provides **Add**, **Edit**
and **Delete** actions.

## Create a permission group

1. Click **Add permission group**.
2. Give it a clear **label** — something that names a job or capability set, such
   as "Editorial" or "Shop manager tools". The machine name is derived from it.
3. Save. You will then choose the permissions the group contains on its
   permission-selection form — tick every individual permission that should
   travel together as this bundle. You can also include other permission groups,
   letting you compose a larger group from smaller ones.
4. Save the group. It is stored as a configuration entity, so it will appear in
   your configuration export and can be deployed to other environments.

## Assign a group to a role

You have two ways to do this:

- **On the standard permissions form.** Go to **People → Permissions**
  (`/admin/people/permissions`). Your groups appear as checkboxes at the top of
  the table. Tick a group for a role and, when you save, all of that group's
  permissions are granted to the role. The individual permissions the group
  manages are shown disabled (with a tooltip) so you do not manage them twice.
  Untick the group to revoke its permissions again. The reconciliation happens
  automatically when the role is saved.

- **Via the delegated assign-to-role form.** If you want a user administrator to
  be able to assign groups *without* seeing the full permissions matrix, grant
  them the restricted **Assign permission group to role**
  (`assign permission group to role`) permission and point them at
  **People → Permission groups → Assign to role**
  (`/admin/people/permission_groups/assign_to_role`).

## A caution on the delegated permission

The `assign permission group to role` permission is deliberately marked as
restricted. Because groups can contain security-sensitive permissions, anyone
holding it can effectively hand out whatever those groups include. Grant it only
to trusted staff, and be mindful of what you put into groups that such users can
assign. The module protects administrator roles from being modified through the
group checkboxes, but the contents of your groups are still your responsibility —
design them so a delegated assigner cannot escalate privileges beyond what you
intend.
