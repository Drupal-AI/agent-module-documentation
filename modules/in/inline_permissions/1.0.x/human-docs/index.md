# Inline Permissions — manual setup guide

**Inline Permissions** (`inline_permissions`) lets administrators grant
permissions to an **individual user** directly on that user's edit form, instead
of only through roles. Normally in Drupal, permissions attach to roles and users
inherit whatever their roles grant. This module adds a way to assign specific
permissions to one account on its own — handy when a single person needs one extra
capability that doesn't justify creating (or widening) a whole role.

It builds this on Drupal's **Access Policy API**, the core framework for
contributing permissions to a user's access at runtime. So when you tick a
permission for a user here, it is layered on top of whatever their roles already
provide.

This is a genuinely powerful capability, and it deserves care. Per‑user permission
grants sit outside the tidy role model, which makes them easy to lose track of and
capable of escalating someone's privileges in ways an audit of roles alone won't
reveal. For that reason the whole feature is gated behind the core **Administer
permissions** permission — the same one that guards the permissions page itself —
and you should restrict that permission tightly.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — how the per‑user access model works,
   who can use it, and how to grant permissions to an individual account safely.

## Where it lives in the admin menu

Inline Permissions does not add a settings page of its own. Instead it adds a
permissions control to each **user edit form** at **People → *(a user)* → Edit**
(`/user/{uid}/edit`). Only users who hold the **Administer permissions**
permission see and can use that control. The role‑based permissions grid remains
where it always is, at **People → Permissions** (`/admin/people/permissions`).
