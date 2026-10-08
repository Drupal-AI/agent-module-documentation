# Prevent entity unpublish — manual setup guide

**Prevent entity unpublish** (machine name `prevent_entity_unpublish`, project
`prevent_entity_unpublished`) stops content editors from **unpublishing** a node,
taxonomy term, or user account while another entity still references it. It
extends the familiar "you can't delete something that's still in use" idea from
*deletes* to *publish state*: if hiding a piece of content would leave a dangling
reference elsewhere, the save is blocked and the editor is told exactly what still
points at it.

It builds on the **Entity Reference Integrity** family of modules, which track
which entities reference which. When an editor sets an entity's status to
*unpublished*, this module asks Entity Reference Integrity whether anything still
depends on it. If something does — and the entity's type is one you've chosen to
protect — a validation error lists the referencing entities and the save is
rejected.

An administrator chooses **which entity types** the protection applies to on a
short settings form. Only **node**, **taxonomy term**, and **user** are offered.
Typical uses: keeping landing‑page building blocks from being hidden by accident,
keeping referenced media or author accounts visible while they're in use, and
giving editors a clear message instead of a silently broken reference.

> **Important scope note.** The guard lives in the entity **edit form's**
> validation. It blocks the UI save path — it does **not** hook the low‑level
> storage layer. An unpublish performed in code
> (`$entity->setUnpublished()->save()`), via a migration, or through REST is
> **not** intercepted. Treat this as an editorial safeguard, not an authorization
> boundary.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its Entity
   Reference Integrity dependencies, and enable it.
2. [Configuration](configuration/index.md) — choose which entity types are
   protected.

## Where it lives in the admin menu

The settings form sits at **Configuration → Content authoring → Prevent entity
unpublish** (`/admin/config/content/prevent-entity-unpublish`) and is gated by the
**Administer prevent entity unpublish** permission.
