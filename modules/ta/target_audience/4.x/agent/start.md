<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Target Audience (target_audience) — agent index

Restrict **view/edit of any entity** by a reusable **target-audience field** (role / individual user
by email / Group membership; view and edit granted independently). Version **4.0.0**.

**Well-built access control (positive, verified):** NODES use **node grants** (query-level — restricted
nodes vanish from canonical, listings, Views, search); NON-NODES use `hook_entity_access` at runtime,
with the README **honestly** noting Drupal has no query-level grants for non-nodes so **custom listing
queries must call entity access themselves**. The restriction field is **admin-only** and its default
formatter renders nothing (no leak via forms/REST/JSON:API). **Default is public** (opt-in
restriction — the correct default). One of the better-designed access modules seen; for non-node
entities, enforce access in custom listing queries.