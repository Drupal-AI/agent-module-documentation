<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Metatag Auto Pagination automatically generates `rel="prev"` and `rel="next"` link meta tags in the page head whenever the current page renders a pager.

---

Search engines historically used `rel=prev`/`rel=next` to understand paginated series (page 2, 3, ... of a listing). Adding those links by hand for every view or listing is tedious; this module derives them automatically from Drupal's core pager. It is a plugin/extension of the Metatag module: it ships a `PagerLinks` metatag tag plugin plus a `PagerManager` service that reads the active pager (via `@pager.manager` and the request stack) and an `AttachmentTools` service that injects the computed prev/next `<link>` elements into the response head.

The module has no routes, permissions, forms, or configuration entities of its own. You enable it and then switch on the "AUTO PAGER LINKS" service inside the standard Metatag basic configuration. When a page has a pager and is not on the first/last page, the corresponding prev/next links are attached; on out-of-range pages the `OutOfPagination` hook suppresses them. Because it only reads the current pager state and writes `<link>` tags, there is no untrusted input handling and no anonymous mutating surface.

---

- Add rel=prev/next link tags to a paginated view page.
- Improve SEO signalling for multi-page listings.
- Enable auto pager links from the Metatag basic settings.
- Let search engines discover the next page of a series.
- Let search engines discover the previous page of a series.
- Apply pagination meta tags site-wide without per-view config.
- Suppress prev/next links on the first page automatically.
- Suppress next link on the last page automatically.
- Rely on Drupal core's pager to compute page URLs.
- Attach the links via Metatag's normal head-tag pipeline.
- Combine with other Metatag tags on the same page.
- Avoid hand-coding prev/next links in templates.
- Support paginated taxonomy term listings.
- Support paginated node listing views.
- Keep pagination hints consistent across content types.
