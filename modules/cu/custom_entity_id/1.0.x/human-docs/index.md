# Custom Entity Id — manual setup guide

**Custom Entity Id** (`custom_entity_id`) adds a field to the entity‑create form that
lets a permitted user assign a **specific ID** to a new entity, rather than taking the
next value from the auto‑increment sequence. If an entity with the chosen ID already
exists, the module refuses it with an "Entity id already exists" message.

It exists for a handful of legitimate needs: preserving predictable IDs when moving
data between environments, matching IDs to an external system, or writing business
logic (or theming templates) keyed to a known entity ID. You enable custom IDs per
entity type from the module's settings form; once enabled for a type, the custom‑ID
field appears on that type's create form.

Assigning primary keys by hand is a **sensitive, admin‑level capability**, so the
module provides its own permission and marks it *restricted*. Choosing IDs carelessly
can collide with existing records, leave gaps, or jump the sequence so that future
auto‑assigned IDs behave unexpectedly — and predictable IDs can make enumeration
easier. Grant the permission only to trusted users, use it deliberately, and prefer
the Migrate system for anything repeatable. It has no dependencies and works on
Drupal 9.2 through 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — choose which entity types allow custom
   IDs, and set the permission.

## Where it lives in the admin menu

Once enabled, the settings form lives at the module's configuration route
(`custom_entity_id.settings`). **You must configure it first** — until you enable
custom IDs for at least one entity type there, the custom‑ID field won't appear on any
create form.
