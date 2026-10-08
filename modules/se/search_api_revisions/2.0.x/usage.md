<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Search API - revisions provides a datasource for indexing content entity revisions.

---

Search API - revisions provides a Search API datasource that indexes content-entity **revisions** — so
you can search across historical revisions of content (not just the current version), useful for auditing or
finding content that existed in a past state. It depends on the Search API module, in the Search package.

Use it to index/search entity revisions. **Security-relevant caveat: indexing revisions can expose content
that shouldn't be searchable.** Historical revisions include **unpublished/draft states and old content** —
if the search index/display doesn't restrict by access and revision status, a search could surface content a
user shouldn't see (e.g. an old unpublished draft's text). So when indexing revisions, ensure the index and
any search display **respect access and only expose intended revisions** (Search API's access handling +
your index configuration govern this) — be deliberate about which revisions are indexed and who can search
them. It has no access-control role of its own. Configure the revisions datasource on the index.

---

- Index content-entity revisions.
- Search across historical revisions.
- Support auditing/past-state search.
- Depend on the Search API module.
- Index revisions, not just current.
- Find content in a past state.
- CAVEAT: revisions can expose unpublished/old content.
- Ensure the index/display respects access + revision status.
- Not surface drafts a user shouldn't see.
- Be deliberate about which revisions are indexed.
- Restrict who can search revisions.
- Have no access-control role of its own.
- Configure the revisions datasource.
- Handle revision indexing.
- Index past revisions.
- Search revisions.
- Configure the index.
- Handle historical search.
- Restrict revision search.
- Index entity revisions.
