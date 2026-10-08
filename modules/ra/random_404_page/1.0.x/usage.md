<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Random 404 page lets you list several site paths for the 404 (and 403) error page and serves a randomly chosen one each time an error is raised.
---
Drupal core only allows a single 404 and single 403 page. This module hides core's single-path fields on the Basic site settings form (`/admin/config/system/site-information`) and replaces them with two textareas where you enter one path per line for 404 pages and 403 pages, stored in `random_404_page.settings` under keys `404_pages` and `403_pages`. Entered paths are validated with the core path validator (`Drupal::pathValidator()->isValid()`), which rejects paths the configuring user cannot access, so an admin cannot save a path they lack access to.

At runtime an `ErrorPageEventSubscriber` (extending core `CustomPageExceptionHtmlSubscriber`, registered at core priority + 1) picks a random path from the relevant list with `array_rand()` and issues a sub-request via the inherited `makeSubrequestToCustomPath()` — the same access-checked mechanism core uses for a single custom error page, so the served page still passes normal access control. There is no admin UI beyond the altered site-information form and no separate permission; it reuses core's "administer site configuration".
---
- Show a different 404 page on each miss to reduce a static branded 404
- Serve one of several curated "page not found" landing pages at random
- Rotate 403 access-denied pages across a set of nodes/views
- Enter multiple 404 paths, one per line, on the site-information form
- Enter multiple 403 paths, one per line, on the same form
- A/B different error-page content without extra modules
- Point error paths at nodes, views, or custom-controller routes
- Localize error pages by listing per-language aliases
- Fall back to core behaviour by leaving a list empty
- Validate error paths at save time so broken paths are rejected
- Keep error-page config in `random_404_page.settings` for export
- Combine with a view of "helpful links" as one of the random targets
- Randomize marketing/upsell error pages on a content site
- Use distinct pools for 404 vs 403 so each error type has its own set
- Serve seasonal or campaign-specific error pages from a rotating set
- Audit which error paths are configured by reading the settings config
- Deploy the same error-page set across environments via config sync
