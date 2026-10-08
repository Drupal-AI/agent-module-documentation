<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Entity 404 makes a content entity's canonical page return the 404 (not found) page when the entity fails certain configured conditions.

---

Entity 404 makes an entity page **return a 404 (not found)** when the entity fails configured conditions —
so instead of showing a page (or a 403), a matching entity is presented as if it doesn't exist. Out of the
box it applies two checks to the entity being viewed: a **full view mode** must be configured for its
type/bundle, and (when content translation is enabled) the entity must be **translated** in the current
content language or one of its fallback languages. Either check can be turned off in the settings. This is
useful to hide entities that shouldn't be reachable and to avoid confirming their existence.

Understand what it does and doesn't do: returning **404 instead of 403** avoids disclosing that a
restricted entity exists (a privacy nicety), but Entity 404 governs the **rendered page response** — it is
**not a substitute for real entity access control** (the entity still exists and may be reachable via other
routes, APIs, or listings unless those are also restricted). The requirement is additive to core's own
view-access check, so it only ever withholds a page, never grants one. Use it alongside proper access
control, not instead of it. Configure the checks at `/admin/config/system/entity-404` (permission
**configure entity 404**). Version 1.2.x adds Drupal 12 support and honours language fallback candidates in
the translation check.

---

- Return 404 for entities failing configured checks.
- Hide an entity type/bundle that has no full view mode.
- 404 an entity that isn't translated in the current language.
- Accept an entity reachable through a configured fallback language.
- Show not-found instead of a 403 to avoid confirming existence.
- Turn off the full-view check when it doesn't fit the site.
- Turn off the translation check for a mostly-untranslated site.
- Keep untranslatable (`und` / `zxx`) entities always viewable.
- Leave path validation and link checking unaffected by the checks.
- Redirect an author to the edit form after saving an entity whose canonical page 404s.
- Hide entities by relying on bundle view-mode configuration.
- Combine with real access control for defence in depth.
- Treat it as a page-response layer, not an access-control layer.
- Configure the enabled checks from the settings form.
- Apply the behaviour across all content entity types automatically.
- Skip form-as-canonical routes (e.g. some media) so their edit pages still work.
- Return 404 on the canonical route while other routes stay as configured.
- Reduce information leakage about restricted or draft-only content.
- Provide its own `configure entity 404` permission for delegation.
- Adopt Drupal 12 with no configuration changes.
