Page Manager lets site builders create custom pages at any path and control what renders there through selectable "variants" (blocks, Layout Builder, Panels, or an HTTP status code), including taking over core routes like the node view page.

---

Page Manager, once part of the CTools suite, manages `page` config entities: each page owns a path (with typed parameters such as `{node}`), optional access conditions, and one or more `page_variant` entities. When the page is requested, Page Manager evaluates each variant's selection criteria (context/condition plugins — role, path, language, entity bundle, etc.) in weighted order and renders the first one that matches, falling back to the next if none apply. Variants are DisplayVariant plugins: the built-in `block_display` places blocks into a chosen layout region-by-region, `http_status_code` returns a status like 403/404, and `layout_builder` hands off to core Layout Builder; the contrib Panels module adds a drag-and-drop layout variant. Pages can override existing routes — the shipped `node_view` example page replaces `/node/{node}` — using a variant route filter that only takes over when a variant matches. Contexts (current user, route parameters, interface language, plus static contexts you define) are exposed to variants and their blocks via event subscribers. Everything is stored as exportable configuration, so pages move between environments with the config system. The main module is API/engine only; the **Page Manager UI** submodule provides the wizard at Structure → Pages for building pages without code. It depends on Block and CTools.

---

- Create a brand-new page at a custom path with blocks placed in a layout.
- Override the default `/node/{node}` page with a custom block layout.
- Take over `/user/{user}` to build a custom profile page.
- Return a 403 or 404 status code for a matched route via a variant.
- Show different page layouts to different user roles (selection criteria).
- Serve a variant only on a specific path or path pattern.
- Vary a page's content by interface language.
- Render one variant for a content type and another as a fallback.
- Build a landing page composed entirely of blocks.
- Use core Layout Builder as a page's display variant.
- Use the Panels module for drag-and-drop layouts on a page.
- Pass the node/user from the URL as context into placed blocks.
- Define static contexts (e.g. a fixed entity) available to all variants.
- Add access conditions so only authorized users can view a page.
- Expose the current user as a context for personalized blocks.
- Order multiple variants by weight to control match precedence.
- Export custom pages as configuration and deploy across environments.
- Replace a view or controller output with a managed page.
- Provide a maintenance/holding page for a specific route.
- Add typed route parameters (e.g. `{node}`) with upcasting to entities.
- Build a decoupled admin-style dashboard page from blocks.
- Create per-section homepages selected by condition.
- Add a custom DisplayVariant plugin for bespoke rendering.
- Migrate legacy CTools/Panels pages into config-based pages.
- Reorder variants and edit access rules through the Page Manager UI wizard.
