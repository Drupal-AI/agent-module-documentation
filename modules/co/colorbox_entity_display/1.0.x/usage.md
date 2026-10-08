<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Colorbox Entity Display

Displays a full content entity inside a Colorbox lightbox by loading its rendered markup (plus required CSS/JS) over an AJAX JSON endpoint.

- Opens nodes, media, paragraphs library items and other entities in a modal without a page load.
- Returns rendered markup and the asset paths needed to style it correctly in the lightbox.
- Reuses the entity's `colorbox` view mode when one exists, otherwise `full`.
- Enforces entity `view` access before returning any markup.

---

## Installation & configuration

- Depends on the `colorbox` module (and its Colorbox JS library); enable with `drush en colorbox_entity_display`.
- No dedicated settings form; you wire up links/triggers that point at the load endpoint.
- Optionally add a `colorbox` view mode to entity types you want to display in the lightbox.
- Links target `/colorbox-entity-display/entity-load/{entity_path}` where `entity_path` is an alias or system path.
- The route requires the `access content` permission.

---

## Usage & API

- `EntityLoadController::entityLoad()` resolves the request path to an entity and renders it.
- An inbound `EntityLoadPathProcessor` encodes `/` as `:` so a full path fits one route parameter.
- The controller decodes the path, resolves the alias, and matches it via `router.no_access_checks`.
- After resolving the entity it calls `$entity->access('view')` and throws Access Denied if not permitted.
- The chosen view mode is `colorbox` if defined for the entity type, else `full`.
- A special workaround applies for `paragraphs_library_item` view-mode handling.
- Attached libraries are walked to collect file CSS/JS paths, skipping `core/drupal`.
- The JSON response contains `css`, `js` and rendered `markup` keys.
- The Colorbox front-end consumes this JSON to populate and open the lightbox.
- Missing/unmatched paths return 404; disallowed entities return 403.
- Works with any entity type that has a render view builder.
- Because access is re-checked per entity, unpublished/private entities are protected.
- External (CDN) library assets are not emitted in this version (only file assets).
- Useful for image galleries, related-content previews and quick entity peeks.
- Cache-busting uses the site's `system.css_js_query_string` state value.
- The route uses the no-access-checks router only to resolve the entity, not to grant access.
