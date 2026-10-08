# Duplicate Role — manual setup guide

**Duplicate Role** (`duplicate_role`) adds a **Duplicate** operation to the
user-roles list, so you can create a new role that starts with a copy of an
existing role's permissions. Instead of building a new role from scratch and
re-ticking dozens of permission checkboxes, you clone a well-configured role,
give the copy a new name, and then tweak it.

It's a small convenience tool for site builders. On the **People → Roles** page it
adds a per-row "Duplicate" operation (and a "Duplicate role" local action). The
duplicate form asks which role to copy, a new label, and a new machine name, and on
submit it creates the new role and copies **all of the base role's permissions**
into it.

Note what it does *not* do: it copies **permissions only** — not fields, view/form
displays, or any other configuration. Both the operation and the form are gated by
the **"administer duplicate role"** permission, which is a restrict-access
(trusted-admin) permission. The module has no dependencies beyond core's **User**
module, no settings, no config schema, and no Drush commands.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and grant the permission.
2. [Configuration](configuration/index.md) — how to duplicate a role, field by
   field.

## Where it lives in the admin menu

The feature appears on the roles list at **People → Roles**
(`/admin/people/roles`) as a **Duplicate** operation on each role and a **Duplicate
role** action link. The duplicate form itself lives at
`/admin/people/roles/duplicate/{role}`.

## How to use it

Enable the module and grant the **"administer duplicate role"** permission. Then
go to **People → Roles**, click **Duplicate** on the role you want to copy, give
the new role a name and machine name, and save. The new role is created with the
same permissions as the original, ready for you to adjust. See
[Configuration](configuration/index.md) for the details.
