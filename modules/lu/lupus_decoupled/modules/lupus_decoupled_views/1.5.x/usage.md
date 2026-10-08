<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Lupus Decoupled Views adds Views plugins that render a View as custom elements, so listings built in Drupal appear in the front end.

---

Listings are where a decoupled build usually leaks logic. A View encodes filters, sorts, contextual arguments, access checks, pagers and caching; a front end that queries an API and sorts the results reimplements a subset of that, and the subset is rarely the access checks.

Rendering the View itself as custom elements keeps all of it in Drupal. The front end receives a listing that has already been filtered, sorted, access-checked and paged, and turns it into components. A site builder changing a View changes the front end, with no deployment.

The pager is the detail to plan. A custom-elements listing has to expose enough for the front end to request the next page, and how that interacts with front-end routing — infinite scroll versus paged URLs, and what a shared URL points at — is a design decision worth settling early rather than discovering.

---

- Render a View in a decoupled front end.
- Keep Views access checks in Drupal.
- Let a site builder change a listing without deployment.
- Preserve filters and sorts server-side.
- Use contextual filters in a decoupled listing.
- Page through a decoupled listing.
- Implement infinite scroll over a View.
- Keep listing URLs shareable.
- Reuse Views caching for listings.
- Avoid reimplementing query logic in the front end.
- Expose a filtered listing per category.
- Style listing results as components.
- Debug a listing showing unexpected results.
- Plan pager behaviour with front-end routing.
- Retire a bespoke listing endpoint.