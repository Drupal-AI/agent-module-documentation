# Entity Meta Relation — manual setup guide

**Entity Meta Relation** (`entity_meta_relation`) is a framework for attaching
**structured metadata** to your content entities by storing that metadata in
separate, independent "meta" entities rather than as ordinary fields on the content
itself. The idea is to keep behaviour-controlling metadata — SEO settings, media
variants, workflow flags, and the like — *out* of the main content entity so its
own storage stays focused on its actual content, while the extra information lives
in related meta entities that can be versioned and reused.

Rather than a click-and-configure feature, it's a building block that other code
builds on. Metadata is attached through **behaviors**, which developers define to
say what meta attaches to an entity and how it's presented and stored. The module
provides the meta relation entity, the behavior system, and administration for meta
relation types and meta types. It ships two submodules to get you started: **EMR
Node** (`emr_node`), which wires the system up for nodes, and **Entity Meta
Example** (`entity_meta_example`), which provides example behaviors you can learn
from.

Entity Meta Relation depends on **Entity Reference Revisions** and runs on Drupal
10 and 11. It provides its own permissions — `administer entity meta relation
types`, `administer entity meta types`, and related overview permissions — so you
can control who manages meta types.

> **A note on naming:** this project has a newer rewrite distributed separately as
> **`emr`**. This guide covers the original **`entity_meta_relation`** line
> (`8.x-1.x`) under its own name — install it as shown below.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its Entity
   Reference Revisions dependency, enable it, and pick up the submodules.

Configuration of *what* metadata attaches is done in code (behaviors) and through
the meta-type administration the module adds; there is no single global settings
form, so setup is described in "How to use it" below.

## Where it lives in the admin menu

Entity Meta Relation adds administration for **meta relation types** and **meta
types**, reachable by users with its administer permissions. What actually attaches
to your entities is determined by the behaviors that are defined (by the submodules
or by your own code).

## How to use it

1. Enable the base module, then enable **EMR Node** (`emr_node`) so the system
   integrates with nodes — this is the usual starting point.
2. Explore **Entity Meta Example** (`entity_meta_example`) to see how behaviors are
   defined and attached.
3. For a real project, a developer defines the behaviors your site needs (what meta
   entity attaches, its fields, and how it renders) following the example
   submodule's pattern.
4. Use the meta-type administration pages to manage the meta relation types, and
   grant the relevant administer permissions only to trusted roles.
