# Entity Tracer — manual setup guide

**Entity Tracer** (`entity_tracer`) gives you a UI for tracking how entities
reference each other across your site. Point it at an entity and it generates a
**nested diagram** that recursively walks the entity reference fields, showing
which entities are referenced and, in turn, what those entities reference — down to
a depth you control. It's a debugging and inspection tool for making sense of
tangled content structures, and it's handy during migrations too (it works on
Drupal 8 and 9 as well as 10 and 11).

To make the diagram easy to work with, the reference fields are shown in bold and
each referenced entity links straight to that entity's page, so you can jump from
the map to the content and back. The module works once configured: after enabling
it you choose which entity types to trace and set a maximum recursion depth.

Because the tool surfaces relationship detail — which can reveal that referencing
content exists — its access is governed by its own permission. Grant that
permission only to trusted administrators and developers.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — choose the entity types to trace and
   set the maximum depth.

## Where it lives in the admin menu

Its settings form is at **Configuration → Development → Entity Tracer settings**
(`/admin/config/development/entity-tracer-settings`), where you select the entity
types to track and the maximum depth.
