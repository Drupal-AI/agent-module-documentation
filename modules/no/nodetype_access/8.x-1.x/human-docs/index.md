# Nodetype Access — manual setup guide

**Nodetype Access** (`nodetype_access`) gives you a "view *[type]* nodes"
permission for each content type on your site, so you can decide — role by role —
which content types a user is allowed to *see*. When someone lacks the view
permission for a type, nodes of that type are hidden from them.

The problem it solves is a common one: you have, say, an "Internal memo" or
"Members article" content type that only certain roles should be able to read,
but core's node permissions only cover *creating*, *editing* and *deleting* — not
plain viewing by type. Nodetype Access fills that gap. It does so in a
deliberately lightweight way: it implements `hook_node_access()` and returns a
*forbid* result for a node whose content type the current user isn't permitted to
view, without touching Drupal's heavier node-grants system.

One important limitation to understand before you rely on it. The check happens at
the **entity-access** level, which governs the full node view and is respected by
access-aware listings and Views (as long as access checking is left on). It is
**not** the node-grants (query-level) system, so any context that deliberately
bypasses entity access — a custom database query, a View with access checking
switched off, some search setups — could still surface a restricted-type node.
After you set the permissions up, test both the "can see" and "can't see" cases,
and verify your listings and search respect entity access.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — grant the per‑content‑type view
   permissions on the People → Permissions page.

## Where it lives in the admin menu

Nodetype Access adds no settings form of its own. Everything you configure lives
on the standard **People → Permissions** page
(`/admin/people/permissions`), where the module contributes one "view *[type]*
nodes" permission per content type. See [Configuration](configuration/index.md).
