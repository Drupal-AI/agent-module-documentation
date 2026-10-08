# Entity Copy with Reference — manual setup guide

**Entity Copy with Reference** (`entity_copy_reference`) gives content managers a
configurable, **one‑click way to copy (clone) a node** — and, crucially, lets you
decide what happens to the entities that node references. It grew out of a very
practical need: editors who wanted to duplicate a page without hand‑copying every
field, and without wrestling with complicated configuration.

The interesting part is how it handles reference fields. When you clone a node,
each of its reference fields can be treated in one of three ways: **clear all
references** on the copy, **keep the reference** pointing at the same entity as the
original, or **duplicate the referenced entity as well** so the copy gets its own
independent version. The classic example is Paragraphs inside a node — you almost
always want those duplicated, so editing the new node's paragraphs doesn't
accidentally change the original.

The module works only after you configure it: you first choose which content types
should be copyable, then set the per‑reference behavior for each of those types.
It currently supports **nodes only** (taxonomy support is planned). Cloning creates
real content, so grant the module's copy permission only to roles you trust to
create and manage content. There are no third‑party dependencies.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — choose copyable content types and set
   how each reference field is handled on copy.

## Where it lives in the admin menu

Once enabled, the module's settings form (route `entity_copy_reference.form`) is
where you turn copying on for specific content types and configure how their
references behave. See [Configuration](configuration/index.md) for the full
walkthrough. After that, a copy action becomes available on nodes of the enabled
content types for users who hold the module's permission.
