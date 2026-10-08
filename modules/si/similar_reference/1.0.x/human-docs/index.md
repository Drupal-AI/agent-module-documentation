# Similar Reference — manual setup guide

**Similar Reference** (`similar_reference`) helps you build "related content"
listings — think *related articles* or *you might also like* — by counting how
many **entity-reference** fields two entities have in common and turning that into
a similarity score inside a View. It is a fork of the older *Similar By Terms*
module, but instead of being tied to taxonomy it works on any entity-reference
field, so two nodes that reference the same author, product, or any referenced
entity can be scored as similar.

You use it through Views: the module adds a contextual filter (argument) and
relationship you place on a View so that, given the current entity, the View lists
other entities ranked by how many shared references they have. It depends only on
core's **Views** module and has no submodules or central settings form — all the
setup happens in the Views UI. Results respect the View's and the entities' own
access controls, and the module plays no access-control role of its own.

A few limitations to know before you build: you cannot use more than one Similar
Reference contextual filter on the same View, it only compares entities of the
**same entity type**, it only compares entities of different bundles when they
share the same reference field, and it is not designed for Dynamic Entity
Reference or Entity Reference Revision fields. Note also that this project is
**not covered by Drupal's security advisory policy**.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

After enabling, go to the **Views** UI (*Structure → Views*) and either build a
new View or edit an existing one that lists the entity type you care about. Add
the Similar Reference **contextual filter** (and its relationship) so the View
scores other entities by their shared references, sort by that score, and place
the View as a block or attach it to your content. Because everything lives in the
View, its filtering and access follow the normal Views rules.
