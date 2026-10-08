<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Entity 404 renders the 404 (not found) page when accessing an entity that fails certain conditions.

---

Entity 404 makes an entity page **return a 404 (not found)** when the entity fails configured conditions —
so instead of showing a page (or a 403), a matching entity is presented as if it doesn't exist. This is useful
to hide entities that shouldn't be reachable (e.g. by state/field value) and to avoid confirming their
existence. It provides its own permissions.

Use it to hide specific entities behind a 404. It is an access-adjacent content feature. Understand what it
does and doesn't do: returning **404 instead of 403** avoids disclosing that a restricted entity exists (a
privacy nicety), but Entity 404 governs the **rendered page response** — it is **not a substitute for real
entity access control** (the entity still exists and may be reachable via other routes, APIs, or listings
unless those are also restricted). Use it alongside proper access control, not instead of it. Configure the
404 conditions.

---

- Return 404 for entities failing conditions.
- Hide entities as not-found.
- Avoid confirming their existence.
- Return 404 instead of 403.
- Provide its own permissions.
- Hide by state/field value.
- TREAT it as page-response, not access control.
- Know the entity still exists elsewhere.
- Pair it with real access control.
- Have no full access-control role.
- Configure the 404 conditions.
- Handle entity 404s.
- Hide entities.
- Configure conditions.
- Show not-found.
- Handle the response.
- Return not-found.
- Configure hiding.
- Restrict rendering.
- Provide entity 404s.
