# Compare role permissions — manual setup guide

**Compare role permissions** (`compare_role_permissions`) adds an admin report
that shows the permissions of two roles **side by side**, so you can quickly see
which role grants which permission. It's a read‑only administration and security
aid — it never changes any permissions.

The problem it solves: when a role behaves unexpectedly, tracking down exactly
which permission string is responsible (or spotting where one role has more access
than another) is tedious on the standard permissions page. This module lets you
pick two roles, submit, and compare them directly — handy for auditing
over‑privileged roles, finding gaps, and supporting least‑privilege reviews.

It depends only on core's **User** module. Access is gated by a single permission,
**compare role permissions**, which you should grant only to trusted
administrators. There is no configuration to set up beyond enabling the module and
granting that permission.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** — the module just adds a comparison report; see
*How to use it* below.

## Where it lives

The comparison tool is served at **`/admin/people/permissions/compare`**. The
module does **not** add a menu tab or link, so reach it either by that URL
directly or via the **Configure** link next to the module on the Extend page
(`/admin/modules`).

## How to use it

1. Enable the module.
2. Under **People → Permissions**, grant the **compare role permissions**
   permission to the roles that should be able to use the tool (keep this to
   trusted administrators).
3. Go to `/admin/people/permissions/compare`, select **two different roles**, and
   click **Compare**.
4. Review the side‑by‑side comparison — it lists only the permissions that
   **differ** between the two roles (with a Yes/No column per role). If the two
   roles have identical permissions, you'll see a message saying so.
