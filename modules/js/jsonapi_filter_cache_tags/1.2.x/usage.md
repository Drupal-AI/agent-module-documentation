<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
JSON:API Filter Cache Tags provides cache tag integration for JSON:API.

---

JSON:API Filter Cache Tags **adds cache-tag integration for JSON:API filtered collection responses** — so a
filtered JSON:API list carries appropriate cache tags and is correctly invalidated when relevant entities change,
improving cache accuracy for decoupled front-ends. It depends on core JSON:API, in the Custom package.

Use it to improve JSON:API cache invalidation. It is a decoupled/performance feature affecting caching; JSON:API
itself still enforces entity/field access on the data, and it has no access-control role. Enable it for better
JSON:API caching.

---

- Add cache tags to JSON:API filters.
- Invalidate filtered collections correctly.
- Improve cache accuracy.
- Depend on core JSON:API.
- Serve decoupled/performance.
- Cache filtered lists.
- Rely on JSON:API's entity/field access for data.
- Have no access-control role.
- Enable it for JSON:API caching.
- Handle JSON:API cache tags.
- Add cache tags.
- Configure nothing (behavior).
- Invalidate caches.
- Handle the caching.
- Tag responses.
- Configure JSON:API.
- Handle performance.
- Cache collections.
- Enable it.
- Provide JSON:API filter cache tags.
