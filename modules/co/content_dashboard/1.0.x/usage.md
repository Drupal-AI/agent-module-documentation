<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Personalized Content Dashboard offers a role-personalized page of links to content, media and admin listings.

---

Personalized Content Dashboard adds one page at **`/admin/content-dashboard`** (and a "My Dashboard" toolbar tab)
that gathers links to the core admin listings an editor uses most: each content type's filtered content list,
each media type's media list, and admin pages such as the users list, webforms, taxonomies and site settings.
It renders **only links — no node data, counts or charts**. Each item appears only when the current user passes
the matching permission or access check, so the page is personalized by role. It defines one permission,
`access content dashboard`, and has no settings form.

Use it to give editors a single jumping-off point for day-to-day content work. It is an administration/editorial
navigation aid: the dashboard is gated by its permission, and every link is shown subject to the relevant core
access check (node create access per type, `access media overview`, `access user profiles`, and so on). It has no
access-control role of its own beyond that permission.

---

- Offer a role-personalized dashboard of admin links.
- Give editors one jumping-off page for content work.
- Link to each content type's filtered content list.
- Link to each media type's media list (add link included).
- Link to users, webforms, taxonomies and site settings.
- Show each link only when the user passes its access check.
- Add a "My Dashboard" toolbar tab.
- Gate the dashboard by the `access content dashboard` permission.
- Render links only — no counts, data or charts.
- Provide its own permission.
- Add no settings form.
- Sort content types by label.
- Personalize sections by role.
- Redirect the superuser login to the dashboard.
- Relabel the "Add content/media" action button.
- Respect core access on every linked listing.
- Have no access-control role beyond its permission.
- Depend only on Drupal core.
- Work for Drupal 9, 10 and 11.
- Enable and grant the permission to use it.
- Reach it at `/admin/content-dashboard`.
