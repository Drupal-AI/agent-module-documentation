<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Search API Taxonomy Filter provides a pre-processor to index only content associated with configured taxonomy terms.

---

Sometimes only content tagged with certain taxonomy terms should be searchable. Search API Taxonomy Filter is an index pre-processor that limits indexing to content associated with configured terms. It is a Search API configuration feature. The consideration is that limiting what is indexed affects search results (content not indexed will not appear in search) — this is a scoping tool, not access control, so content excluded from the index is merely not-found-in-search, not access-protected (it may still be reachable by URL). Confirm the term filter matches your search-scope intent, and do not rely on 'not indexed' to hide sensitive content.

---

- Index only tagged content.
- Limit the search index by term.
- Scope search to taxonomy.
- Pre-process the index.
- Filter indexed content.
- Confirm the term filter.
- Treat as scoping not access.
- Understand excluded content isn't protected.
- Scope search results.
- Index by taxonomy term.
- Narrow the index.
- Configure the pre-processor.
- Enable when needed.
- Keep disabled otherwise.
- Restrict administration.
- Confirm on your site.
- Test before production.
- Review configuration.
- Pair with related modules.
- Verify theme fit.
- Match your use case.
- Confirm compatibility.