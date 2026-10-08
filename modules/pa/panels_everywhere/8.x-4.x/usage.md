<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Panels Everywhere uses the Panels architecture to lay out the entire page — header, footer, sidebars and content are all blocks in one Page Manager variant — instead of the theme's `page.html.twig`.

---

Install the module (via `composer require drupal/panels_everywhere` or the UI), which pulls in its dependencies **Panels**, **Page Manager**, **CTools' `ctools_block`** and core **`layout_discovery`**; also enable core **Page Manager UI** (`page_manager_ui`) so you can edit the page. The module installs a Page Manager page called **Site template** at `/admin/structure/page_manager`, but it is **disabled by default**, so nothing changes until you enable it. Edit that page's *Panels Everywhere* variant, pick a **layout**, and add blocks to its regions — crucially the **"Main Page Content"** block, which is the pane each route's own output is injected into, plus whatever else the shell needs (page title, messages, menus, branding). Once enabled, the variant is applied to **every non-admin route**: Panels wraps the original page content rather than replacing it, because the module strips the route override Page Manager would otherwise add. The variant exposes one Panels-Everywhere-specific option, **"Enable page-manager route override"** (config key `route_override_enabled`, default off) — leave it off to *wrap* a route (normal use), turn it on to have the variant *replace* a route entirely. Admin pages are always skipped and keep the theme's normal page. Because taking the page shell away from the theme breaks anything that assumes the theme's regions (contrib blocks, theme preprocess, toolbar, status messages), verify those after switching. This is the older Panels/Page Manager approach — core's maintained alternative is **Layout Builder** — so it best suits sites already committed to the Panels stack. Documented release **8.x-4.0-beta4** (beta) on core `^9.2 || ^10 || ^11`.

---

- Lay out an entire page — not just the content region — with Panels.
- Replace the theme's `page.html.twig` region rendering with a Panels variant.
- Move page structure decisions out of the theme and into the Page Manager UI.
- Let site builders arrange headers, footers and sidebars without editing templates.
- Enable the shipped `site_template` page to apply a Panels shell site-wide.
- Add the "Main Page Content" block so route output is wrapped, not replaced.
- Keep a route's original content while decorating it with Panels regions.
- Turn on `route_override_enabled` to have a variant fully replace a specific route.
- Give one section its own page shell via an additional Page Manager page.
- Choose a layout (e.g. `layout_onecol`) for the whole-page arrangement.
- Place blocks for page title, messages, menus and branding into shell regions.
- Use Panels' in-place editor (IPE) to arrange the page shell visually.
- Vary the page structure per page/route instead of per theme template.
- Keep admin pages on the normal theme (admin routes are always skipped).
- Migrate a legacy Drupal 7-era Panels Everywhere site to Drupal 9/10/11.
- Maintain an existing Panels-based site architecture.
- Build page variants without writing template files.
- Run the module's update path to convert old layout ids to layout_discovery.
- Combine Panels layouts with Page Manager selection criteria for the shell.
- Provide a Panels-controlled full-page layout on a Panels-committed site.
