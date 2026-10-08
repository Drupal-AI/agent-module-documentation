<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Node Noindex adds a per-node checkbox that emits a `noindex` robots directive, keeping that page out of search results.

---

Not everything published should be found. A thank-you page reached after a form submission, a landing page built for one campaign's traffic, a duplicate kept for a specific audience, a staging-like page left visible for a client, an internal notice that is public only because making it private was more work — each should exist and should not appear in a search result, and the distinction is editorial rather than structural, which is why it lives on the node form. The mechanism is small and deliberately two-step: first an admin ticks *Show the 'Exclude from search engines' field* on a content type (a node-type third-party setting, optionally with a default), and only then does an *Exclude from search engines* checkbox appear on nodes of that type — and only for users holding the `mark content as not indexable` permission, so the toggle is a granted responsibility rather than something every editor changes casually. The flag is stored as a boolean base field on the node (translatable and revisionable), and on the node's page a `hook_preprocess_html` appends a fixed `<meta name="robots" content="noindex">` to the HTML head. Version **2.0.1**, core `^9 || ^10 || ^11`, no dependencies outside core. **The distinction that matters and is constantly confused: `noindex` is not access control, and it is not `robots.txt`.** A `noindex` page is fully readable by anyone with the URL — it asks search engines not to list it, and only the ones that comply obey. Anything that must not be read needs permissions. And `robots.txt` asks a crawler not to *fetch* a page, the opposite mechanism, with an important consequence: **a page blocked in `robots.txt` cannot be seen to carry `noindex`**, so a page blocked both ways can still appear as a bare URL, because the crawler was told not to look at the very tag telling it to stay away. Use one or the other deliberately. Two further notes: removing a page from an index it is already in takes time and is best pushed through the search engine's own removal tools; and a `noindex` page passes link equity nowhere useful, so it should stay out of internal linking strategy.

---

- Keep a thank-you / form-confirmation page out of search.
- Exclude a campaign landing page once the campaign ends.
- Hide a deliberate duplicate page from results.
- Keep an internal-but-public notice unlisted.
- Exclude a print version of a page.
- Keep a client review / preview page out of search.
- Exclude a test or example page from indexing.
- Hide a thin, low-value page from results.
- Exclude a paginated or filtered variant.
- Hide a members-only landing page from the index.
- Exclude a redirect target page.
- Keep a temporary notice unlisted while it is live.
- Exclude a staff-facing page from results.
- Hide a partner- or audience-specific page.
- Keep a competition / giveaway entry page out of results.
- Exclude a page that is still pending editorial review.
- Default a whole content type to noindex (e.g. a "scratch" type) via the per-type default.
- Restrict who can set noindex by granting `mark content as not indexable` to specific roles only.
- Keep noindex per-translation, since the field is translatable.
- Flag a superseded article that must stay reachable by its old URL but off search.
