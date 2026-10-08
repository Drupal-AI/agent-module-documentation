# Menu Link View Count — manual setup guide

**Menu Link View Count** (`menu_link_view_count`) lets you add a live count badge to
a menu link, driven by a **View**. You point a menu item at a View display, and the
module appends the current number of results to the link's title — turning "Messages"
into "Messages (12)", "Approvals" into "Approvals (3)", and so on.

The problem it solves is at‑a‑glance status in the navigation. Editors and end users
often want to know how many items are waiting behind a link — unread messages,
pending approvals, tasks in a queue — without clicking through. Because the count
comes from a View you already control, it always reflects the same query and filters
as the page the link leads to.

Setup happens per menu link — there's no central settings page. On each link you
choose the View and display to count and, optionally, a **count limit** to cap the
badge (for example, showing "99+"). It depends on core's **Views** module and
provides a permission. Two things to keep in mind: the counted View's pager settings
affect the number reported (some pagers don't return the full row count), and the
badge follows the View's caching, so a frequently changing count can invalidate menu
caches more often.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no central settings page** for this module. You configure the count per
menu link, described in "How to use it" below.

## How to use it

1. Go to **Structure → Menus** (`/admin/structure/menu`), open a menu, and add or
   edit a link.
2. In the **View count** section, select the **View** and **display** whose results
   you want counted.
3. Optionally set a **count limit** to cap the badge (for example, to show "99+"
   instead of a large exact number).
4. Save the menu link. The link title will now render with the count appended.

### Getting an accurate count

Some pagers don't provide the full number of rows, which would also limit the badge.
For the counted View's pager, use one of:

- **Display a specified number of items**, set higher than any count limit you plan
  to use on the menu item; or
- **Display all items** if you're not using a count limit — and keep the View as
  lean as possible (few columns) for performance.

### Styling and performance

- To style the badge, target `ul.menu li.has-count > a` and
  `ul.menu li.has-count > a .count` in your theme's CSS.
- Counts follow the View's cache handling. If a rapidly changing count causes menu
  caches to invalidate too often, consider
  [Views Custom Cache Tags](https://www.drupal.org/project/views_custom_cache_tags).
