<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Search API Rabbit Hole provides a Search API processor that prevents indexing of content that has Rabbit Hole enabled with certain (hiding) Rabbit Hole plugins.

---

Search API Rabbit Hole provides a Search API processor that prevents indexing of content configured
with Rabbit Hole to be hidden — Rabbit Hole lets you control what happens when an entity's page is
accessed (display it, redirect, 403, 404), and this processor ensures content set to be hidden (via
certain Rabbit Hole plugins like access-denied or page-not-found) is not indexed by Search API. It depends
on Rabbit Hole and Search API.

Use it on sites using Rabbit Hole to hide certain entities' pages, so those entities don't leak into
search results (which would otherwise expose or link to content that shouldn't be directly accessible).
This is a security-adjacent/consistency control — it keeps the search index consistent with Rabbit Hole's
hiding, preventing hidden content from surfacing in search. It has no access-control role of its own but
supports Rabbit Hole's intent. Configure the processor on the relevant Search API index.

---

- Keep Rabbit Hole-hidden content out of search.
- Provide a Search API processor.
- Prevent indexing of hidden entities.
- Support Rabbit Hole's hiding.
- Depend on Rabbit Hole and Search API.
- Avoid hidden content in search results.
- Keep the index consistent with Rabbit Hole.
- Exclude access-denied/not-found entities.
- Support content-hiding intent.
- Have no access-control role of its own.
- Configure the processor on the index.
- Prevent search leakage of hidden content.
- Handle Rabbit Hole plugins.
- Exclude hidden pages from indexing.
- Keep search aligned with hiding.
- Avoid surfacing hidden entities.
- Support security-adjacent consistency.
- Configure on the Search API index.
- Prevent indexing hidden items.
- Align search with Rabbit Hole.
