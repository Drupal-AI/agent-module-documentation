# Entitree — manual setup guide

**Entitree** (`entitree`) gives content entities a **hierarchical (tree)
structure**. Rather than a flat list, you organize entities — nodes, taxonomy
terms, and so on — into parent/child trees. Along with the structure itself,
Entitree provides tools to enable tree support per entity type and an API for
reading the tree. Once an entity type is made available, all entities of that
type can be added to the tree. The base module provides its own permissions.

Entitree is built around submodules, so what you enable determines what you get.
The base module is the framework; **`entitree_node`** adds support for the Node
(content) entity type and **`entitree_taxonomy_term`** adds support for taxonomy
terms — you must enable the relevant one for that entity type to be usable in the
tree. Two further submodules extend the system: **`entitree_location_rules`**
generates entity paths automatically from their position in the tree (think of it
as Pathauto for the Entitree ecosystem), and **`entitree_permissions`** lets you
define cascading, priority-ordered permissions scoped to sub-trees and user/role
context.

> **Two things to keep in mind.** First, if you use `entitree_permissions` to gate
> access by tree position, make sure that access is actually enforced where it
> matters — a hierarchy is a *structure*, not automatically an access boundary.
> Second, multilingual support is only partially implemented at this stage, so
> avoid Entitree on multilingual projects for now.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   base module plus the submodules you need.

Configuration happens by enabling the right submodules and then making entity
types available and adding entities to the tree; there is no single settings form
to walk through here.

## How to use it

1. Enable the base **`entitree`** module and the submodule for each entity type
   you want in the tree (`entitree_node`, `entitree_taxonomy_term`).
2. Optionally enable **`entitree_location_rules`** to have entity paths generated
   automatically from their tree position, and **`entitree_permissions`** to
   define tree-scoped permissions.
3. Make the entity type available to Entitree, then add entities of that type to
   the tree to build your parent/child structure.
4. Review the module's permissions under **People → Permissions** to control who
   can configure and manage the tree.
