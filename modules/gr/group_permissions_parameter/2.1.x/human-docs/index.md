# Group Permissions parameter — manual setup guide

**Group Permissions parameter** (`group_permissions_parameter`) lets a group's
effective permissions vary according to custom parameters — a field value on the
group, a state, or any other characteristic — rather than being fixed. It builds
on the [Group Permissions](https://www.drupal.org/project/group_permissions)
module (and, through it, the Group module) to enable more dynamic, rule-driven
group access.

The typical example is group privacy: a group marked "public" might grant
anonymous and non-member users the right to view its content and to join, while a
private group of the same type grants none of that — all driven off a single
"privacy" parameter, recalculated whenever the group is saved. You keep using the
Group module's normal permissions UI for the *fixed* permissions that never
change, and this module layers the *mutable* ones (the ones that depend on your
parameters) on top.

This is primarily a **developer's tool**. You express the parameter-driven rules
in code by writing a `GroupPermissionsParameter` plugin — one plugin per parameter
or one plugin covering several — that returns the permissions for a given group
and declares when they should be applied (on create, on update, on sync). A
service is also provided for setting mutable permissions in other ways if a plugin
does not fit. Because this changes who can do what inside groups, treat it as an
access-control building block and review your rules carefully.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it on top of Group Permissions.

There is **no field-by-field settings form** for this module — the rules are
defined in code (a plugin) rather than through an admin page. The one UI it adds
is a sync form, described under "How to use it" below.

## Where it lives in the admin menu

Group Permissions parameter adds a **sync form** under the **Groups** menu. That
form re-applies permissions on the group level from the group type level — useful
when new permissions should be granted to (or revoked from) existing groups after
you change your rules. Your plugin controls whether the mutable permissions are
applied during a sync. The fixed permissions are still managed through Group's own
permissions UI.

## How to use it

1. Install Group Permissions and enable this module (see
   [Installation](installation/index.md)).
2. Set the fixed (unchanging) permissions as usual through the Group module's
   permissions UI.
3. Write a `GroupPermissionsParameter` plugin (in a custom module) that returns
   the mutable permissions for a group based on your parameter, and declare when
   they apply — on create, on update, and/or on sync. For example, a plugin can
   grant `view` and `join` permissions only when a group's privacy is *public*.
4. When you add or change rules, use the **sync form** under the **Groups** menu
   to re-apply permissions to existing groups.
