<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Single Page Site (single_page_site) — agent index

Renders every renderable item of a chosen **menu** onto one page via internal sub-requests and
rewrites the menu links to in-page **anchors**. Package `Design`. Version **3.0.0**.
Core `^11 || ^12`. License GPL-2.0-or-later. Depends on core **`menu_link_content`**.
Optional integration with **Link Attributes** (`link_attributes`) for per-item inclusion.

- **Install, config form, config object + schema keys, routes & permissions** →
  [config/settings.md](config/settings.md)
- **Runtime: controller, manager, sub-request rendering, JS libraries, template** →
  [api/rendering.md](api/rendering.md)
- **The `EventSinglePageSiteAlterOutput` output-alter event (extension point)** →
  [api/events.md](api/events.md)
- **Submodule Single Page Site Next Page** →
  [../../modules/single_page_site_next_page/3.0.x/agent/start.md](../../modules/single_page_site_next_page/3.0.x/agent/start.md)

## What it actually is

- **Routes** (`single_page_site.routing.yml`):
  - `single_page_site.config` → `/admin/config/system/single-page-site`, form
    `Form\SinglePageSiteConfigForm`, perm `administer single page site`.
  - `single_page_site.page` → `/single-page-site`, controller
    `Controller\SinglePageSiteController::render`, perm `view single page site`.
- **Permissions** (`single_page_site.permissions.yml`): `administer single page site`,
  `view single page site`.
- **Service** `single_page_site.manager` = `Manager\SinglePageSiteManager` — reads config, loads
  the menu tree, generates anchors, and runs the per-section sub-request.
- **Hook class** `Hook\SinglePageSiteHooks` (attribute `#[Hook]`): `help`, `theme`
  (`single_page_site` → `templates/single-page-site.html.twig`), `page_attachments`
  (attaches the menu-rewrite JS on every page), and
  `form_menu_link_content_menu_link_content_form_alter` (blocks adding the single page / front
  page into the source menu).
- **Event** `SinglePageSiteEvents::SINGLE_PAGE_SITE_ALTER_OUTPUT` (`single_page_site.alter_output`)
  dispatched with `Event\EventSinglePageSiteAlterOutput` after each section renders.
- **Config object** `single_page_site.config` (schema `config/schema/single_page_site.schema.yml`).
  No `config/install` — defaults come from the form. Uninstall clears `state('single_page_site_settings')`.
- **JS libraries** (`single_page_site.libraries.yml`): `.menu` (link rewriting, always attached),
  `.scrollspy` (+ bundled `js/lib/jquery.scrollspy.js` + `.jquery_compat` shim), `.scroll`
  (smooth scroll). No entity type, no plugin type, no Drush.

## Mechanism (short)

`render()` bails to a "configure me" message if no menu is set. Otherwise it loads the menu tree
(`getMenuChildren()`, enabled links only, sorted), and for each item that
`isMenuItemRenderable()` accepts it builds the item's `Url`, derives an anchor with
`generateAnchor()`, calls `executeAndRenderSubRequest()` to render that path, dispatches the
alter-output event, and appends `{output, anchor, title, tag}` to the `#theme => 'single_page_site'`
build. Sub-requests run through the HTTP kernel as the current user (core access checks apply).
See [api/rendering.md](api/rendering.md).
