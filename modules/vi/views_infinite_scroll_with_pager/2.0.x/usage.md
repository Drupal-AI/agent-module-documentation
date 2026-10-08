Views Infinite Scroll With Pager adds a Views pager plugin that renders a standard numeric pager beneath a Views Infinite Scroll display, so the same view is navigable without JavaScript and crawlable by search engines.

---

Infinite scroll is a pleasant interaction and a poor URL scheme. Content past the first page has no address, so a crawler indexes page one and stops, a visitor cannot link to what they found, and anyone without JavaScript sees a truncated list with no way forward. Those are three problems with one shared cause: the pager was replaced rather than supplemented.

This module supplements it. It ships one Views pager plugin (`infinite_scroll_with_pager`) that extends the Views Infinite Scroll pager and adds a full numeric pager on top: infinite scroll keeps working for people who have JavaScript, and a standard pager is rendered too, giving every page a real URL. You enable it per-view by choosing the pager type; the view must have "Use AJAX" set to Yes under Advanced. Pager options let you set how many page links are visible and the first/previous/next/last label text, and whether page numbers are shown 1-based.

Theming is expected to be overridden and the README explains exactly how: copy `views-infinite-scroll-with-pager.html.twig` from the module into your theme's `templates/` folder, then swap the included pager template for your framework's — the example replaces `{% include '@system/pager.html.twig' %}` with `{% include '@bootstrap/system/pager.html.twig' %}`. Worth confirming after installation: that the pager links produce the same result set the scroll produces, and that the pager is not hidden by CSS from a theme that assumed infinite scroll meant no pager.

---

- Make an infinite-scroll view crawlable by search engines.
- Give every page of a scrolling view a real, linkable URL.
- Support visitors and crawlers that have JavaScript disabled.
- Let a visitor bookmark or share a specific page of a listing.
- Add a full numeric pager underneath Views Infinite Scroll.
- Keep infinite scroll working for JavaScript users while adding a pager fallback.
- Apply progressive enhancement to a paged listing.
- Improve SEO and deep-page indexing on a long scrolling listing.
- Set the number of visible page links in the pager (default 9).
- Customise the first / previous / next / last pager link labels.
- Show page numbers 1-based instead of 0-based for readability.
- Keep an accessible, keyboard-navigable fallback for the listing.
- Override the pager template in your theme.
- Use a Bootstrap (or other framework) pager markup with infinite scroll.
- Copy the module's Twig template into the theme and swap the pager include.
- Verify pager results match the infinite-scroll results after install.
- Check the pager is not hidden by theme CSS that assumed no pager.
- Ensure the view has "Use AJAX = Yes" so the scroll append works.
