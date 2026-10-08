Views Infinite Scroll adds an Infinite Scroll pager to Views, replacing numbered pages with a "Load more" button or automatic loading of the next page of results as the visitor scrolls.

---

The module provides a single Views **pager plugin** (`infinite_scroll`) that you select in a View's pager settings instead of "Full" or "Mini" pager. When rendered, results are wrapped in a content container and a small JavaScript library (built on core's jQuery, once, and `views.ajax`) fetches and appends the next page via AJAX — so the View must have AJAX enabled to work (the module warns you on the View edit form if it isn't). You configure the button label, whether content loads automatically on scroll or only when the button is clicked, and whether all previously-paged content loads on initial page load (useful for deep-linking to a later page). The markup comes from the `views-infinite-scroll-pager.html.twig` template and is fully themeable, and an AJAX response subscriber ensures the appended markup behaves correctly. Because it is just a pager, it works with any View display — pages, blocks, and even EVA displays — and any row style (grids, teasers, tables). It is a lightweight, dependency-free (beyond Views) way to deliver the modern "endless feed" experience for blogs, galleries, product listings, and search results.

---

- Turn a blog or news listing into an endless "load more" feed.
- Add infinite scroll to an image or media gallery View.
- Provide a "Load More" button under a product listing instead of page numbers.
- Automatically load the next page as the user scrolls to the bottom.
- Replace numbered pagination on a search results View.
- Set a custom button label like "Show more articles".
- Keep users on one page for a mobile-friendly browsing experience.
- Lazy-load long taxonomy term listing pages.
- Apply infinite scroll to a View block in a sidebar.
- Use it with grid, unformatted, or table row styles.
- Load all previously paged results when linking directly to page 3.
- Improve perceived performance by loading content in small AJAX batches.
- Build a social-media-style activity stream.
- Add endless scrolling to a comments or reviews listing.
- Combine with exposed filters so results reload with infinite scroll after filtering.
- Use with the contributed EVA module to infinite-scroll an entity-embedded View.
- Theme the pager wrapper via `views-infinite-scroll-pager.html.twig`.
- Override the loading JavaScript by swapping the library.
- Give a portfolio site a continuous-scroll case-study list.
- Present a large catalog without overwhelming users with page links.
- Reduce clicks needed to browse a long archive.
- Deliver a "Pinterest-style" masonry feed when paired with a grid style.
- Ensure AJAX-driven pagination degrades with a visible fallback button.
- Paginate a decoupled/embedded listing that appends rows in place.
