<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Simple GSE Search puts a Google Programmable Search Engine (Custom Search Engine) on the site, so search results come from Google's index and render through Google's own client-side widget rather than from Drupal's search.

---

The module is deliberately thin. You paste one value — the Custom Search Engine id (`cx`) — into a settings form at `/admin/config/search/simple_gse_search` (permission `administer gse search`), then place the "Simple GSE Search Block". The block shows a text field whose submit redirects to `/search?s=<query>`; the `/search` route (permission `access gse search page`) renders a `gcse:searchresults-only` element and attaches a small library that loads `https://cse.google.com/cse.js?cx=<cx>`. From there Google's script reads the `s` query parameter and draws the results in the browser — the server makes no call to Google and stores no key, only the public `cx` id. Because it relies on Google's crawl, results reflect what Google has already indexed, so new or unpublished content lags and content that is not publicly reachable will not appear. It is core-only (`^8.8 || ^9 || ^10 || ^11`) with no other dependencies. One operational note: `/search` is core Search's default path, and both `hook_install` and `hook_requirements` warn you to uninstall the core `search` module so the two do not collide.

---

- Add site search without running Search API or a Solr backend.
- Use Google's relevance ranking and typo tolerance with no indexing pipeline.
- Give a small public site usable search cheaply.
- Replace core search on a brochure or documentation site.
- Show Google results inside a themed Drupal page at `/search`.
- Place a reusable search box block in any region.
- Configure the Custom Search Engine id (`cx`) centrally in one field.
- Restrict who can reach the results page via `access gse search page`.
- Provide search on a static-ish or low-traffic site.
- Search PDF and other content Google has already crawled.
- Offer search during a migration while a real backend is not yet built.
- Search across several related domains configured in one CSE.
- Avoid maintaining any search index in Drupal.
- Give editors a search feature with nothing to reindex.
- Add search to a site on limited hosting.
- Reuse an existing Programmable Search Engine already set up in Google.
- Translate the CSE id per language via config translation.
- Point the search box redirect at Google's widget without custom code.
- Keep the integration client-side, with no API key stored on the server.
- Stand up search on a marketing site in minutes.
