# JSON:API Permission Access — manual setup guide

**JSON:API Permission Access** (`jsonapi_permission_access`) closes a gap in
Drupal core's JSON:API. By default, core JSON:API exposes all of its routes to
any client — anonymous visitors included — and relies entirely on per‑entity
access checks to decide what data comes back. This module adds a new permission,
**Access JSON:API Routes**, and requires it on *every* JSON:API endpoint. After
you enable it, a request from a role that doesn't hold the permission is refused
with a 403 before entity access is even consulted.

Think of it as a coarse on/off gate layered on top of core's normal access
checks. It **tightens** access and never loosens it: the permission only unlocks
the route, and the response is still filtered by the usual entity and field
access rules. So granting the permission doesn't expose anything a role couldn't
already read — it just decides who is allowed to knock on the JSON:API door at
all.

The module ships an optional ready‑made role, **JSON:API User**
(`json_api_user`), whose only permission is this one — a convenient "API client"
role you can assign to a decoupled front‑end, a mobile app's service account, or
an OAuth consumer. There is no settings form and no configuration file to edit;
all the work is done by granting (or withholding) the permission.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside core JSON:API.
2. [Configuration](configuration/index.md) — granting the permission, using the
   shipped `json_api_user` role, and common lock‑down recipes.

## Where it lives in the admin menu

The module adds no page of its own. Everything is done from the core
**People → Permissions** page (`/admin/people/permissions`), where the new
**Access JSON:API Routes** permission appears, and on **People → Roles** if you
want to use the shipped role.

## How to use it

1. Enable the module (see [Installation](installation/index.md)). The gate is now
   active — JSON:API is closed to any role that doesn't hold the new permission.
2. Grant **Access JSON:API Routes** only to the roles that should reach the API
   (see [Configuration](configuration/index.md)).
3. Leave the permission off `anonymous` (and usually `authenticated`) to keep the
   API private.
