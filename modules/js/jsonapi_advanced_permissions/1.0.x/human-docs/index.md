# JSON:API Advanced Permissions — manual setup guide

**JSON:API Advanced Permissions** (`jsonapi_advanced_permissions`) adds a layer of
fine-grained access control on top of Drupal's core JSON:API. Out of the box,
JSON:API relies on Drupal's underlying entity access to decide who can read or
write a resource. This module lets you go further and require an explicit
*permission* per resource collection and per HTTP method — so you can, for
example, allow anyone to read a collection but require a specific permission to
POST, PATCH, or DELETE it, or restrict certain collections to particular roles.

It works by generating permissions for each collection and method (GET, POST,
PATCH, DELETE) and gating the matching JSON:API routes behind them with a route
subscriber. The control is **fail-closed**: if a caller doesn't hold the required
permission, the route is denied. That makes it a genuine security control for
locking down a headless site's API surface.

Two things are worth being precise about:

- **It governs the JSON:API routes/collections — it does not replace entity or
  field access.** Think of it as an extra gate in front of the API, layered on top
  of Drupal's normal permissions. Keep both correct; broadening what your API
  exposes is a security decision either way.
- **Turning on a permission changes who can reach the affected endpoints.** As
  soon as you enable a given permission type, every JSON:API endpoint of that type
  starts requiring the newly generated permission — and until you grant it to
  roles, only the administrator role will be able to reach those endpoints. That
  is by design (fail-closed), but it means you should plan the permission grants
  as part of enabling it.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — choose which permission types to
   enable, then grant the generated permissions to roles.

## Where it lives in the admin menu

The module's own settings sit at **Administration → Web services → JSON:API
Advanced Permissions** (route `jsonapi_advanced_permissions.settings`). The
permissions it generates appear in the normal permissions UI at **People →
Permissions** (`/admin/people/permissions`), under a "JSON:API Advanced
Permissions" section.
