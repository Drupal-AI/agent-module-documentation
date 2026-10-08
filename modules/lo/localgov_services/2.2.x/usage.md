<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
LocalGov Services: Core is the foundation of the LocalGov Drupal service model. It installs the service landing and sub-landing content types, a dedicated services menu, and the pathauto patterns that make service URLs mirror the section tree, and it ships a services call-to-action block plus a "link with type" field widget. The richer behaviour — page and status content types, and the navigation that links pages into a service — lives in its five submodules.

---

Councils organise content around *services* — "Bins and recycling", "Parking" — each with a landing page, sub-sections beneath it, and many detail pages that share one navigation tree. This core module supplies the shared skeleton: it installs the `localgov_services_landing` and `localgov_services_sublanding` node types, the `localgov-services-menu` system menu, and two pathauto patterns (a plain `[node:title]` alias for landing pages and a `localgov_services_hierarchy` pattern that nests page and sub-landing URLs under their parent service). It also provides the `localgov_service_cta_block` "call to action" block, which renders the buttons stored in a node's `localgov_common_tasks` link field, and the `link_with_type` widget that lets editors tag each of those links as an action or an informational link. Content is joined into a service through the `localgov_services_parent` entity-reference field and its `localgov_services` selection handler (provided by the `localgov_services_navigation` submodule), which also drives the hierarchy pathauto opt-in and a drag-and-drop child-ordering UI on landing forms. As its own description notes, the base module "won't do anything on its own" — you enable the submodules you need: landing, sub-landing, page, navigation and the optional status pages. It depends on `localgov_core` and `pathauto`; search of services comes from `localgov_search`, which is only a test dependency here.

---

- Publish a council's services in a consistent landing-page structure.
- Give each service a top-level landing page with sub-sections beneath it.
- Add second-level sub-landing pages for large services.
- Share one navigation tree across every page of a service.
- Generate service page URLs that automatically nest under their parent service.
- Alias landing-page URLs from just the page title.
- Attach an arbitrary content type into a service section via the `localgov_services_parent` field.
- Show a row of call-to-action buttons at the top of a service page.
- Let editors mark each service link as an "action" or "information" link.
- Reorder the child pages that appear under a landing page by drag and drop.
- Place a services menu block in the secondary-menu region.
- Group the four service "add content" links under one admin-toolbar menu item.
- Point a landing page's destinations at any bundle that opts into services.
- Publish optional service-status updates (e.g. "collections delayed") via the status submodule.
- Enable only the parts of the service model a site actually needs.
- Provide a predictable information architecture for residents.
- Keep pathauto patterns for services in version-controlled configuration.
- Migrate a legacy council site into a service-oriented structure.
- Combine services with LocalGov directories, guides and step-by-step content.
- Rename a legacy `localgov_services_menu` menu to the hyphenated machine name via update hook.
- Build a custom node-context block by extending the module's `ServicesBlockBase`.
- Keep service navigation consistent across editorial teams and councils.
