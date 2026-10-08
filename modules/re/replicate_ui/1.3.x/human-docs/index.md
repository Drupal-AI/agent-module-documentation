# Replicate UI — manual setup guide

**Replicate UI** (`replicate_ui`) puts a friendly user interface on top of the
**Replicate** module's deep-clone engine. Replicate can duplicate a content entity
along with all its fields and child entities, but it ships no interface of its
own. Replicate UI adds one: once you enable it for the entity types you choose,
editors get a **Replicate** tab, an entity-operation link on admin listings, and a
confirmation form for cloning any entity directly from the site.

You decide which content entity types are replicable on a small settings form. For
each type you enable, the module wires up a `/{type}/{id}/replicate` route, a
"Replicate" local task, and an operation link. Clicking Replicate opens a confirm
form where the editor sets the new item's label (defaulting to "*(original)*
(Copy)", with a field per language for translated content), then the clone is
created, saved, and the editor lands on the new copy ready to edit.

Beyond the manual UI, the module exposes the same clone operation as a core
**Action** (`entity_replicate`, usable in Views Bulk Operations), a **Rules**
action, and a **Views field** for adding a Replicate link column to a listing.
Access is controlled by a dedicated permission plus core create/view access, with
an optional toggle to also require edit access on the original. It depends on the
**Replicate** module and core's **User** module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (and Replicate)
   and enable the module.
2. [Configuration](configuration/index.md) — choose which entity types are
   replicable, the edit-access toggle, and the permission editors need.

## Where it lives in the admin menu

The settings form sits at **Configuration → Content authoring → Replicate**
(`/admin/config/content/replicate`). The Replicate tab and operation link then
appear on the entity types you enable.

## How to use it

1. Enable the module and open the settings form.
2. Tick the content entity types (nodes, taxonomy terms, media, custom blocks, and
   so on) that should be replicable, then save.
3. Grant the **Replicate entities via UI** permission to the roles that should be
   able to clone content — along with the normal create permission for the target
   type.
4. Editors now see a **Replicate** tab on those entities; clicking it opens the
   confirm form and produces a copy.
