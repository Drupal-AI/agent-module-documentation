# Expose UUID — manual setup guide

**Expose UUID** (`expose_uuid`) adds a **UUID field to entity edit forms**, so a
user with the right permission can see — and set — an entity's UUID directly in
the UI. This is handy for support and migration work: when you sync configuration
between environments, custom blocks and other config-referenced entities can end
up with mismatched UUIDs, and this module lets you make them match by editing the
UUID through the admin interface.

The behaviour is gated by a single permission, **`edit uuid`**, which the module
adds under the Admin package. Anyone with that permission sees the UUID field on
edit forms.

There is one important consideration to understand before you grant it. The module
does not merely *display* the UUID — it lets the value be **changed**. A UUID is a
stable identifier that references, configuration sync, JSON:API, and third-party
integrations all rely on, so **changing an entity's UUID can silently break those
relationships**. There is also an exposure angle: showing UUIDs makes those
identifiers visible to anyone who can reach the edit form. Grant `edit uuid` only
to trusted administrators, and change UUIDs deliberately, knowing what references
them.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no settings form** for this module. Its only configuration is the
`edit uuid` permission, described in "How to use it" below.

## Where it lives in the admin menu

Expose UUID has no configuration page of its own. You control it entirely from
**People → Permissions** (`/admin/people/permissions`), where you grant the
`edit uuid` permission. Once granted, the UUID field appears on the edit forms of
entities.

## How to use it

1. Go to **People → Permissions** and grant **`edit uuid`** to the roles that
   should be able to see and change UUIDs — keep this to trusted administrators.
2. Open the edit form of an entity (for example a custom block). A **UUID** field
   now appears.
3. To align a UUID across environments, set the field to the target UUID and save.
   Do this deliberately: make sure nothing else still references the old value.

> **Warning:** Changing a UUID can break entity references, configuration sync,
> JSON:API, and other integrations that key off it. Treat a UUID change as a
> potentially destructive operation.
