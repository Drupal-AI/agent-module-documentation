<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Exclude Frontpage Node Views filter adds a one-click Views filter (and a matching Search API processor) that removes the site's front-page node from results — so a "latest content" listing or search page does not repeat the page the visitor is already on.

---

Drupal's front page is usually a node chosen in `system.site:page.front`, and it habitually shows up again in every listing built over content. This module solves that with three small pieces. A `FrontPageNode` service resolves the current front-page node by taking the configured front path and running it through the router, so it works whether the setting is `/node/1`, an alias, or a path that resolves to a node route. A Views filter plugin, `@ViewsFilter("not_front")`, uses that service to exclude the node from the query; it overrides `canExpose()` because there is nothing for a visitor to choose — it is either applied or not. A Search API processor, `exclude_front_page_node`, does the same job for indexed search, with `supportsIndex()` guarding that it only offers itself to relevant indexes. Nothing is configurable beyond adding the filter or enabling the processor, there are no permissions, no schema and no Drush commands.

---

- Keep the front-page node out of a "latest news" view.
- Stop the homepage appearing in sitewide search results.
- Remove the front page from an A–Z listing.
- Avoid duplicate links on a landing page that lists content.
- Exclude the front page from an RSS feed view.
- Keep a promoted-content block from linking to the current homepage.
- Handle a front page set by path alias rather than node id.
- Cope with the front page changing without editing every view.
- Exclude the front page from a Search API index at processing time.
- Keep sitemap-style listings free of the homepage.
- Avoid a hard-coded node id filter in views.
- Reuse the same exclusion logic in views and search.
- Prevent the homepage from being counted in listing totals.
- Simplify a view that previously used a NID exclusion filter.
- Keep listings correct across environments with different front pages.
- Exclude the front page from a related-content view.
- Provide cleaner results for a content audit view.
- Remove the front page from a taxonomy term listing.
- Keep an editorial dashboard free of the homepage row.
- Apply the exclusion without exposing a control to visitors.
