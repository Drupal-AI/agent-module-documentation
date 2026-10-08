<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Single Page Site renders the content behind every item in a chosen menu onto one scrollable page, and rewrites that menu's links to point at anchors on the page instead of navigating away.

---

The one-pager is a whole genre of site — a product launch, a conference, a small organisation — and building one in Drupal normally means either a single enormous node or a paragraph stack that duplicates content already living in nodes. This module takes the third route: keep the nodes, keep the menu, and let the menu define both the sections and their order. The controller walks the configured menu tree, issues an internal sub-request for each renderable link, and stacks the results into one page keyed by anchors derived from each link's path. A scrollspy library highlights the matching menu item as you scroll, optional smooth scrolling animates jumps to a section, and the menu links themselves are rewritten client-side into `#anchor` fragments.

Configuration lives at Configuration > System > Single Page Site (`/admin/config/system/single-page-site`). You choose the menu, then give the module the CSS class or id of that menu's wrapper in your theme so the JavaScript can find and rewrite its links — that value is theme-specific (the README notes something like `#block-themename-main-menu`). You also set the page title, the HTML tag used for each section heading (e.g. `h2`), scroll-highlight distances, and advanced options for smooth scrolling, URL-fragment updates, an offset selector, and multilingual anchor handling. Ticking "Homepage" points `system.site` `page.front` at `/single-page-site`. The assembled page is served at `/single-page-site`.

Two permissions ship — `administer single page site` (the settings form) and `view single page site` (the assembled page) — so who may see the one-pager is controlled independently of the settings form. Each section is produced by a real internal sub-request through the HTTP kernel, so the underlying content is rendered exactly as core would render it for the current viewer.

If the optional Link Attributes module is installed, a "Menu item selector" field lets you name a class that a menu link must carry to be included; give a link the class `hide` to render its content on the page while dropping the link itself from the visible menu. An optional bundled submodule, `single_page_site_next_page`, appends a "scroll to next page" link to the bottom of each section by subscribing to the module's output-alter event. Custom code can hook the same point via `EventSinglePageSiteAlterOutput` (`SinglePageSiteEvents::SINGLE_PAGE_SITE_ALTER_OUTPUT`).

---

- Build a one-page website from an existing Drupal menu.
- Render several nodes onto a single scrollable page.
- Rewrite menu links into in-page `#anchor` fragments.
- Keep content in individual nodes rather than one huge node.
- Order the page sections by the menu's own link order/weight.
- Serve the assembled one-pager at `/single-page-site`.
- Use the single page as the site front page (sets `system.site` `page.front`).
- Restrict who may view the single page with `view single page site`.
- Restrict who may configure it with `administer single page site`.
- Point the module at your theme's menu wrapper class/id for link rewriting.
- Set a custom page title and the heading tag (`h2`, `p`, …) for each section.
- Highlight the active menu item while scrolling (scrollspy).
- Enable smooth animated scrolling to a clicked section.
- Update the URL fragment as the reader scrolls between sections.
- Compensate for a fixed menu's height with an offset selector.
- Strip language URL prefixes out of anchor IDs for multilingual menus.
- Include or exclude specific menu items by CSS class (with Link Attributes).
- Show a menu item's content while hiding the link, using the `hide` class.
- Append a "scroll to next page" link per section via the Next Page submodule.
- Alter each rendered section from custom code via the alter-output event.
- Build a conference, event, or product-launch landing page.
- Reuse existing nodes without duplicating their content into a page builder.
- Combine with Scroll to top / Back to top modules for navigation aids.
- Prevent editors from adding the single-page route or front page into the source menu (built-in menu-link validation).
