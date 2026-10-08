<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Overrides Drupal's core pager to insert extra jump links between the last visible page number and the final page, so deep pages in a long listing stay reachable in a few clicks.

---

Extra Pagination is a tiny, zero-configuration display module (package User Interface). It does not add its own pager to a page; instead it replaces how the existing core `pager` theme hook is drawn everywhere Drupal renders a pager (views, taxonomy term listings, node listings, search results, any query with a pager). On enable it uses `hook_theme_registry_alter()` to point the `pager` theme hook at its own `templates/pager.html.twig`, and `template_preprocess_pager()` (function `extra_pagination_preprocess_pager()`) to rebuild the pager's variables. Alongside the normal First/Previous/numbered/Next/Last items it computes an extra set of "jump" links via `pager_extra_pages()` in `includes/pager.inc`: starting from the last visible page it steps forward in base-10 intervals (10, 20, 30 ...), then widens the interval after ten steps, so even a listing with hundreds of pages exposes intermediate targets between the nearby links and the final page. The stated goal is SEO and crawlability, keeping any page reachable in roughly three or four clicks. There is no settings form, no route, no permission, no service and no config; it only changes how an already-rendered pager looks and paginates exactly what the underlying view or query already returns.

---

- Make deep pages of a very long listing reachable without clicking "next" dozens of times.
- Improve crawlability and SEO by keeping every page a few clicks from the first pager.
- Add intermediate "jump" links (page 10, 20, 30 ...) between the nearby page numbers and the final page.
- Enhance the pager on a Views listing with hundreds of result pages.
- Enhance the pager on taxonomy term pages that span many pages of content.
- Enhance the pager on core search results with a large number of matches.
- Provide better pagination on any custom query that uses a `PagerSelectExtender`.
- Override Drupal's default core pager template site-wide with no per-view configuration.
- Reduce the number of clicks a visitor needs to reach the last pages of an archive.
- Keep older paginated content discoverable by search-engine crawlers.
- Get improved pagination immediately after `drush en extra_pagination` with no setup step.
- Replace the built-in pager markup while keeping accessible First/Previous/Next/Last labels.
- Preserve existing query-string parameters and route when generating extra page links.
- Support multiple pagers on one page via the pager element identifier.
- Offer a lightweight alternative to heavier "load more" or infinite-scroll modules for deep sets.
- Adopt on Drupal 8.8 through 11 with no third-party library or module dependency.
- Uninstall to instantly restore Drupal's default pager (the override is only active while enabled).
- Standardise deep-pagination behavior across many sites by enabling one small module.
- Help editors and admins spot-check late pages of a moderation or content-list view quickly.
