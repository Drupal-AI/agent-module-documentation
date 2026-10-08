<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Single Page Site Next Page appends a "scroll to next page" link to the bottom of every section on a Single Page Site page, so readers can step from one section to the next.

---

This is an optional submodule of Single Page Site (`single_page_site`); it has no configuration and no UI of its own. When enabled it registers one event subscriber, `AlterSinglePageSiteOutput`, on the parent module's `single_page_site.alter_output` event. As each section is rendered the subscriber compares the section's position against the total number of renderable menu items and, for every section except the last, appends an anchor link (`<a class="to-next-page" href="#…">`) whose target is the next section's in-page anchor and whose text is the next menu item's title. The anchor is computed with the parent manager's `generateAnchor()` so it matches the ids the parent produced. Enable it with `drush en single_page_site_next_page`; style the `.to-next-page` links in your theme.

---

- Add a "scroll to next page" link at the end of each single-page section.
- Give visitors a one-click step-through of a one-pager.
- Skip the link on the final section automatically.
- Reuse the parent module's anchors so the link lands on the right section.
- Label each link with the next section's menu title.
- Style the links via the `.to-next-page` CSS class.
- Enable per-site without touching the parent module's configuration.
- Serve as a worked example of subscribing to `EventSinglePageSiteAlterOutput`.
