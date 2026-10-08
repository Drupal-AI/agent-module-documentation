# Entity Type Permissions — manual setup guide

**Entity Type Permissions** (`entity_type_permissions`) adds **per‑type,
per‑bundle permissions** for content‑based entities, so you can grant access to a
specific entity type or bundle (for example "Basic page" nodes, a particular media
type, or a comment type) rather than relying only on Drupal's coarser core
permissions. It's a fork of *Entity Bundle Permissions*, reworked to be simpler to
manage: permissions are grouped first by base entity type (Content, Comment, Media)
and then by the individual bundle, and you decide which entity types generate
permissions at all — keeping the permissions page clean.

Understanding how it grants access is important. The module implements
`hook_entity_access()` using `AccessResult::allowedIf($account->hasPermission(...))`.
That means it is an **additive grant**: it *grants* access to accounts that hold the
matching permission and stays neutral otherwise — it does **not** take away access
that another check (such as a core permission) already allows. This is the correct,
safe way to use `hook_entity_access`, but it has a practical consequence: to
actually *restrict* an entity type, you must make sure core (or another module)
isn't already granting that access. Use this module to **open up** access in a
granular way, not as the sole lock on content that core would otherwise permit.

Its permission model is also a little different from the module it forked from. For
example, to view content a user needs the core "View published content" permission
*and*, to use operations on a specific bundle, the module's per‑bundle permission
such as "Access content items 'Basic page'". It depends only on core's **User**
module and works on both PHP 7.4 and PHP 8.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — choose which entity types generate
   permissions, then assign those permissions to roles.

## Where it lives in the admin menu

The module has a **settings form** (route `entity_type_permissions.settings_form`)
where you configure which entity types have permission scopes generated — and where
you can clear away permissions you don't need. You then assign the generated
permissions to roles on the usual **People → Permissions** page
(`/admin/people/permissions`).
