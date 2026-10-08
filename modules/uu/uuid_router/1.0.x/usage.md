<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
UUID Router lets you address any entity by its UUID instead of its numeric ID, transparently rewriting the request to the entity's real internal path.
---
It registers a single inbound path processor (`EntityUuidPathProcessor`, priority 50). On each request the processor regex-matches paths of the form `/{entity_type_id}/{uuid}` (→ `canonical`) or `/{entity_type_id}/{uuid}/edit` (→ `edit-form`). If the entity type exists and has the matching link template, it loads the entity by UUID with `loadByProperties(['uuid' => …])` and returns the entity's internal system path (e.g. `/node/5`). Non-matching paths, unknown entity types, or missing entities fall through unchanged.

Because the processor only rewrites the path string and then hands control back to normal routing, all downstream access checks still apply — the resolved route runs its usual `_entity_access` / permission checks, so this does not bypass entity access. It is a routing convenience (useful for decoupled front-ends and stable cross-environment links) with no routes, permissions, config, or admin UI of its own.
---
- Open a node by UUID: `/node/<uuid>`.
- Open a node's edit form by UUID: `/node/<uuid>/edit`.
- Address any entity type with a canonical link template by UUID.
- Address any entity type with an edit-form link template by UUID.
- Give a decoupled front-end stable UUID-based URLs to entities.
- Build cross-environment links that survive differing numeric IDs.
- Reference a taxonomy term by UUID instead of tid.
- Reference a user by UUID instead of uid.
- Enable the module and clear caches — no configuration needed.
- Rely on normal entity access still applying to the resolved path.
- Confirm unknown entity types fall through unchanged.
- Confirm malformed UUIDs are ignored by the regex.
- Integrate UUID links into REST/JSON responses for the front-end.
- Avoid exposing sequential numeric IDs in public URLs.
- Redirect legacy UUID links to canonical paths automatically.
- Test the processor via `EntityUuidPathProcessorTest`.
- Chain with other inbound path processors (priority 50).
- Resolve media/entity UUIDs shared between staging and production.