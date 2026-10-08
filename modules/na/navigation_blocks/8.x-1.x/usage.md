Navigation Blocks provides a set of front-end block plugins — configurable "back" buttons and an in-page table of contents — that help visitors move around a Drupal site.

---

The module's centrepiece is a smarter back button. Rather than replaying the browser's history, the "Back Button" block can be aimed at a preferred set of paths (matched against the HTTP referer, with wildcard and path-alias support), fall back to a fixed link when no referer matches, or optionally use `javascript:history.back()`. Deriver-driven variants target the current page's entity: the Entity Canonical Back Button links to the canonical page of the entity being viewed, while the Entity Reference and Reversed Entity Reference back buttons follow an entity-reference field (forward or reverse) to a related entity. A separate Table of Contents block scans the rendered page for headings and builds an in-page navigation list client-side, with configurable heading depth, wrapper selector and CSS classes, plus an optional CKEditor 4 button (`headingtoccontrol`) for tagging headings. All blocks are placed and configured through Drupal core's Block UI; the module adds no routes, permissions or configuration pages of its own. It depends on core's Block and Link modules and works on Drupal 9, 10 and 11.

---

- Add a "Back Button" block that returns visitors to the page they came from, but only when the referer matches an allowed set of paths.
- Configure preferred back paths (one per line, wildcards allowed) so the back button only appears for specific sections of the site.
- Use the matching page's real title as the back-link text (e.g. "Back to Products") instead of a generic label.
- Provide a fallback link (URL + text) shown when the referer does not match any preferred path.
- Offer a purely client-side back button using `javascript:history.back(-1)` for simple "go back one page" behaviour.
- Place an "Entity Canonical Back Button" on an entity's sub-pages (edit, revisions, custom tabs) that links back to the entity's main/canonical page.
- Suppress the canonical back button automatically when the visitor is already on the entity's canonical route.
- Add a back button that follows an entity-reference field from the current node to a parent/related entity (e.g. from an article back to its referenced series).
- Add a "reversed" entity-reference back button that finds an entity referencing the current one (e.g. from a taxonomy term back to a node that references it).
- Show a back-to-parent link on child content by pointing the entity-reference back button at the field that stores the parent relationship.
- Match back paths case-insensitively so `/Page`, `/page` and `/PAGE` are treated the same.
- Restrict back-button behaviour to same-origin referers only (off-site referers are ignored).
- Add a "Table of Contents" block to long articles or documentation pages that lists the page's headings as jump links.
- Limit the table of contents to a maximum heading level (e.g. only H2 and H3).
- Scope the table of contents to a specific region of the page via a jQuery wrapper selector.
- Include only headings explicitly marked with a `data-toc-show` attribute by enabling "only allowed" mode.
- Apply custom CSS classes to the table-of-contents list and links for theme integration.
- Give editors a CKEditor 4 toolbar button to add table-of-contents attributes to headings while writing content.
- Combine an entity back button with a table of contents to give long entity pages both "return" and "jump-to-section" navigation.
- Reuse the module's `navigation_blocks.back_button_manager` and `navigation_blocks.entity_button_manager` services from custom code to build bespoke navigation links.
- Provide wayfinding on deep taxonomy or catalogue hierarchies where the browser back button alone is unreliable.
- Add contextual "return" links on landing pages reached from multiple entry points, driven by referer matching.
