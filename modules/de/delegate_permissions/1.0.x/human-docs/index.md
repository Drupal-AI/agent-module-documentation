# Delegate Permissions — manual setup guide

**Delegate Permissions** (`delegate_permissions`) lets non‑admin roles manage the
permissions of *lower* roles, without handing them Drupal's sweeping and risky
**Administer permissions** permission. It gives you a safer, scoped way to let,
say, a site‑section manager adjust what their editors can do — while keeping them
firmly inside a boundary you control.

The boundary comes from two rules. First, a **role hierarchy** is derived from
core's role **weights** — a heavier‑weighted role is treated as "higher" (more
permissive). A user with the **allow delegate permissions** permission can only
edit roles weighted *below* their own highest role, never their peers or
superiors. Second, they can only grant permissions they **personally hold** — so
a delegate can never escalate a role to something they themselves cannot do, and
can never reach `administer permissions`. On top of that, a real administrator can
mark specific permissions as **Not Delegable** to keep them out of the delegated
form entirely (`allow delegate permissions` itself is non‑delegable by default).

The delegated form lives at `/admin/people/delegate-permissions` and shows only
the safe subset of roles and permissions described above. There is one nuance
worth knowing: a "bypassed provider" map means a user who holds
`bypass node access` can delegate *all* node‑provider permissions, and a user
with `administer taxonomy` can delegate all taxonomy permissions, even individual
ones they do not each hold — a bounded widening within those two providers. If
you do not want a particular one sub‑delegated, add it to the Not Delegable list.
The module also integrates with **Config Filter** so that a delegate's partial
edit is reconciled on config import/export rather than silently wiping
permissions the delegate could not see.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (and its Config Filter dependency).
2. [Configuration](configuration/index.md) — set role weights, grant the
   delegation permission, and mark any permissions as Not Delegable.

## Where it lives in the admin menu

The delegated permissions form is at **People → Delegate permissions**
(`/admin/people/delegate-permissions`), gated by the **allow delegate
permissions** permission. The **Not Delegable** blocklist is an extra column on
the standard **People → Permissions** page, visible to users who hold
`administer permissions`.
