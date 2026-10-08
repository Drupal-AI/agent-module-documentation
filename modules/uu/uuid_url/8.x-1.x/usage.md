<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
UUID url creates a UUID url for entities.

---

UUID URL provides a **UUID-based URL for entities** — a route `/by_uuid/{entity_type}/{uuid}` that looks
up the entity by its UUID and redirects to its canonical URL, so you can link to content by its stable UUID
rather than its numeric ID or alias. It is in the UUID url package.

Use it to reference entities by UUID. It is a routing/utility feature and it is **access-safe**: the controller
loads the entity and **checks `$entity->access('view')` before redirecting** (verified), so the public route
does **not** expose entities a user cannot view — a UUID for restricted content still resolves only for users
with view access. It has no other access-control role. Link to entities via `/by_uuid/…`.

---

- Provide a UUID URL for entities.
- Redirect /by_uuid/{type}/{uuid} to the canonical URL.
- Link by stable UUID.
- Look up the entity by UUID.
- Check entity view access before redirect.
- Not expose entities the user can't view.
- Reference content by UUID.
- Have no other access-control role.
- Link via /by_uuid/.
- Handle UUID URLs.
- Resolve by UUID.
- Configure nothing (route).
- Redirect by UUID.
- Handle the route.
- Link by UUID.
- Resolve entities.
- Handle UUID routing.
- Redirect to canonical.
- Use the UUID route.
- Provide UUID URLs.
