# Group Permissions Template — manual setup guide

**Group Permissions Template** (`group_permissions_template`) lets you define
reusable **permission templates** and apply them to groups. It builds on the
[Group](https://www.drupal.org/project/group) and
[Group Permissions](https://www.drupal.org/project/group_permissions) modules: a
template holds a predefined set of group-role permissions, and applying it stamps
those permissions onto one group — or, when a template changes, onto every group
linked to it — so group configuration stays consistent and repeatable at scale.

The workflow is: you create a template for a group type, choosing the permissions
it should carry; each template is stored as exportable configuration. You then
enable a **Permission Templates** field on the group type's form display, and on
an individual group you pick which template applies. When the group is saved, the
template's permissions are applied to it (through the Group Permissions module).
Unset the template on a group and its permissions are reset on save; change a
template and every group linked to it is updated on save.

Because applying a template changes what group members can do, this is an
**access-control administration tool** — a privileged one. It configures group
permissions but makes no runtime access decision of its own; the actual
enforcement is still done by Group and Group Permissions. Gate the module's
permissions to trusted administrators, and review a template carefully before
applying it broadly, since a single change ripples out to every group that uses
it.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it on top of Group and Group Permissions.
2. [Configuration](configuration/index.md) — create templates, enable the template
   field on a group type, and link a template to a group.

## Where it lives in the admin menu

You manage templates at **`/admin/group/group_permissions_template`**, enable the
**Permission Templates** field through a group type's **Manage form display**
(`/admin/group/types/manage/[group_type]/form-display`), and link a template on
each group. See [Configuration](configuration/index.md).
