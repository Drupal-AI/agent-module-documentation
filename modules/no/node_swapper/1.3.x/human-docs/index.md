# Node Swapper — manual setup guide

**Node Swapper** (`node_swapper`) gives administrators a tool for **swapping an old
node for a new one while keeping all the existing URLs intact**. When you swap, the
old node's URL alias moves to the new node and redirects are created from the old
paths (alias and any existing redirects) to the new one — so visitors who follow an
old link, and search engines that indexed the old URL, land on the replacement
content instead of a broken page.

It solves the classic content‑replacement problem: you have a fresh version of a page
and want to retire the old one without losing its SEO value or breaking inbound links.
Because moving aliases and creating redirects is a privileged editorial operation, the
swap is gated behind the module's own permissions — restrict them to trusted editors.
The module depends on the **Redirect** and **Pathauto** modules, which do the heavy
lifting on aliases and redirects.

The swap runs from a simple admin‑facing tool that lets you review the changes before
they happen. A settings page lets an administrator adjust some defaults (such as a
default URL suffix and whether the old node is unpublished after the swap); editors can
still override those defaults on a case‑by‑case basis when they run a swap.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its Redirect and
   Pathauto dependencies, and enable it.

## Where it lives in the admin menu

Once enabled, the swap tool lives at **Administration → Configuration → System →
Node Swapper** (`/admin/config/system/node-swapper`). Its default behavior is
adjusted at **Configuration → System → Node Swapper Settings**.

## How to use it

1. Grant the module's permissions to the right roles (see below).
2. A user with the **Access Node Swapper** permission goes to **Configuration →
   System → Node Swapper** and chooses the old node and the new node.
3. Review the summary of what will change — which alias moves, which redirects are
   created, and whether the old node is unpublished.
4. Confirm the swap. From then on, visiting the old URL, an old alias, or an old
   redirect takes users to the new node.

### Permissions

- **Access Node Swapper** — lets a user run the swap tool. Give this to trusted
  editors only, since a swap moves aliases and creates redirects.
- **Administer Node Swapper** — lets a user open **Node Swapper Settings** and change
  the module's defaults (default URL suffix, whether to unpublish the old node).

Assign both at **People → Permissions** (`/admin/people/permissions`).
