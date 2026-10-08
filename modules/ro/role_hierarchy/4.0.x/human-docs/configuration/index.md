# Configuration

Everything is configured on one page: **People → Roles**
(`/admin/people/roles`). The role order defines the ranking, and the module adds a
**Role hierarchy** section to the same form for three options. You need the
**Administer permissions** access that already lets you manage roles.

## The order is the ranking

The heart of the module is simply the order of your roles on the People → Roles
list. By default, **higher in the list means more powerful** (lower weight = more
authority). An account can edit a user, or grant/revoke a role, only when the
target's rank is **at or below** the account's own highest-ranked role.

An account's effective rank is its single **highest** hierarchical role. An
account that holds none of the ranked roles is treated as the weakest of all.

So the setup is:

1. On **People → Roles**, drag your roles into order of real authority — for
   example *Administrator* at the top, then *Editor*, then *Author*, then
   *Authenticated user*.
2. Click **Save**.

Reorder the list any time to change who outranks whom.

## The three hierarchy settings

In the **Role hierarchy** section of the same form:

- **Invert hierarchy** *(off by default)* — flips the direction so that roles edit
  the roles **above** them instead of below. When you turn this on and save, the
  module renumbers the role weights behind the scenes so the visual order on the
  page still matches what you see. Most sites leave this off.

- **Strict hierarchy** *(off by default)* — with it off, accounts of **equal** rank
  can edit each other (peers can manage peers). Turn it on to require a **strictly
  higher** rank, so an Editor cannot edit another Editor — only roles genuinely
  above them.

- **Non-hierarchical roles** — a list of roles to exclude from the hierarchy
  entirely. An excluded role neither raises an account's rank nor is protected by
  the hierarchy. Use this for cross-cutting roles that have nothing to do with the
  authority ladder — for example a "Newsletter subscriber" flag role.

Click **Save** to store all of this. (Technically these are written to a
`role_hierarchy.settings` config object that only comes into existence the first
time you save this form.)

## How the ranking plays out

Once configured, the module quietly enforces the hierarchy in the places where
role and user management happen:

- **On the user add/edit form**, role checkboxes for roles the current editor
  cannot grant are hidden. (Roles the editor already holds on their *own* account
  are never hidden from that form.) The role checkboxes appear when the editor has
  the **Edit user roles** permission.
- **Editing or deleting a user** is blocked when the target account outranks the
  editor.
- **The bulk "Add role to the selected users" / "Remove role from the selected
  users" actions** on the People listing respect the same rules.

## Permissions to review

- **Edit user roles** — forces the role checkboxes to show on the user form (the
  offered roles are still filtered by rank). Give this to the staff who legitimately
  assign roles.
- **Bypass role hierarchy** — exempts an account from **every** hierarchy check.
  Effectively turns this module off for that account, so treat it as sensitive and
  reserve it for genuine site administrators whose edit rights you want governed by
  core/other permissions instead.

Independently of all settings, **user 1** can always edit anyone and can never be
edited by anyone else.
