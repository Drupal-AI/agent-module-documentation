<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Crouton replaces Drupal core's path-based breadcrumb builder with a menu-based one that derives each page's breadcrumb trail from the active trail of a configured menu.

---

Crouton registers a `breadcrumb_builder` service (`crouton.breadcrumb`, priority 2000) that applies on non-admin routes whose page has a link in a chosen menu. It walks the active menu trail for that menu, reverses it to root-first order, and turns each menu link into a breadcrumb `Link` using the menu item's own label and target — so breadcrumb text is decoupled from the target content's title. Pages with no link in the selected menu fall through to the next applicable builder (core's default), leaving them unaffected. A single admin form (`/admin/config/crouton`, permission `administer crouton`) picks the source menu and toggles four booleans: prepend a Home link, append the current page, include disabled menu items, and hide `<nolink>` (plain-text) items. When no menu is selected the module is effectively disabled. The active link is marked `aria-current="page"` for accessibility. There is no block, field, formatter, or Drush command — only the builder service, one config object (`crouton.settings`), and one settings form.

---

- Show breadcrumbs that follow a page's place in a menu instead of its URL path.
- Use a hidden/administrative menu (not shown to visitors) purely to drive breadcrumbs.
- Give breadcrumb links labels different from the target page titles.
- Add a leading "Home" breadcrumb linking to the front page.
- Append a non-linked crumb for the current page at the end of the trail.
- Include ancestral menu items that are disabled in the breadcrumb trail.
- Omit structural `<nolink>` menu items so only real links appear.
- Keep core's default breadcrumbs on pages not represented in the chosen menu.
- Mark the current page's crumb with `aria-current="page"` for screen readers.
- Build breadcrumbs from the Main navigation menu for a content site.
- Build breadcrumbs from a custom "Documentation" menu on a docs section.
- Decouple breadcrumb hierarchy from taxonomy or URL structure.
- Reorganize breadcrumbs by editing the menu, with no code changes.
- Clear the configured menu automatically when that menu entity is deleted.
- Cache breadcrumbs per route and invalidate them when settings or menu links change.
- Restrict who can change breadcrumb behavior via the `administer crouton` permission.
- Rename the "Home" crumb through interface translation rather than config.
- Disable Crouton on the fly by setting the source menu to "- None -".
- Translate breadcrumb labels via translated menu links.
- Provide consistent, editor-controlled breadcrumbs across a large site.
