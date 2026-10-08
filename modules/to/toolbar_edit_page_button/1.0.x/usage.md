<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Toolbar Edit Page Button adds an item to Drupal's administration toolbar that links to the edit form of the node you are currently viewing.

---

Install it like any contributed module (`drush en toolbar_edit_page_button`); it needs no other modules beyond core, though it only does anything while the core **Toolbar** and **Node** modules are enabled. There is **no configuration page** — behaviour is controlled entirely by one permission, **`access toolbar edit page button`**, which you grant per role at `/admin/people/permissions`. Any user with that permission who is looking at a node's page then sees an **Edit Page** tab in the toolbar; the node's id is shown in parentheses next to the label (for example `Edit Page (42)`) so editors can confirm which node they are about to open, and the tab links straight to `/node/<nid>/edit`. The button appears on **node pages only** — not on views, taxonomy term pages, user profiles, the front page or other routes — and it is gated by the module's own permission rather than by per-node edit access, so on a node the user cannot actually edit the link simply lands on Drupal's normal access-denied page (the link grants no extra access; core's edit route enforces its own). No node parameter or missing permission produces a hidden placeholder instead of a visible button. If you want the button to stand out you can style it in your theme's CSS by targeting `a[href^="/node/"].toolbar-icon-edit.toolbar-item`, for instance giving it a background colour; the module ships no CSS itself.

---

- Give editors a one-click jump from a node to its edit form.
- Add an always-visible "Edit Page" control to the admin toolbar.
- Avoid hunting for the local task "Edit" tab on front-end themes that hide or bury it.
- Replace fragile contextual-link hovering with a fixed button.
- Speed up an editorial review-and-fix workflow.
- Edit a node reliably on a touch device where hover controls fail.
- Cut down navigation back to the admin content listing to find a page.
- Show the current node id (nid) next to the edit link so editors confirm the target.
- Provide a consistent edit shortcut in the same place on every node page.
- Grant the shortcut to specific roles via `access toolbar edit page button`.
- Restrict the button to trusted editors by withholding that permission.
- Orient first-time editors who do not know Drupal's contextual/tab controls.
- Mirror the familiar WordPress "Edit" button placement for migrating teams.
- Style the button (e.g. a coloured background) purely from theme CSS.
- Keep core tabs and Quick Edit intact while adding a toolbar shortcut.
- Reduce the number of clicks per content edit.
- Support editors working across a site with moderation and translation tabs.
- Offer an edit entry point that does not depend on the current theme's tab layout.
- Let reviewers open a page's edit form directly from the page itself.
- Provide a low-risk, config-free editorial convenience with a single permission to manage.
