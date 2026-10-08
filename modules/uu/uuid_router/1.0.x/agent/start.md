<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# UUID Router (uuid_router) — agent index

**Resolves `/{entity_type}/{uuid}` and `/{entity_type}/{uuid}/edit` URLs to the entity's real internal path via an inbound path processor.**

- **Version:** 1.0.x (dev checkout, branch `1.0.x`; no version in info.yml)
- **Core:** ^10.1 || ^11
- **Service:** `uuid_router.path_processor_entity_uuid` → `EntityUuidPathProcessor` (tag `path_processor_inbound`, priority 50)
- **No** routes, permissions, config, hooks or admin UI.

**Security:** Sound. The processor only rewrites the request path to the entity's internal system path; the resolved route still runs the normal entity-access/permission checks, so it does not bypass `view`/`update` access. It loads entities by UUID to resolve the path but never renders or returns them itself.
