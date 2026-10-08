# Permission Group — manual setup guide

**Permission Group** (`permission_group`) lets you bundle a set of related
permissions into a single named group, and then grant that whole bundle to a
role with one checkbox on the standard permissions form. It sits neatly between
the two extremes Drupal gives you today: roles are often too broad a brush, and
individual permissions are too granular to manage comfortably once you have many
entity types and modules installed.

Instead of ticking dozens of individual boxes every time you set up an "Editor"
or "Shop manager" role, you define the bundle once and tick it. The underlying
permissions are kept in sync automatically: enable a group on a role and its
permissions are granted; remove the group and they are revoked. While a group is
assigned to a role, the individual permissions it manages are disabled on the
role form (with a tooltip explaining why) so you cannot accidentally
double-manage them.

Permission groups are **configuration entities**, so they export and deploy like
any other config — handy for keeping permission sets consistent across multiple
sites, or shipping presets in an install profile or recipe. Groups can even
contain other groups, letting you build hierarchies. A separate, restricted
permission lets you delegate just the *group-to-role assignment* to user
administrators without exposing the full permissions form to them.

A word of care: because a group can carry security-sensitive permissions,
granting someone the delegated "assign permission group to role" capability
effectively lets them hand out whatever those groups contain. The module flags
sensitive groups and protects admin roles, but you should still design your
groups and delegate that permission thoughtfully.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — create permission groups, assign
   them to roles, and delegate assignment safely.

## Where it lives in the admin menu

- **People → Permission groups** (`/admin/people/permission_groups`) — the
  collection page where you add, edit and delete permission groups. It requires
  the `administer permissions` permission.
- **People → Permissions** (`/admin/people/permissions`) — the standard role
  permissions form, which now shows a row of group checkboxes at the top.
- **People → Permission groups → Assign to role**
  (`/admin/people/permission_groups/assign_to_role`) — a stripped-down form for
  delegated assignment, gated by the restricted `assign permission group to role`
  permission.
