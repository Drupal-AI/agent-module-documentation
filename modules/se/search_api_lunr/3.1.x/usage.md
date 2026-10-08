<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Search API Lunr provides a Search API back-end for the Lunr search engine, enabling client-side (in-browser) search.

---

Search API Lunr provides a Search API backend for Lunr — a small client-side search engine — building
a search index that is served to the browser so search runs entirely client-side (in JavaScript), with no
server query per search. It depends on Search API and jQuery UI Autocomplete. This suits static/decoupled
sites or small datasets where offloading search to the client is desirable.

Use it for client-side search on small/medium content sets. Security-relevant point: because the Lunr index
is generated and **served to the browser**, all indexed content is exposed to the client — so **only index
content that is safe to be fully public** (do not index access-restricted or non-public content into a
client-side index, as the entire index is downloadable). Confirm the index contains only public content. It
is a search-backend feature; access to indexed content is only as private as what you choose to index.

---

- Provide a Lunr client-side search backend.
- Run search in the browser.
- Serve the index to the client.
- Depend on Search API.
- Suit static/decoupled sites.
- Avoid a server query per search.
- Only index public-safe content.
- Not index restricted content client-side.
- Know the whole index is downloadable.
- Confirm the index is public content.
- Handle small/medium datasets.
- Offload search to the client.
- Build a Lunr index.
- Serve search to the browser.
- Index for client-side search.
- Mind index exposure.
- Configure the index.
- Support in-browser search.
- Provide client search.
- Index only public content.
