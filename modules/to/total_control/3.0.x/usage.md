Total Control ships a ready-made administration **dashboard** at `/admin/dashboard` — a Page Manager (Panels) page pre-populated with overview stats, quick admin links, and content/user listing panes — giving site admins one central place to run the site.

---

Total Control installs a Page Manager page `total_control_dashboard` (path `/admin/dashboard`,
one Panels variant) and a set of **Dashboard-category block plugins** used as its panes:
`content_overview`, `create_content`, `administer_content_types`, `administer_menus`,
`administer_taxonomy`, `administer_panel_pages`, and `total_control_dashboard`. It also provides
Views for the fuller listings — `control_content` (full content admin with bulk ops at
`/admin/dashboard/content/all`), `control_users` (`/admin/dashboard/users`), their `*_panes`
display variants embedded on the dashboard, plus `control_terms` (`/admin/dashboard/categories`,
added when Taxonomy is on) and `control_comments` (added when the Comment module is enabled — the
module copies standard comment config into place on install / on enabling comment). Access to the
dashboard and its view pages is gated by the single permission **`have total control`** (a route
subscriber stamps it onto the Page Manager route). It requires `page_manager`, `panels`, `ctools`,
`block`, `views`, and `contextual`, and adds a Dashboard menu link and dynamic local tasks
(Dashboards / Comments / Categories tabs). You customise it by editing the panes (cog wheel /
*Structure → Pages*) or overriding the supplied views (*Structure → Views*); there is no dedicated
settings form. It has no config schema of its own — everything is Page Manager pages, Panels
variants, Views, and block placements.

---

- Give administrators a single `/admin/dashboard` landing page for running the site.
- Show at-a-glance site stats and recent content/users on login.
- Provide quick "create content" links for every content type from one pane.
- List and manage all content with bulk operations via the `control_content` view page.
- List and manage users via the `control_users` view page.
- Offer quick links to administer content types, menus, taxonomy, and panel pages.
- Grant a non-superuser admin role dashboard access with the `have total control` permission.
- Add a taxonomy terms overview (`control_terms`) at `/admin/dashboard/categories`.
- Add a comments overview (`control_comments`) once the Comment module is enabled.
- Customise which columns/filters a dashboard listing pane shows by editing its view.
- Rearrange or reconfigure dashboard panes through Page Manager / Panels.
- Replace a default pane with a custom block in the Panels variant.
- Embed the Total Control panes (e.g. `content_overview`) as blocks elsewhere via Block layout.
- Build a curated editor dashboard by cloning the Page Manager page.
- Use the dynamic local-task tabs to jump between Dashboard, Comments, and Categories.
- Provide a menu link to the dashboard for admins.
- Override the supplied views to match a site's own content model.
- Centralise scattered Drupal admin destinations behind one page.
- Restrict the dashboard to specific roles by scoping the `have total control` permission.
- Extend the dashboard with additional Panels panes (any Dashboard-category block).
- Serve as a starting template for a bespoke admin dashboard.
