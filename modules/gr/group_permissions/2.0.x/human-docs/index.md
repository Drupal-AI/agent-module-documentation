# Group permissions — manual setup guide

**Group permissions** (`group_permissions`) lets an individual group override the
permissions its group type defines. In the plain
[Group](https://www.drupal.org/project/group) module, permissions belong to the
*group type*: every group of type "Team" gives its Member role exactly the same
rights. That is a clean model right up until the twentieth team needs one extra
permission — at which point the usual workaround is a proliferation of
near-identical group types. This module removes that need.

It does so by storing a per-group override set (a `group_permission` content
entity) and giving each group a permissions form at `/group/{group}/permissions`.
The group type's permissions act as the defaults; a group can then completely
override them for its own members. Two groups of the same type can therefore grant
different rights, without you ever creating a second group type. Overrides can
also be reverted back to the type's defaults, and the module keeps revisions so you
can see the history of changes.

The overrides are authoritative, not cosmetic: they are enforced wherever access
is decided, including entity queries and listings, so a group's effective
permissions genuinely reflect its override set. Access to the override form itself
is deliberately tight — it is gated by Group's in-group **override group
permissions** check (evaluated inside the group, not as a site-wide role) together
with a check that overriding has actually been switched on for that group type. The
site-wide **override group permissions** permission is marked as
restricted, correctly, because it is the power to grant rights inside groups.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it on top of Group.
2. [Configuration](configuration/index.md) — switch on overriding for a group
   type, grant the permission, and edit a single group's permissions.

## Where it lives in the admin menu

Group permissions has no single settings page. You enable overriding on a group
type, grant the **override group permissions** permission, and then edit each
group's overrides at **`/group/{group}/permissions`** (the *Permissions* tab on a
group). See [Configuration](configuration/index.md).
