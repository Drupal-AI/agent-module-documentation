<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permission Group — agent index

Bundles multiple permissions into one named group so a role gets them all via a single checkbox
on the permissions form. Requires PHP 7.1+. Provides permissions.

Quick facts:
- Entity: `permission_group` config entity at `/admin/people/permission_groups` (route `entity.permission_group.collection`, perm `administer permissions`).
- Form alter: `hook_form_user_admin_permissions_alter` adds group checkboxes and disables group-managed individual permissions.
- Sync: role third-party setting `permission_group.groups`; `hook_user_role_presave()` grants/revokes the group's permissions on save.
- Delegation: `assign permission group to role` permission (restricted) + `/admin/people/permission_groups/assign_to_role`; admin roles protected. Groups can hold sensitive permissions — grant the delegated permission carefully.
