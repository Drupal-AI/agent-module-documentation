# Path Alias View Access — manual setup guide

**Path Alias View Access** (`path_alias_view_access`) adds a single permission —
**View path alias entities** (`access path_aliases`) — that lets non‑admin users
*read* path‑alias entities without being handed the powerful
`administer url aliases` permission (which would also let them edit and delete
every alias on the site). It's aimed squarely at one common situation: you want to
expose your URL aliases through **JSON:API** (or REST, or Views) to a decoupled
front end, a search indexer, or a sync job, but you don't want to give that
integration keys to the whole aliasing system.

It's worth being precise about exactly what the permission grants, because the
module is deliberately least‑privilege:

- It applies **only to the `view` operation** — never create, update, or delete.
  Holding the permission gives a role no ability to change any alias.
- It grants access **only to published aliases**. Unpublished aliases stay hidden
  from permission holders.
- It changes nothing about ordinary page routing. The permission is *not* required
  to visit a page that happens to have an alias — it only governs reading the
  **alias entity itself** (for example as a JSON:API resource).

Under the hood the module hooks core's entity access API and returns "allowed"
only when the account has the permission **and** the alias is published; for every
other operation it stays neutral, so it can never widen access on its own. It also
lets permission holders filter JSON:API alias collections among published (or
their own) items. Access decisions are cached per permission and per entity.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and grant the permission.

There is **no configuration page** for this module — its entire behaviour is
controlled by the one permission, granted on the standard **People → Permissions**
screen.

## Where it lives in the admin menu

The module adds no admin page of its own. You manage it entirely from **People →
Permissions** (`/admin/people/permissions`), where the **View path alias
entities** permission appears under the module's name.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Go to **People → Permissions** and grant **View path alias entities**
   (`access path_aliases`) to the role that needs read access — for example an
   authenticated API role or a service account, **not** anonymous unless you
   truly intend aliases to be world‑readable over your API.
3. Keep `administer url aliases` reserved for genuine administrators. This module
   exists precisely so you don't have to hand that out just to allow reads.
4. If you are exposing aliases via JSON:API, confirm the `path_alias` resource is
   enabled in your JSON:API/REST configuration, then verify that a user with the
   new permission can read published aliases and that unpublished ones stay
   hidden.
