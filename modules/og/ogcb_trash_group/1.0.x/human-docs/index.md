# OGCB Trash Group — manual setup guide

**OGCB Trash Group** (`ogcb_trash_group`) makes the
[Trash](https://www.drupal.org/project/trash) module and the
[Group](https://www.drupal.org/project/group) module work together, so that trashing
or restoring a group cascades to everything related to it. Trash a group, and all its
relationships and their related entities follow it into the recycle bin; restore the
group, and everything comes back together. The cascade also works the other way —
trashing an entity trashes its group relationships, and vice versa, with restore
working in both directions.

It was built as part of the **Open Government Community Builder (OGCB)** project and
is tailored to its needs, but it can be used independently on any site running Trash
and Group. One scope limitation is worth knowing up front: it is designed for
**1‑to‑1 group relationships** (one entity belongs to exactly one group). The code
iterates over multiple relationships if they exist, but the bidirectional cascade
logic is not designed or tested for true 1‑to‑N scenarios.

Beyond the cascade, it also improves the delete confirmation screen: on group
relationship delete forms it replaces the default *"This action cannot be undone"*
warning with the trash‑aware wording used by the Trash module, so editors understand
the item is being moved to the recycle bin rather than destroyed. A shared
re‑entrancy guard prevents infinite loops between entities and relationships.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside Trash and Group.

The cascade behavior activates automatically once the module is enabled; the only
setup is enabling Trash for the right bundles, described in "How to use it" below.

## How to use it

1. Enable `ogcb_trash_group` (see [Installation](installation/index.md)). The cascade
   hooks activate automatically — there is no settings form for this module.
2. For the cascade to have something to act on, **enable Trash for the relevant
   entity type bundles and their corresponding group relationship bundles** at
   **Administration → Configuration → Content → Trash**
   (`/admin/config/content/trash`).
3. From then on, trashing or restoring a group (or a related entity) cascades to its
   related items automatically, and group relationship delete forms show the
   trash‑aware confirmation wording.

> **Scope reminder:** this is built and tested for 1‑to‑1 group relationships. If
> your model attaches one entity to several groups at once, test carefully — the
> bidirectional cascade is not designed for that case.
