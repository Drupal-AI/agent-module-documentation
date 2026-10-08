PrevNext adds "Previous" and "Next" links to an entity's display so visitors can page through sibling entities of the same type/bundle (and language) ordered by entity ID.

---

You enable PrevNext per entity type and per bundle on a single settings page (`/admin/config/user-interface/prevnext`, route `prevnext.admin_settings`). Once a bundle is enabled the links can be rendered three ways: as two pseudo-fields (`prevnext_previous` / `prevnext_next`) on the *Manage display* tab, via the **PrevNext links** block (placed on canonical entity routes), or via the **PrevNext links** Views field. The core `PrevNextService::buildEntityLinks()` computes the neighbours with an entity query filtered by `status = 1`, the current bundle, and the current language, using `id < current` (previous, sorted DESC) and `id > current` (next, sorted ASC), each `range(0,1)` with `accessCheck()`. An optional **infinite loop** setting wraps around to the last/first entity when an edge is reached. Access is gated by a global `view prevnext links` permission plus dynamically generated per-entity-type permissions (`view {entity_type} prevnext links`) built for every fieldable entity type that has a canonical link template. Output is cacheable (contexts `url`, `user.permissions`; tags include the entity-type list/view tags and a custom `prevnext-{type}-{bundle}` tag invalidated on presave). Rendering uses a single `prevnext` theme hook (`templates/prevnext.html.twig`).

---

- Add Previous/Next links to full-page node displays so readers can browse articles sequentially.
- Page through taxonomy term pages of a given vocabulary in ID order.
- Add sibling navigation to any custom fieldable entity type with a canonical URL.
- Restrict prev/next navigation to specific bundles (e.g. only the `article` node bundle).
- Render the links as a block placed only on canonical entity routes.
- Render the links as a Views field inside a custom listing.
- Render the links as manage-display pseudo-fields and reorder them among other fields.
- Wrap navigation around (last → first) by enabling the infinite-loop option.
- Keep navigation within the current content language on multilingual sites.
- Only show links to users with a specific per-entity-type permission.
- Grant a blanket `view prevnext links` permission across all enabled types.
- Skip unpublished neighbours automatically (query filters `status = 1`).
- Respect entity access grants (query runs with `accessCheck()`).
- Provide keyboard-friendly next/prev anchors themed via a Twig template.
- Invalidate cached prev/next output automatically when a sibling entity is saved.
- Theme the links with a custom template override of `prevnext.html.twig`.
- Call `PrevNextService::getPreviousNext($entity)` from custom code to get neighbour IDs.
- Build a render array of the links programmatically with `buildEntityLinks($entity)`.
- Add "next lesson / previous lesson" navigation to a course/lesson content type.
- Add gallery-style previous/next paging to image or portfolio nodes.
- Expose prev/next in a decoupled front-end by reading the block/Views field output.
