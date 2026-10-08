<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Entity reference pagination formatter is a display formatter for entity_reference fields that renders the referenced entities a page at a time, with a "Next page" link that can be clicked or auto-loaded over AJAX.

---

The module ships a single field formatter plugin, `entity_reference_pagination_formatter` (label "Rendered entity (Paginated)"), that extends core's "Rendered entity" formatter. Instead of rendering every referenced entity at once, it slices the field's items into fixed-size pages using the `?page=N` query parameter (the parameter name and page size are configurable per view-display) and renders only the current page's referenced entities through the normal rendered-entity pipeline. When more items remain it appends a "Next page" link that carries the incremented index; with the required `ajax_link` module that link can replace or append the next page's markup in place, auto-trigger, be pushed to browser history, or remove itself after use. It targets any `entity_reference` field, is selected on Manage display, adds no routes, permissions, services or config objects of its own, and works on Drupal 10.3+, 11, and 12.

---

- Display an entity_reference field with many referenced entities in fixed-size groups instead of all at once.
- Paginate a long "Ingredients" (taxonomy term) reference field on a recipe node.
- Render only the first N referenced nodes and let visitors load the rest on demand.
- Reduce initial page weight and render time for reference fields with dozens or hundreds of targets.
- Provide a click-to-load "Next page" link under a referenced-entity list.
- Auto-load subsequent pages of referenced entities as the link scrolls into view (via `ajax_link`).
- Replace the current page's items with the next page's items on click (replace mode).
- Append the next page's items below the current ones for an infinite-scroll feel (append mode).
- Push each pagination step into browser history so back/forward navigate pages.
- Remove the "Next page" link automatically once it has been used.
- Choose the query-parameter name used for the page index so multiple paginated fields on one page do not collide.
- Set the number of referenced entities shown per page per view-display.
- Reuse an existing view mode (Default, Teaser, etc.) for each rendered referenced entity.
- Paginate referenced media entities in a gallery-style display.
- Paginate a "Related articles" reference field on an article node.
- Display a paginated list of referenced products, team members, or events.
- Keep large reference sets usable on mobile by loading a page at a time.
- Apply pagination to any entity type's entity_reference field without writing a custom view.
- Avoid building a separate Views block just to paginate referenced content.
- Combine with the referenced entities' own view-mode display settings for consistent rendering.
- Provide non-JavaScript fallback: the "Next page" link is a plain link that reloads the page with the next index when AJAX is unavailable.
