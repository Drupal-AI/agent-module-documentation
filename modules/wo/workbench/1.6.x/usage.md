Workbench gives content editors a personalized "My Workbench" dashboard — a single landing page (plus a toolbar tab and sub-tabs) that surfaces the content they created, edited, or can access, powered by Views.

---

Workbench provides a simplified content-management area at `/admin/workbench` aimed at non-technical editors, so they do not need to learn `/user`, `/node/add`, and `/admin/content` separately. It adds a **Workbench** toolbar item (via `hook_toolbar()`) that links to the "My Workbench" overview, which shows three regions: the current user's profile (`workbench_current_user`), their most recent edits (`workbench_edited`), and recent content (`workbench_recent_content`). Sub-tabs give full, filterable/sortable Views pages for **My edits** (`/admin/workbench/content/edited`), **All recent content** (`/admin/workbench/content/all`), and a **Create content** tab (`/admin/workbench/create`) that emulates core's `node/add`. All page regions are driven by Views: an admin form at `/admin/config/workflow/workbench` (route `workbench.admin`, permission `administer workbench`) lets you assign any View + display to each of the five regions (`overview_left`, `overview_right`, `overview_main`, `edits_main`, `all_main`), stored in the `workbench.settings` config object. Access to the whole area is gated by the `access workbench` permission. Developers can replace or restyle the regions in code with `hook_workbench_content_alter()` and `hook_workbench_create_alter()`, and can add status messages to a Workbench information block via `hook_workbench_block()`. Workbench ships three Views and is the base of the wider Workbench suite (Workbench Access, Content Moderation) that turns it into a full editorial workflow system. It depends on core `image`, `node`, `toolbar`, `user`, and `views`.

---

- Give editors a single "My Workbench" dashboard instead of separate account, add-content, and find-content pages.
- Show a logged-in editor the content they most recently edited on their landing page.
- List all recent site content in one sortable, filterable Views page.
- Add a "Workbench" tab to the admin toolbar linking editors to their workspace.
- Provide a "Create content" tab that lists the node types the user may create (like `node/add`).
- Filter the My edits / All recent content lists by title keywords, content type, published status, and items per page.
- Sort content lists by clicking column headers, with edit links on each row.
- Configure which View + display powers each of the five Workbench regions via the settings form.
- Swap the default "Recent content" region for a custom View without writing code.
- Restrict who sees the Workbench area using the `access workbench` permission.
- Restrict who can change the region-to-View mapping using the `administer workbench` permission.
- Replace a Workbench region entirely with a custom render array via `hook_workbench_content_alter()`.
- Point a Workbench region at a different View display (e.g. `custom_view:block_2`) from a custom module.
- Alter the Create content tab output via `hook_workbench_create_alter()`.
- Surface contextual editorial status messages in a block via `hook_workbench_block()`.
- Place the "Workbench information" block (id `workbench_block`) in a region so modules can inject notices.
- Serve as the editorial landing page for a content team on a large site.
- Give new, non-technical users a gentler on-ramp than the raw Drupal admin UI.
- Act as the base module for the Workbench suite (Workbench Access, Content Moderation) to add access control and moderation.
- Export the Workbench region configuration between environments as `workbench.settings` config.
- Reuse the shipped Views (`workbench_current_user`, `workbench_edited`, `workbench_recent_content`) as starting points for custom editor dashboards.
- Give editors quick access to their own profile alongside their content.
- Provide a "content contributor" experience without exposing full site administration.
- Let a site builder rearrange the dashboard by assigning Views blocks/embeds to the overview left/right/main regions.
