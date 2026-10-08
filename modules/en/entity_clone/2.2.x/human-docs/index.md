# Entity Clone — manual setup guide

**Entity Clone** (`entity_clone`) adds a **Clone** action to entities across
your Drupal site, so an editor can duplicate an existing item instead of
recreating it from scratch. Once the module is enabled, a "Clone" operation
appears on the many entity types it supports — content such as nodes, taxonomy
terms, media and users, as well as configuration entities like menus, fields
and view displays. Cloning makes a copy of the entity as a starting point for a
new one, and it can optionally follow the entity's reference fields to copy the
entities they point to as well (so a landing page built from paragraphs, or a
menu with child links, can be duplicated as a whole).

If you have used **Quick Node Clone**, Entity Clone covers the same idea but is
not limited to nodes: where Quick Node Clone only duplicates node content,
Entity Clone attaches a clone action to *any* content or configuration entity
type you mark as cloneable.

This guide is written for a **human** clicking through the admin UI. It walks
you, step by step and with screenshots, from installing the module to tuning how
each entity type clones and letting editors run the clone action. If you are
looking for terse, token-cheap references for an AI coding agent, read the
sibling [`agent/`](../agent/start.md) docs instead.

![The Entity clone settings page, listing per-entity-type clone options](images/settings.png)

## Where it lives in the admin menu

The module's configuration sits under **Configuration → System → Entity Clone
settings** (`/admin/config/system/entity-clone`). That page is organised into
two tabs:

- **Entity clone settings** (`/admin/config/system/entity-clone`) — how cloning
  behaves for each entity type (shown above).
- **Cloneable entities**
  (`/admin/config/system/entity-clone/cloneable-entities`) — which entity types
  are allowed to be cloned at all.

The **Clone** action itself does not live in the admin menu — it appears
directly on the entities editors work with (for example as an operation in a
content or taxonomy listing), for any user who holds the matching clone
permission.

## Contents

1. [Installation](installation/index.md) — install Entity Clone with Composer,
   enable it, and grant the clone permissions.
2. [Configuration](configuration/index.md) — control how each entity type
   clones on the settings page, then clone entities from the Clone action.
