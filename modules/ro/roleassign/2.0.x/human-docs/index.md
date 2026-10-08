# RoleAssign — manual setup guide

**RoleAssign** (`roleassign`) lets you safely delegate the job of managing user
roles to non-administrators. It solves a classic Drupal problem: normally the
only way to let someone assign roles to other users is to grant them **Administer
permissions** — but that permission also lets them grant *any* right to *any*
role, including handing administrative powers to themselves. RoleAssign closes
that hole.

Instead, the module introduces a new **Assign roles** permission. A trusted site
administrator decides — on a simple settings page — exactly which roles are
"assignable." Any user who has both *Assign roles* and core's *Administer users*
then sees a limited **Assignable roles** checkbox set on the user edit form,
containing only those approved roles. They can hand out an "editor" or
"moderator" role, but nothing that would let them escalate their own privileges.

The restriction is enforced server-side, not just by hiding form fields: roles a
restricted admin isn't allowed to touch are preserved ("sticky") on the account
so they can neither be added nor removed. The *Anonymous* and *Authenticated*
roles are always excluded, and user 1's name, email, and password are protected.
RoleAssign is best for small sites with a single assistant-admin role; if you need
finer "which role may assign which role" control, the Role Delegation module is
the alternative.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — choose which roles are assignable and
   set up the delegation permissions.

## Where it lives in the admin menu

The settings page is at **People → Role assign**
(`/admin/config/people/roleassign` — linked as "Role assign" from the People
section). Only a user with core's **Administer permissions** can open it and
decide the assignable set.

## How to use it

1. As a site administrator, go to **People → Role assign** and tick the roles you
   want to be delegatable.
2. On **People → Permissions**, grant your assistant-admin role both **Assign
   roles** (from this module) and **Administer users** (core).
3. That assistant admin can now edit user accounts and assign only the roles you
   approved — see [Configuration](configuration/index.md) for the details.
