# Role Switcher — manual setup guide

**Role Switcher** (`role_switcher`) lets a logged-in user who holds **more than one
custom role** choose which single role is "active" for their current browser
session — **without ever changing their stored role assignment**. By default Drupal
always applies the union of all a user's roles; Role Switcher lets a multi-hat
account narrow itself to one role at a time, then revert.

It adds an **"Acting as" dropdown** — available both as a standalone form at
`/user/role-switch` and as a block (the Role Switcher block) — where the user picks
one of their own roles to act as, or selects "All my original roles" to go back to
the full set. This is useful for accounts that genuinely wear several hats (think
CSR/volunteer/trustee), for testing how the site behaves under a single role, and for
demonstrating role-specific UI to stakeholders.

> **Note on the machine name.** The project is `role_switcher_session` on
> drupal.org, but the module's machine name is `role_switcher`. Install with the
> project name and enable with the machine name (see
> [Installation](installation/index.md)).

The module supports Drupal 10 and 11 and depends only on core's User module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration form** — enable the module and optionally place the block.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. *(Optional)* Place the **Role Switcher block** in a region via **Structure →
   Block layout** so the "Acting as" dropdown appears where you want it. Users can
   also go straight to the form at `/user/role-switch`.
3. A logged-in user with more than one eligible role picks a role to act as, or
   chooses "All my original roles" to revert. The choice lives only in the PHP
   session, so it is per-session and per-device and never touches the stored roles.

## Access posture — this is not impersonation

Role Switcher is safe by design and is **not** a way to gain access a user does not
already have. The selection is validated **server-side**: the manager only allows a
user to switch into a role drawn from their *own* roles, minus `authenticated` and
`administrator`, so a user can never switch into a role they do not hold — there is
no privilege escalation. The `administrator` role is never offered as a target and is
always implicitly retained, so an administrator cannot lock themselves out, and if a
role is revoked from the user while it is active, the override clears itself. The
switch narrows a user's *effective* permissions to a subset of what they already have
— it never grants anything new, and it never edits the `users_roles` table.
