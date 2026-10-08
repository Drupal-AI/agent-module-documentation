<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Lunr provides a basic integration between Drupal and Lunr.js for client-side search.

---

Lunr integrates Drupal with Lunr.js — building a **client-side search index** (a JSON index the browser
loads) so search runs entirely in the visitor's browser, ideal for static/JAMstack sites (e.g. exported with
Tome) that have no live Drupal backend to query. It ships a `lunr_facet_example` submodule, provides its own
permissions, in the Tome package.

Use it for in-browser search on static sites. **Security-relevant caveat: the search index is public and
client-side.** Because the whole index is generated and served to the browser, **only index content that is
public** — anything in the index is exposed to anyone who loads it (there is no server-side access check at
search time). So exclude unpublished/restricted content from the Lunr index, and don't index fields that
shouldn't be public. It has no access-control role. Configure which content is indexed.

---

- Provide client-side search via Lunr.js.
- Build an in-browser search index.
- Suit static/Tome/JAMstack sites.
- Ship a facet example submodule.
- Provide its own permissions.
- Run search in the browser.
- KNOW the index is public and client-side.
- Only index PUBLIC content.
- Exclude unpublished/restricted content.
- Not index non-public fields.
- Have no access-control role.
- Configure which content is indexed.
- Handle static search.
- Build the index.
- Configure the index.
- Search client-side.
- Handle Lunr.
- Index public content only.
- Configure Lunr.
- Provide in-browser search.
