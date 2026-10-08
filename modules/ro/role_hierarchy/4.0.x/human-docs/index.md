# Role Hierarchy — manual setup guide

**Role Hierarchy** (`role_hierarchy`) stops lower-privileged users from editing
more powerful accounts or handing out roles above their own rank. On a stock
Drupal site, anyone with permission to administer users can, in effect, promote
themselves or others — a privilege-escalation risk. Role Hierarchy closes that
gap by ranking your roles and enforcing that an account can only manage users and
roles at or below its own level.

The clever part is that you don't manage a separate hierarchy screen. The ranking
**is** the order of your roles on the **People → Roles** page. A role higher in
that list (a lower weight) is treated as more powerful. Drag your roles into the
order that reflects real authority, and the module does the rest — filtering the
role checkboxes on user forms, blocking edits and deletes of higher-ranked
accounts, and making core's bulk "Add role" / "Remove role" actions respect the
same rules.

A few protections are always in place: **user 1** can edit anyone and can never be
edited by anyone else, and every account can always edit itself. Two permissions
tune the behavior — **Edit user roles** shows the role checkboxes on the user
form (still filtered by rank), and **Bypass role hierarchy** exempts trusted
administrators from all of these checks.

Three settings let you adjust how the ranking behaves: invert the direction,
require strictly-higher rank (so peers can't edit peers), and exclude specific
roles from the hierarchy entirely. All three live right on the People → Roles
form.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — set the role order that defines rank,
   and the three hierarchy settings.

## Where it lives in the admin menu

Role Hierarchy has no settings page of its own. Everything is configured on the
**People → Roles** page (`/admin/people/roles`) — you order the roles there, and
the module adds a **Role hierarchy** section to the same form for its three
options.
