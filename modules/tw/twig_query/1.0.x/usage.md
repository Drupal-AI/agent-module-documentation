<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Twig Query provides an interface for querying data inside Twig templates.

---

Twig Query provides a **Twig interface for querying entity data** — letting theme templates fetch entities
(e.g. recent nodes of a type) directly in Twig, without a preprocess hook or a View. It depends on core System.

Use it to query content from within (developer-controlled) Twig templates. It is a developer/theming feature
with access implications to understand: its base query uses `accessCheck(FALSE)` **plus** an entity access
**query tag** and filters to **published** (`status = 1`) — so node-access **grants** are applied at the query
level (the same pattern Views uses) and unpublished content is excluded, but the full entity access check is
not run. Two things follow: keep this API to **developer-controlled Twig templates** (do not expose it where
untrusted users can author Twig — that would be arbitrary content querying), and be aware access enforcement
relies on the **access tag** (grant-based) rather than per-entity access. It has no access-control role of its
own. Use the query functions in templates.

---

- Query entity data in Twig.
- Fetch entities in templates.
- Avoid a preprocess hook or View.
- Depend on core System.
- Filter to published (status = 1).
- Use accessCheck(FALSE) + an access tag.
- Apply node-access GRANTS at query level.
- Keep it to developer-controlled Twig templates.
- Not expose it to untrusted Twig authors.
- Know access relies on the tag, not per-entity access.
- Have no access-control role of its own.
- Use the query functions.
- Handle Twig queries.
- Query content.
- Configure nothing (functions).
- Fetch content.
- Handle the interface.
- Query in templates.
- Restrict to developers.
- Provide Twig queries.
