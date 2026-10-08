# Storage Entities — manual setup guide

**Storage Entities** (`storage`) gives you a lightweight, bundleable content
entity type — called `storage` — for data you want to store, field, and revise
but *not* publish at its own front-end URL. Think of it as the clean alternative
to spinning up a content type just to hide it from visitors: instead of building
an Article type and then bolting on Rabbit Hole to stop people reaching it, you
create a purpose-built entity that has no public page in the first place.

Like content types, storage entities come in **storage types** (bundles you
create in the admin UI). Each storage type has its own fields (added through the
normal Field UI), a label, help text, a default publish status, revision
defaults, and an optional **name pattern** that auto-generates each item's name
from tokens. Storage entities are fieldable, revisionable, and translatable, and
you manage all of them from a single overview at `/admin/content/storage`. By
default visiting a storage item's URL just redirects to its edit form — there is
no public canonical page — unless you deliberately turn that on per storage type.

This makes Storage a natural home for structured back-end data: imported rows,
stored API payloads, settings records, or reusable content fragments that other
entities reference but that should never be browsable on their own. Permissions
are granular per bundle, so you can grant a role exactly the create/edit/view/
delete rights it needs on one storage type without touching the others. The
optional **rh_storage** submodule adds Rabbit Hole behavior for storage entities
if you do want to control what happens at their URLs.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and note the optional `rh_storage` submodule.
2. [Configuration](configuration/index.md) — create and tune storage types
   (bundles), add fields, and use name patterns.

## Where it lives in the admin menu

There is **no single settings page** for Storage — configuration lives in each
storage type. The two places you work are:

- **Structure → Storage types** (`/admin/structure/storage_types`) — create and
  configure storage types (bundles) and add fields to them.
- **Content → Storage** (`/admin/content/storage`) — the overview of all storage
  entities, where you create, edit, publish/unpublish, and delete them. Add a
  new item at `/storage/add`.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Create a **storage type** at *Structure → Storage types* — give it a label
   and, if you like, a name pattern and revision/publish defaults. See
   [Configuration](configuration/index.md).
3. Add fields to the storage type with the normal Field UI, exactly as you would
   for a content type.
4. Create storage items at `/storage/add`, and manage them all from
   *Content → Storage*.
5. Reference storage items from other entities with an entity-reference field, or
   build custom Views over the `storage` data — the module ships Views
   integration and bulk publish/unpublish/delete actions.
