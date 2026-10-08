# Simple Entity Merge — manual setup guide

**Simple Entity Merge** (`simple_entity_merge`) fixes duplicate entities by
repointing every reference from one entity to another and then removing the
duplicate. It is the tool you reach for when a taxonomy has quietly accumulated
"Health", "health", and "Heath" as three separate terms, or when the same
organisation was imported twice — the cases where simply deleting the duplicate
would break everything that referenced it.

The module adds a **Merge** tab to entities of the types you enable. On that tab you
choose another entity of the same type, and it moves all the entity‑reference links
pointing at the current entity over to the one you chose, then deletes the original.
Configuration at **Configuration → Content authoring → Simple Entity Merge** decides
which entity types the tool applies to. It has no other module dependencies.

Two things are important to understand before using it. First, **a merge is not
undoable** — it is a bulk, destructive rewrite of references across your site, so
take a backup first and rehearse on a copy for anything large (like a big
vocabulary). That destructive nature is also why both of the module's permissions
are marked security‑sensitive; keep them on trusted roles only. Second, it only
follows **entity‑reference fields**. References held elsewhere — inside text fields
(an inline link or embedded entity), in Layout Builder section configuration, in
serialised settings, or in another module's own tables — are **not** found and will
keep pointing at the deleted entity. Check that the reference types your site
actually uses are covered before you rely on it. The project also notes it does not
process references in batches, so it is not advised for entities with very large
numbers of references.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer, enable
   it, and grant the permissions.
2. [Configuration](configuration/index.md) — choosing which entity types are
   mergeable, and how to run a merge safely.

## Where it lives in the admin menu

Once enabled, the settings form sits at **Configuration → Content authoring → Simple
Entity Merge** (`/admin/config/content/simple_entity_merge`). The merge action
itself appears as a **Merge** tab on individual entities of the enabled types.
