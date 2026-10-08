<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
HTMX Extras adds HTMX-powered features like entity lazy-loading (with entity-access checks).

---

HTMX Extras adds a set of Drupal-flavored features using the HTMX library — notably lazy-loading of rendered entities and configurable 'HTMX views'. The entity lazy-load endpoint (`/htmx-extras/lazy-load/entity/{type}/{id}/{view_mode}/{revision_id}`) renders an entity via HTMX and checks `$entity->access('view')` before rendering, so it respects entity view access.

Consideration: the lazy-load endpoint accepts an optional `revision_id` and checks only `access('view')` on the loaded revision, not revision-specific view access — for published entities this can render historical revisions to users without a `view revisions` permission (low-impact info exposure; for unpublished revisions, publish-status access still applies). HTMX view administration is gated by `administer htmx_view`. Requires Drupal 11.2+.

---

- Add HTMX-powered features.
- Lazy-load rendered entities.
- Provide configurable HTMX views.
- Render entities via HTMX.
- Check `access('view')` on lazy-load.
- Respect entity view access.
- Accept an optional revision_id.
- Check only default view access on revisions (note).
- Gate HTMX view admin with `administer htmx_view`.
- Require Drupal 11.2+.
- Use the HTMX library.
- Support partial rendering.
- Improve perceived performance.
- Configure HTMX views.
- Load content on demand.
- Support hypermedia UX.
- Render by view mode.
- Enhance interactivity
