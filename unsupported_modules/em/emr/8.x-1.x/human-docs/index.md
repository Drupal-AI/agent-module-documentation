# Entity Meta Relation — manual setup guide

**Entity Meta Relation** (`emr`) lets you attach reusable *metadata entities* to
your content and keeps those relationships correct across revisions. It comes
from the Drupal project `entity_meta_relation`, so when you install it with
Composer you ask for `drupal/entity_meta_relation`, but the module you enable is
called `emr`.

The idea is simple once you see the problem it solves. Some information about a
node is not really *part* of the node — SEO metadata, a visual variant, a set of
feature toggles, an audio or reading-speed profile. If you model that as fields
directly on each content type, you mix concerns and end up recreating the same
fields on every type that needs them. EMR instead stores that information in
separate `entity_meta` entities that are *related* to the host content. That
gives you three things plain fields cannot: the metadata is **reusable** across
content types without duplicating the field set, it is **revisioned in step**
with the host (an old revision shows the metadata it had at the time, not
today's), and it is **separable**, so a module can add its own meta type without
touching your content model.

This is a developer-oriented, structural module rather than a point-and-click
feature. It has **no configuration screen of its own** — you use it by enabling
the integration submodule for the entity type you care about (`emr_node` for
nodes) and one or more *meta type* submodules, then working with the meta
entities through code or through the fields the submodules expose. The base
module ships several meta types as examples: `entity_meta_audio`,
`entity_meta_speed`, `entity_meta_visual`, `entity_meta_force`, and
`entity_meta_example` — read `entity_meta_example` when you want to write your
own meta type. EMR grew out of the OpenEuropa ecosystem, where content is heavily
revisioned and metadata-driven, so that is the shape of site it suits best.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the project with Composer and
   enable the base module plus the submodules you need.

There is **no configuration page** for this module. Setup happens by enabling the
right submodules and then working with the meta entities they provide.

## How to use it

1. Enable the base **`emr`** module (see [Installation](installation/index.md)).
2. Enable the integration submodule for the entity type you want to attach
   metadata to — **`emr_node`** for nodes.
3. Enable one or more *meta type* submodules. The bundled ones
   (`entity_meta_audio`, `entity_meta_speed`, `entity_meta_visual`,
   `entity_meta_force`) are practical examples; `entity_meta_example` is the one
   to study before writing your own.
4. Work with the related meta entities in code — or through the fields the
   submodules add. Because the relationship is revision-aware, viewing an old
   revision of a node shows the metadata that revision had, which is exactly what
   an editorial audit needs.
