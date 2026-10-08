# Custom UUID — manual setup guide

**Custom UUID** (`custom_uuid`) adds an optional *Custom UUID* field to the
*add* forms for custom blocks (`block_content`) and media, so an editor can pin
a specific, known UUID on a new entity instead of letting Drupal generate a
random one. If you leave the field blank, the entity keeps its normal
auto‑generated UUID — nothing changes.

Why would you want to choose the UUID yourself? Because Drupal configuration
often references content entities *by UUID* — think of a block placed through
Layout Builder, or any config that points at a specific media item. When you
move that configuration between environments (say, from a development site to
production), the reference only resolves if an entity with the *same* UUID
exists on the other side. Being able to create a block or media item with a
deliberate, matching UUID keeps those config‑to‑content references stable across
sites.

The module works the moment you enable it — there is no settings form to fill
in. It simply alters the block and media add forms, validates whatever UUID you
type (it must be a correctly formatted UUID and must not already exist), and
writes it to the new entity. It depends on core's **Media** and **Block content**
modules, because those are the forms it extends. Only users who can already
create blocks or media see the field, so it adds no new permissions of its own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module — it has no settings form.
Everything happens on the block and media add forms, described in "How to use
it" below.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Create a new custom block (**Content → Blocks → Add content block**) or a new
   media item (**Content → Media → Add media**).
3. Near the top of the form you'll see a new **Custom UUID** field. Either:
   - Leave it **blank** to let Drupal assign its usual random UUID, or
   - Paste a **specific, correctly formatted UUID** (for example, one that a
     configuration item on another environment already expects).
4. Save. If the UUID is malformed you'll see *"invalid UUID"*, and if it is
   already in use you'll see *"Provided UUID is already present"* — pick another
   value and save again.

The field appears on **all** block and media bundles, and only on the *add*
forms (not when editing an existing entity, whose UUID is already fixed).
