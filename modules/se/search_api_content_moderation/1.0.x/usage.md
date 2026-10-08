<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Search API Content Moderation integrates a Content Moderation processor into Search API.

---

Search API Content Moderation adds a **Content Moderation processor to Search API** — so a search index
can include the content-moderation state and index/filter by it (e.g. only index published/approved content,
or expose moderation state to search). It depends on Search API and core Content Moderation, in the Search
package.

Use it to make moderation state available to Search API. It is a search feature with an access-relevant angle:
**configure it so that non-published/draft content is not exposed** through search to users who shouldn't see
it — Search API results should respect content access, so use the processor to index/filter by state
appropriately (indexing draft content without filtering it out is a disclosure risk). It has no access-control
role of its own. Configure the moderation processor on the index.

---

- Add a Content Moderation processor to Search API.
- Index/filter by moderation state.
- Index only published/approved content.
- Depend on Search API and Content Moderation.
- Expose moderation state to search.
- Handle moderated content in search.
- CONFIGURE it so drafts aren't exposed.
- Respect content access in results.
- Filter by state appropriately.
- Have no access-control role of its own.
- Configure the processor on the index.
- Handle moderation in search.
- Index by state.
- Configure the index.
- Filter by state.
- Handle the processor.
- Index moderation.
- Search by state.
- Set the processor.
- Provide moderation-aware search.
