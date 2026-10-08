<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Breadcrumb Menu re-labels breadcrumb links with **menu link titles** instead of page titles, so the trail reads with the short labels an editor chose for navigation.

---

Drupal's default breadcrumb is path-based and shows each page's own title. That is often wrong in a specific, annoying way: a page titled "Applying for a residents' parking permit in the borough" appears in the menu as "Parking permits", and the breadcrumb should say the latter — the short navigation label, not the long page heading. Long titles also break the visual line of a breadcrumb and wrap onto two rows on mobile. This module registers its own breadcrumb builder (`src/BreadcrumbBuilder.php`, service `breadcrumb_menu.breadcrumb`, tagged `breadcrumb_builder` at priority 1) that **extends** core's `PathBasedBreadcrumbBuilder`. It keeps the standard path-based trail — same links, same order, already filtered to what the user may access — and only swaps a link's **text** for the matching menu link title where that link's URL is in the active trail of a menu you configured. Where a breadcrumb link has no matching menu link, its page title stays. You choose which menus supply titles at `/admin/config/system/breadcrumb-menu`, behind the module's own `administer breadcrumb_menu` permission; the setting is the `menus` list in `breadcrumb_menu.settings`. There are no dependencies beyond core and the range is a wide `^8 || ^9 || ^10 || ^11`. Because it registers a breadcrumb builder, it competes with other breadcrumb modules by priority — running two is a common cause of "my breadcrumb settings do nothing".

---

- Use short menu labels in the breadcrumb instead of long page titles.
- Stop long page titles breaking the trail onto two lines.
- Make the breadcrumb match the wording of the navigation.
- Improve how breadcrumbs read on mobile.
- Reflect editorial menu labels in the trail.
- Give a council or government site readable breadcrumbs.
- Keep page titles where a page is not in any configured menu.
- Pick which menus drive the breadcrumb (main, footer, a custom menu).
- Draw titles from more than one menu at once.
- Configure breadcrumb behaviour without writing code.
- Reduce breadcrumb text wrapping in a tight header.
- Align the breadcrumb with the site's information architecture.
- Keep breadcrumbs consistent across sections that share a menu.
- Replace a bespoke breadcrumb builder with a maintained one.
- Delegate breadcrumb configuration to an editor role via a dedicated permission.
- Improve the scanability of a page header.
- Match breadcrumb wording to a content style guide.
- Set the menus list per environment with drush during deployment.
- Backfill the `main` menu automatically on an upgraded site (update hook).
- Support a site still on Drupal 8 through 11.
- Vary breadcrumb output correctly by active menu trail (cache-aware).
- Swap titles only, without adding or removing trail links.
