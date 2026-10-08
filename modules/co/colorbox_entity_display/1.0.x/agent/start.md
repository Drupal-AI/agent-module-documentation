<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Agent orientation: colorbox_entity_display

**What:** Renders any content entity into a Colorbox lightbox via a JSON endpoint.

**Key files:**
- `src/Controller/EntityLoadController.php` — `entityLoad()`; resolves path→entity, **calls `$entity->access('view')`** (line ~154) before rendering, returns `{css,js,markup}` JSON.
- `src/PathProcessor/EntityLoadPathProcessor.php` — encodes `/`→`:`.

**Route:** `/colorbox-entity-display/entity-load/{entity_path}`, `_permission: access content`.

**Security:** uses `router.no_access_checks` ONLY to resolve the entity, then explicitly enforces entity view access — no bypass. **Deps:** `colorbox`.
